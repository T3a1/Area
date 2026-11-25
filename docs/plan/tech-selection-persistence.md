# Technology selection: persistence

> 🇫🇷 [tech-selection-persistence.fr.md](tech-selection-persistence.fr.md) · Status: **Draft: scores provisional until the spikes are done (target 26/11)** · Owner: Léandre (with David for security and backups)

## 1. Need

What we store and what it implies:

| Data | Shape | Constraint |
|---|---|---|
| Users, local credentials (password hashes), external identities (OIDC `sub` + issuer) | Relational, strongly linked | Unique constraints, cascade on account deletion |
| Service subscriptions and **delegated OAuth tokens** | Relational + secret | Must be encrypted at rest (SEC-CRYPTO), never logged |
| Workflow definitions (variable number of nodes, one optional condition, key-path mappings) | Tree/graph, semi-structured | Validated on save, versioned, queried by trigger type |
| Hook state and **seen external events** | Append-heavy | **Deduplication**: the same occurrence must never trigger twice |
| Runs and node executions (inputs, outputs, outcome) | Append-only | Queried for history, monitoring, retries / dead letters (ENG-RETRY) |

Key insight: the hard part is not storing JSON, it is **concurrency and exactly-once-ish processing** (hooks polling in parallel, retries without duplicate side effects).

## 2. Candidates

| Candidate | Why it is on the list |
|---|---|
| **PostgreSQL** | Relational integrity + `JSONB` for workflow definitions; `SELECT … FOR UPDATE SKIP LOCKED` lets the database act as a simple job queue; unique indexes for deduplication; `pg_dump` / `pg_restore`. |
| **MongoDB** | Document model maps naturally to workflow definitions; flexible schema; popular in Node.js projects. |
| **MySQL / MariaDB** | Mature relational database, JSON column type, `SKIP LOCKED` since MySQL 8. |

Redis is not a primary store candidate: it may be added later as a cache or queue (ENG-ASYNC not selected).

## 3. Criteria and weights

| # | Criterion | Weight | Measure |
|---|---|---|---|
| P1 | Integrity: transactions, foreign keys, unique constraints | 3 | Spike: account deletion cascades, constraint violations |
| P2 | Concurrency primitives for hooks / dedup / retries | 3 | Spike steps 2–3: two workers, duplicate event insert |
| P3 | Security (roles, TLS, auth, encryption options, CVE track record) | 3 | Default config review in spike |
| P4 | Storage of variable-shape workflow definitions | 2 | Spike step 1 |
| P5 | Driver / ORM support with the back-end (TypeScript) | 2 | Prisma/Drizzle/TypeORM support observed |
| P6 | Backup and restore tooling | 2 | Spike step 4 |
| P7 | Docker operations simplicity | 1 | Official image, healthcheck |

## 4. Comparison (provisional)

| Criterion (weight) | PostgreSQL | MongoDB | MySQL/MariaDB |
|---|---|---|---|
| P1 Integrity (3) | 5 | 3 | 5 |
| P2 Concurrency (3) | 5 | 3 | 4 |
| P3 Security (3) | 5 | 4 | 4 |
| P4 Variable shapes (2) | 4 | 5 | 3 |
| P5 ORM support (2) | 5 | 4 | 4 |
| P6 Backup/restore (2) | 5 | 4 | 4 |
| P7 Docker (1) | 5 | 5 | 5 |
| **Weighted total (max 80)** | **78** | **61** | **66** |

## 5. Practical evidence

| Spike | Folder | Steps reached | Notes |
|---|---|---|---|
| PostgreSQL | `spikes/db-postgresql/` | _to fill_ | |
| MongoDB | `spikes/db-mongodb/` | _to fill_ | |
| MySQL | `spikes/db-mysql/` (optional, if time allows) | _to fill_ | |

## 6. Decision (provisional)

**PostgreSQL 16**, with workflow definitions in `JSONB` (validated by the server before saving) and everything else relational.

Why: our data is mostly relational and our hardest problem (deduplicating events, picking work concurrently, retries) is solved by database primitives (`UNIQUE (hook_id, external_event_id)`, `SKIP LOCKED`, transactions), which removes the need for a broker.

Accepted costs:
- Schema migrations are required for every change: slower iteration than MongoDB; mitigated by an ORM with migration tooling.
- `JSONB` content is not constrained by the database: the server validator is the only guard; mitigated by save-time validation tests.
- Using the database as a queue does not scale to very high throughput: acceptable for our load; ENG-ASYNC could replace it later.

See ADR [0003](../adr/0003-persistence.md).
