# 0001. Record architecture decisions

- **Status**: Accepted
- **Date**: 2026-11-23
- **Why this deserves a record**: it defines how every other decision is documented and defended (ENG-ADR, individual defenses).

## Context
The subject requires documenting important architectural decisions "including alternatives considered, consequences and later revisions", and each member must defend one decision they contributed to. Decisions spread across chat messages are lost and cannot be defended.

## Alternatives considered
- **A single "architecture.md" document**: easy to write, but revisions overwrite history; rejected because we must show how decisions changed.
- **Wiki (GitHub Wiki / Notion)**: lives outside the repository and outside code review; rejected because evaluators read the repository.

## Decision
We keep ADRs in `docs/adr/`, one per decision, in English and French, with the format described in the [README](README.md). An ADR is added in the same pull request as the change it justifies.

## Consequences
- ➕ Decisions are reviewed like code and versioned with it.
- ➕ Supersession is explicit, which feeds the MVP "plan changes" analysis and the post-mortem.
- ➖ Writing and translating each record costs time (≈30 min per ADR); we accept it and keep records short.
