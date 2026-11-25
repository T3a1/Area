# 0003. Persistence

- **Status**: Proposed (to be accepted after the persistence spikes, target 2026-11-26)
- **Date**: 2026-11-23
- **Why this deserves a record**: hook deduplication, retries and token security all rely on what the database guarantees.

## Context
See [tech-selection-persistence.md](../plan/tech-selection-persistence.md). Mostly relational data, variable-shape workflow definitions, concurrent hook processing that must never handle the same event twice.

## Alternatives considered
- **MongoDB**: best fit for storing workflow documents; rejected for this project because users, identities, tokens and runs are relational and our hardest problem is concurrency, where we would rebuild in code what PostgreSQL provides.
- **MySQL/MariaDB**: close to PostgreSQL; rejected because JSON support and team familiarity with PostgreSQL tooling are weaker.

## Decision
**PostgreSQL 16**: relational schema, workflow definitions in `JSONB`, `UNIQUE (hook_id, external_event_id)` for deduplication, `SELECT … FOR UPDATE SKIP LOCKED` for picking work.

## Consequences
- ➕ No broker needed for hooks and retries (ENG-RETRY explicitly does not require one).
- ➕ `pg_dump`/`pg_restore` simplify backups.
- ➖ Every schema change needs a migration; accepted, handled by the ORM.
- ➖ The database becomes the queue: throughput limited and a DB outage stops everything; accepted at our scale and made visible by SYS-HEALTH.
