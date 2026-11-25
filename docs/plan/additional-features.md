# Additional features: selection

> 🇫🇷 [additional-features.fr.md](additional-features.fr.md) · Status: **Selected by the team on 2026-11-23** (revisable once, at the MVP milestone on 2026-12-14)

## Summary

| Id | Topic | Difficulty | Domain | Owner | Observable at MVP? |
|---|---|---|---|---|---|
| ENG-ADR | Architecture decision records | 1 | Software engineering | Romane | ✅ yes |
| ENG-EXT | Extensible connectors | 2 | Software engineering | Léandre | 🟡 partly (node interface + registry) |
| ENG-RETRY | Retries and idempotency | 2 | Software engineering | Thomas | ❌ after MVP |
| SEC-CRYPTO | Encryption at rest | 2 | Security | David | 🟡 partly (tokens encrypted) |
| SYS-HEALTH | Health checks | 1 | Systems | Romane | ✅ yes |
| SYS-SECRETS | Secrets management | 1 | Systems | David | ✅ yes |
| **Total D** | | **9** | 3 domains | | ≥ 3 points at MVP (1/3 of 9) |

Requirement: **D ≥ 2 × M = 8**. We take **9** to keep a one-point margin: a feature that is not fully delivered counts for nothing.

## Selection rationale

1. **Synergy with the common base.** Every selected feature strengthens something the common base already requires: ADRs (documented decisions), HOWTOCONTRIBUTE.md (ENG-EXT), OAuth token storage (SEC-CRYPTO), Docker Compose configuration (SYS-SECRETS), autonomous hooks (SYS-HEALTH, ENG-RETRY). Little effort is spent on features that live beside the product.
2. **Three domains.** Engineering, security and systems, as the subject recommends.
3. **Against our weaknesses, not for comfort.** Owners are deliberately placed outside their main area where possible: Romane (UI/UX) owns two server/process features; Thomas (mobile) owns the retry engine.
4. **Risk.** No difficulty-3 feature: the MVP arrives three weeks after the start, and a failed large feature would cost 3 points at once. AI-NODE (3) is kept as a candidate for the one allowed revision at the MVP.

## Per feature: learning goal and acceptance criteria

### ENG-ADR (1): Romane
*Learning*: write down a decision so that someone absent can restate it and its cost.
- [ ] ≥ 3 significant ADRs, one about the **workflow engine**, each saying why it deserved a record.
- [ ] Each has context, real alternatives, decision, accepted consequences.
- [ ] Rejected alternatives rejected *for this project*.
- [ ] Dated, with status; superseded ones point to their replacement.
- [ ] Any member can describe the product under a rejected option.
*Where observed*: `docs/adr/`.

### ENG-EXT (2): Léandre
*Learning*: design a plugin boundary (interface + registry) that keeps the engine closed to modification.
- [ ] Common documented node interface (validation + execution).
- [ ] Node types registered at start-up, no dynamic loading of third-party code.
- [ ] The commit adding the last node type touches only the node and its registration.
- [ ] `HOWTOCONTRIBUTE.md` procedure; a trivial node is added live during the defense.
- [ ] New Action/REAction appears in `about.json` without a second catalogue.
*Where observed*: `server/src/nodes/`, git history, `HOWTOCONTRIBUTE.md`, `GET /about.json`.

### ENG-RETRY (2): Thomas
*Learning*: understand how retry, persistence and idempotence depend on each other.
- [ ] Bounded automatic retries with growing delays, stated in advance.
- [ ] No broker required.
- [ ] Side-effecting REActions protected against duplicates (idempotency key per run + node + attempt scope).
- [ ] Dead-letter store, inspectable and replayable.
- [ ] Evaluator removes the cause and replays a dead-lettered run successfully.
- [ ] Policy (attempts, delays) is configuration.
*Where observed*: `server/src/engine/retry`, dead-letter API + web view, configuration file.

### SEC-CRYPTO (2): David
*Learning*: authenticated encryption, key management and rotation.
- [ ] Demonstrate what a database dump exposed **before** encryption.
- [ ] Third-party tokens encrypted with an authenticated cipher (AES-256-GCM); evaluator reads ciphertext.
- [ ] Key outside source, repository and database; provisioning documented.
- [ ] No token (clear or encrypted) in logs of a full AREA run.
- [ ] Key rotation documented (key id stored with each ciphertext).
- [ ] One altered byte → token rejected.
*Where observed*: `docs/security/SEC-CRYPTO.md` (evidence template), `psql` session, logs.

### SYS-HEALTH (1): Romane
*Learning*: dependency modelling and bounded checks.
- [ ] `GET /health` reports database, OIDC providers and hook scheduler separately (JSON).
- [ ] Failing required dependency → failing status (HTTP 503).
- [ ] Stopping the database container is identified.
- [ ] Answers within 1 s even when a dependency is unreachable.
- [ ] No secret, connection string or stack trace exposed.

### SYS-SECRETS (1): David
*Learning*: secret hygiene across code, history, images and logs.
- [ ] Secret scanning (gitleaks) over content and history is clean, in CI.
- [ ] Complete `.env.example` with descriptions and harmless placeholders.
- [ ] Fresh clone + `.env` from the example starts the product.
- [ ] Secrets via environment only, never baked in images.
- [ ] No secret in any service log (grep a full run).

## Revision policy
The selection may be revised **once**, at the MVP (2026-12-14). Candidates if a feature turns out harder than expected: AI-NODE (3), SEC-DEPS (1), SYS-BACKUP (2). Any difficulty surprise is reported to the local manager immediately and noted for the post-mortem.
