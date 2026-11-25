# 0002. Back-end framework

- **Status**: Proposed (to be accepted after the back-end spikes, target 2026-11-26)
- **Date**: 2026-11-23
- **Why this deserves a record**: the server holds all business logic and the OpenAPI contract; changing it later means rewriting most of the product.

## Context
See [tech-selection-backend.md](../plan/tech-selection-backend.md). Needs: OpenAPI served and contract-tested, OIDC + OAuth2 libraries, background hooks, extensible service modules, a 3-week MVP with four students who know TypeScript.

## Alternatives considered
- **ASP.NET Core**: strongest on maturity, performance and built-in auth; rejected *for now* because only one member knows C# and the web client will be TypeScript, so the team would work in two languages on the critical path. Would be chosen if the spikes show equal velocity.
- **FastAPI**: fastest OpenAPI story; rejected for this project because persistent background jobs and large-project structure need more assembly.

## Decision
**NestJS** (TypeScript, Node.js LTS), OpenAPI via `@nestjs/swagger`, DTO validation with `class-validator`, one Nest module per service.

## Consequences
- ➕ One language shared with the web client; generated typed client.
- ➕ Module/provider pattern supports a node registry without touching the engine (ENG-EXT).
- ➖ Large npm dependency tree increases supply-chain risk; we accept it with lockfiles, `npm audit` and Dependabot in CI.
- ➖ Decorator-based OpenAPI can drift from behaviour; we accept it and add a contract test in CI.
