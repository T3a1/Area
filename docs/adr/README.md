# Architecture Decision Records

> 🇫🇷 [README.fr.md](README.fr.md)

One file per significant decision, numbered in order: `NNNN-<slug>.md` (English) and `NNNN-<slug>.fr.md` (French).

Format (adapted from Michael Nygard's template and MADR):

- **Status**: `Proposed` → `Accepted` → (`Deprecated` | `Superseded by NNNN`). A superseded record is never deleted; it links to its replacement.
- **Date** of the last status change.
- **Why this deserves a record**: one sentence (required by ENG-ADR).
- **Context**: the forces at play, for *this* project.
- **Alternatives considered**: real options, rejected *for this project*, not declared universally bad.
- **Decision**.
- **Consequences**: positive and **at least one negative consequence we accept**.

| # | Title | Status |
|---|---|---|
| [0001](0001-record-architecture-decisions.md) | Record architecture decisions | Accepted |
| [0002](0002-backend-framework.md) | Back-end framework | Proposed |
| [0003](0003-persistence.md) | Persistence | Proposed |
| [0004](0004-mobile-client.md) | Android client technology | Proposed |
| [0005](0005-web-client.md) | Web client technology | Proposed (open) |

Planned before MVP: workflow engine model (linear chain + one condition, key-path substitution), hook event deduplication, OAuth token storage and encryption.
