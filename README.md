# AREA

> 🇫🇷 Version française : [README.fr.md](README.fr.md)

AREA is an automation platform inspired by IFTTT and Zapier. Users connect the services they already use (mail, code hosting, chat, calendar…) and build **workflows**: when an **Action** happens in one service, the platform runs one or more **REActions** in other services, optionally through a condition.

The product is made of three parts that only communicate through a documented HTTP API (OpenAPI):

| Part | Role |
|---|---|
| `server/` | Application server: accounts, services, hooks, workflow engine, OpenAPI description |
| `web/` | Web client: account, service subscriptions, **workflow builder**, monitoring |
| `mobile/` | Android client: account, service subscriptions, workflow list, enable/disable, run history |

> Status: **Milestone 1 (Plan)** in progress. The code folders do not exist yet; technology choices are being validated by proofs of concept in `spikes/`.

## Team

| Member | Main area |
|---|---|
| Romane | Web client, UI/UX, accessibility |
| Léandre | Application server, workflow engine, hooks |
| Thomas | Android client |
| David | Authentication, OAuth2/OIDC, infrastructure (Docker, CI/CD) |

## Milestones

| Date | Event |
|---|---|
| 23/11/2026 | Project start |
| 29/11/2026 23:42 | Registration deadline for defenses |
| **01/12/2026** | Milestone 1 defense: **Plan** |
| **14/12/2026** | Milestone 2 defense: **MVP** |
| 17/01/2027 23:42 | Project end (final delivery) |
| **18/01/2027** | Milestone 3 defense: **Final product** |

## Repository map

| Path | Content |
|---|---|
| `docs/plan/` | Milestone 1 deliverables: technology selection, additional features, architecture questions, project management |
| `docs/adr/` | Architecture Decision Records |
| `planning/` | Work breakdown structure (WBS), schedule, critical path |
| `spikes/` | Exploratory code (proofs of concept) used as evidence for technology choices |
| `WORKFLOW.md`, `CLAUDE.md`, `docs/roles/`, `.claude/` | How the team and each member's Claude assistant work together through GitHub |

Every document exists in English (`*.md`) and French (`*.fr.md`). English is the reference version.

## Getting started

Build and run instructions (Docker Compose, endpoints, Android APK) will be added with the MVP.
