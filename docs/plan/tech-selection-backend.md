# Technology selection: back-end

> 🇫🇷 [tech-selection-backend.fr.md](tech-selection-backend.fr.md) · Status: **Draft: scores are provisional until the spikes are done (target 26/11)** · Owner: Léandre

## 1. Need

The application server holds **all business logic**: accounts, local + OIDC authentication, OAuth2 service subscriptions and token storage, the service catalogue (`about.json`), workflow validation, the execution engine, and **hooks that run without any client open**. It must serve an **OpenAPI description** that is the contract with two independently developed clients, and tests must fail when implementation and description disagree.

Consequences for the choice:
- OpenAPI must be a first-class citizen (generated from code or validated against code).
- Background scheduling (polling hooks) and, later, retries must be easy.
- Mature, maintained libraries for OIDC, OAuth2, password hashing, input validation, rate limiting.
- Four students, three weeks to an MVP: learning curve matters.

## 2. Candidates

| Candidate | Why it is on the list |
|---|---|
| **NestJS** (TypeScript, Node.js) | Team already knows TypeScript; modular architecture (modules / providers) maps well to "one module per service"; `@nestjs/swagger` generates OpenAPI from decorators; `@nestjs/schedule`, BullMQ integration. |
| **ASP.NET Core** (C#) | One member already used it; built-in OpenAPI support, strong typing, excellent performance, mature identity/auth middleware, Hangfire/Quartz for jobs. |
| **FastAPI** (Python) | OpenAPI generated natively from type hints with Swagger UI out of the box; very fast to prototype; Pydantic validation. |

Rejected before spiking: full-stack frameworks (Next.js, Nuxt, SvelteKit, Django with templates…) because the subject strongly discourages blurring client/server; Go and Rust were considered but judged too costly to learn alongside the rest within three weeks.

## 3. Criteria and weights

Weights: **3** = could make the project fail, **2** = significant cost or risk, **1** = nice to have.

| # | Criterion | Weight | How we measure it |
|---|---|---|---|
| C1 | OpenAPI contract: generation + contract test | 3 | Spike steps 4–5 reached? Effort to keep spec and code in sync |
| C2 | Security ecosystem (OIDC/OAuth2 clients, hashing, validation, rate limiting, CVE history) | 3 | Libraries found and maintained; secure defaults observed in spike |
| C3 | Background jobs / scheduling for hooks | 3 | Spike step 7 reached; options for persistent jobs |
| C4 | Team learning curve | 2 | Time spent on boilerplate vs features during the spike |
| C5 | Testing tooling (unit, functional, HTTP) | 2 | Test written and run in the spike |
| C6 | Structure for extensibility (adding a service without touching the engine) | 2 | Natural pattern for plugins / registries |
| C7 | Docker image & CI simplicity | 1 | Image size, build time |
| C8 | Runtime performance / footprint | 1 | Memory at idle, not critical at our scale |

## 4. Comparison (provisional, to be replaced by spike results)

Scores 1–5. Each member fills the matrix **independently** after the spikes; divergences > 2 points are discussed and recorded below.

| Criterion (weight) | NestJS | ASP.NET Core | FastAPI |
|---|---|---|---|
| C1 OpenAPI (3) | 4 | 5 | 5 |
| C2 Security ecosystem (3) | 4 | 5 | 4 |
| C3 Background jobs (3) | 4 | 5 | 3 |
| C4 Learning curve (2) | 5 | 3 | 4 |
| C5 Testing (2) | 4 | 4 | 4 |
| C6 Extensibility (2) | 5 | 4 | 3 |
| C7 Docker/CI (1) | 4 | 3 | 4 |
| C8 Performance (1) | 3 | 5 | 3 |
| **Weighted total (max 85)** | **71** | **75** | **65** |

Reading: ASP.NET Core is slightly ahead on paper (75 vs 71), mostly on maturity (security, jobs, performance); NestJS wins on learning curve and extensibility. A 4-point gap on provisional scores is not a decision: the spikes must settle C1 (how painful is the contract test) and C4 (how fast the team actually moves). FastAPI is weaker on persistent jobs and on structure for a project of this size.

## 5. Practical evidence

| Spike | Folder | Steps reached | Notes |
|---|---|---|---|
| NestJS | `spikes/backend-nestjs/` | _to fill_ | |
| ASP.NET Core | `spikes/backend-aspnet/` | _to fill_ | |
| FastAPI | `spikes/backend-fastapi/` | _to fill_ | |

## 6. Divergences between members

_To fill after the independent scoring._

## 7. Decision (provisional)

**NestJS (TypeScript)**, unless the spikes confirm the ASP.NET Core lead on C1–C3. This is a deliberate bet on team velocity (C4) for a 3-week MVP; if the spikes show the team is as fast in C#, ASP.NET Core wins.

Main reasons: same language as the web client (shared mental model, OpenAPI-generated TypeScript client), fastest ramp-up for the whole team, module system that fits ENG-EXT (one module per service / node type).

Accepted costs:
- Node.js dependency tree is large: more supply-chain exposure (mitigated by lockfile, `npm audit` in CI, Dependabot).
- Decorator-generated OpenAPI can drift from reality if DTOs are not used everywhere: mitigated by a contract test (schemathesis or jest + openapi validator) in CI.
- Lower raw performance than .NET: irrelevant at our scale.

Sub-decisions to make during the MVP: ORM (Prisma vs Drizzle vs TypeORM), job library (`@nestjs/schedule` + PostgreSQL vs BullMQ + Redis).

See ADR [0002](../adr/0002-backend-framework.md).
