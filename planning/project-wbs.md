# Project WBS (work breakdown structure)

> 🇫🇷 [project-wbs.fr.md](project-wbs.fr.md) · Status: **Draft v1 (2026-11-23)**: reviewed every Monday; changes are recorded at the bottom.

Durations are in working days (0.5 = half a day). Tasks marked 🔴 are on the **critical path**: if one slips, a milestone slips. Owners follow the agreed split: Romane (web, accessibility), Léandre (server, engine), Thomas (mobile), David (auth, infra).

## Phase 1: Plan (23/11 → 01/12)

| ID | Task | Owner | Days | Predecessors | Start | End | Crit. |
|---|---|---|---|---|---|---|---|
| P01 | Register the team for all defenses (deadline 29/11 23:42) | ALL | 0.1 | — | 23/11 | 23/11 |  |
| P02 | Repository structure, branch protection on `main`, GitHub Project board with WIP limits | David | 0.5 | — | 23/11 | 23/11 |  |
| P03 | Read the subject together, agree selection criteria per layer and the spike timebox | ALL | 0.5 | — | 23/11 | 23/11 | 🔴 |
| P04 | Spike back-end: NestJS | Léandre | 0.5 | P03 | 24/11 | 24/11 | 🔴 |
| P05 | Spike back-end: ASP.NET Core | David | 0.5 | P03 | 24/11 | 24/11 |  |
| P06 | Spike back-end: FastAPI | Thomas | 0.5 | P03 | 24/11 | 24/11 |  |
| P07 | Spike web: React + React Flow | Romane | 0.5 | P03 | 24/11 | 24/11 |  |
| P08 | Spike web: Svelte + Svelte Flow | Romane | 0.5 | P03 | 25/11 | 25/11 |  |
| P09 | Spike mobile: Kotlin + Compose (+ AppAuth redirect) | Thomas | 0.5 | P03 | 25/11 | 25/11 |  |
| P10 | Spike mobile: Kotlin + Views (XML) | Thomas | 0.5 | P03 | 25/11 | 25/11 |  |
| P11 | Spike persistence: PostgreSQL (dedup, SKIP LOCKED, backup) | Léandre | 0.5 | P04 | 25/11 | 25/11 | 🔴 |
| P12 | Spike persistence: MongoDB | David | 0.5 | P05 | 25/11 | 25/11 |  |
| P13 | Spike auth: Google OIDC login + GitHub OAuth on the back-end candidate | David | 0.5 | P04 | 26/11 | 26/11 |  |
| P14 | Write every `SPIKE.md` and `spikes/DISTANCE.md` | ALL | 0.5 | P04–P12 | 26/11 | 26/11 | 🔴 |
| P15 | Score the decision matrices independently, discuss divergences > 2 points | ALL | 0.5 | P14 | 26/11 | 26/11 | 🔴 |
| P16 | Finalise the 3 technology selection documents (back, front, persistence) | Léandre, Romane, Thomas | 0.5 | P15 | 27/11 | 27/11 | 🔴 |
| P17 | Move ADRs 0002–0005 to Accepted (or revise them) | Romane | 0.5 | P16 | 27/11 | 27/11 | 🔴 |
| P18 | Review the services catalogue: keep services the team really uses | ALL | 0.5 | P13 | 26/11 | 26/11 |  |
| P19 | Feature selection and owners (done: 9 points) | ALL | 0.25 | — | 23/11 | 23/11 |  |
| P20 | Each member rewrites their architecture question | Each member | 0.25 | P14 | 27/11 | 27/11 |  |
| P21 | Project management document + board configured | David | 0.5 | P02 | 27/11 | 27/11 |  |
| P22 | Review this WBS, load every task into GitHub Projects with owner, dates and dependencies | Léandre | 1 | P16, P18, P19 | 28/11 | 28/11 | 🔴 |
| P23 | Plan defense rehearsal and final review | ALL | 0.5 | P17, P20, P21, P22 | 30/11 | 30/11 | 🔴 |
| ◆1 | **Milestone 1: Plan defense** | ALL | — | P23 | 01/12 | 01/12 | 🔴 |

## Phase 2: MVP (01/12 → 14/12)

| ID | Task | Owner | Days | Predecessors | Start | End | Crit. |
|---|---|---|---|---|---|---|---|
| M01 | Monorepo scaffolding (`server/`, `web/`, `mobile/`) + Docker Compose skeleton with PostgreSQL | David | 1 | P17 | 01/12 | 01/12 | 🔴 |
| M02 | CI: lint + tests + build per component on every PR, failure visible | David | 1 | M01 | 02/12 | 02/12 |  |
| M03 | `.env.example` + gitleaks in CI (SYS-SECRETS v1) | David | 0.5 | M02 | 03/12 | 03/12 |  |
| M04 | Database schema v1 + migrations (users, identities, subscriptions, tokens, workflows, runs, events) | Léandre | 1 | M01 | 02/12 | 02/12 | 🔴 |
| M05 | Local auth: register, mail confirmation, login, sessions | David | 1.5 | M04 | 03/12 | 04/12 |  |
| M06 | OIDC login with Google | David | 1 | M05 | 05/12 | 05/12 |  |
| M07 | OAuth2 subscription framework + encrypted token storage (SEC-CRYPTO v1) | David | 2 | M05 | 06/12 | 07/12 |  |
| M08 | Node interface + registry (ENG-EXT) | Léandre | 1 | M04 | 03/12 | 03/12 | 🔴 |
| M09 | `about.json` generated from the registry | Léandre | 0.5 | M08 | 04/12 | 04/12 |  |
| M10 | Workflow model + save-time validation (structure, key paths) | Léandre | 1.5 | M08 | 04/12 | 05/12 | 🔴 |
| M11 | Engine: linear chain, condition, key-path substitution, run records | Léandre | 2 | M10 | 06/12 | 07/12 | 🔴 |
| M12 | Hook scheduler: polling, cursor, deduplication | Léandre | 1.5 | M11 | 08/12 | 09/12 | 🔴 |
| M13 | MVP services: GitHub (new issue, comment), Gmail (send), Discord (post), Timer | David | 2 | M07, M08 | 08/12 | 09/12 |  |
| M14 | OpenAPI served + Swagger UI + contract test in CI | Thomas | 1 | M02 | 03/12 | 03/12 |  |
| M15 | `GET /health` v1 (SYS-HEALTH) | Romane | 0.5 | M01 | 03/12 | 03/12 |  |
| M16 | Web: project setup, routing, design tokens, i18n (2 languages), axe in CI | Romane | 1.5 | M01 | 01/12 | 02/12 |  |
| M17 | Web: register / login / Google sign-in screens | Romane | 1.5 | M16, M05 | 04/12 | 05/12 |  |
| M18 | Web: services page (subscribe / unsubscribe) | Romane | 1 | M17, M07 | 09/12 | 09/12 |  |
| M19 | Web: builder v1 (trigger, condition, reactions, key-path picker) | Romane | 3 | M17, M10 | 06/12 | 08/12 | 🔴 |
| M20 | Web: workflow list + run history | Romane | 1 | M11 | 10/12 | 10/12 |  |
| M21 | Mobile: project setup, server-address setting, i18n, base components | Thomas | 1.5 | M01 | 01/12 | 02/12 |  |
| M22 | Mobile: generated API client + auth screens (incl. Google via AppAuth) | Thomas | 2 | M21, M05, M14 | 05/12 | 06/12 |  |
| M23 | Mobile: services subscription (Custom Tabs) | Thomas | 1.5 | M22, M07 | 08/12 | 09/12 |  |
| M24 | Mobile: workflow list, enable/disable, runs | Thomas | 1.5 | M23, M11 | 09/12 | 10/12 |  |
| M25 | Docker Compose full stack + APK build service | David | 1 | M02, M21 | 10/12 | 10/12 |  |
| M26 | ADRs: workflow engine, hook deduplication, token storage | Romane, Léandre | 0.5 | M12 | 10/12 | 10/12 |  |
| M27 | End-to-end MVP workflow (trigger + 2 reactions + 1 condition) on both clients | ALL | 1 | M12, M13, M19, M24, M25 | 11/12 | 11/12 | 🔴 |
| M28 | Technical documentation v1 + updated plan + analysis of changes | Léandre, David | 1 | M27 | 12/12 | 12/12 | 🔴 |
| M29 | Decide on the (last) feature-selection revision | ALL | 0.25 | M27 | 12/12 | 12/12 |  |
| M30 | MVP rehearsal + fallback demo recording | ALL | 0.5 | M28 | 13/12 | 13/12 | 🔴 |
| ◆2 | **Milestone 2: MVP defense** | ALL | — | M30 | 14/12 | 14/12 | 🔴 |

## Phase 3: Final product (15/12 → 18/01)

Holiday break: **22/12 → 03/01**, no task scheduled except optional buffer. Weekend **09–10/01** is a buffer.

| ID | Task | Owner | Days | Predecessors | Start | End | Crit. |
|---|---|---|---|---|---|---|---|
| F01 | MVP retrospective + plan update | ALL | 0.5 | ◆2 | 15/12 | 15/12 | 🔴 |
| F02 | Microsoft OIDC login + identity linking rules | David | 1.5 | F01 | 16/12 | 17/12 |  |
| F03 | Services: Google Calendar, Outlook + Microsoft To Do | Léandre | 3 | F01 | 16/12 | 18/12 | 🔴 |
| F04 | Services: Spotify, Weather, extra GitHub actions | David | 2 | F02 | 18/12 | 21/12 |  |
| F05 | ENG-RETRY: configurable policy, backoff, idempotency keys | Thomas | 3 | M11 | 16/12 | 18/12 |  |
| F06 | ENG-RETRY: dead-letter store, replay API, web view | Thomas | 2 | F05 | 05/01 | 06/01 |  |
| F07 | SEC-CRYPTO: before/after dump, tamper detection, key rotation, log check, evidence note | David | 2 | M07 | 04/01 | 05/01 |  |
| F08 | SYS-SECRETS: history scan, log grep, fresh-clone test, evidence | David | 1 | M03 | 06/01 | 06/01 |  |
| F09 | SYS-HEALTH: OIDC + scheduler checks, 1 s bound, 503, no leaks | Romane | 1 | M15 | 16/12 | 16/12 |  |
| F10 | ENG-EXT: `HOWTOCONTRIBUTE.md`, last node in an isolated commit, live-add rehearsal | Léandre | 2 | F03 | 05/01 | 06/01 | 🔴 |
| F11 | Builder v2: data-mapping UX, validation errors, condition branches, ≥ 4 reactions | Romane | 3 | M19 | 17/12 | 21/12 |  |
| F12 | Demo workflow with ≥ 4 reaction nodes (bug triage) | Léandre | 1 | F03, F11, F10 | 07/01 | 07/01 | 🔴 |
| F13 | Mobile parity: every service subscribable, run details | Thomas | 3 | M24, F03, F04 | 21/12 | 04/01 |  |
| F14 | i18n complete on the whole main flow, both clients | Romane, Thomas | 1 | F11, F13 | 11/01 | 11/01 |  |
| F15 | WCAG AA audit of both clients, fixes, audit report | Romane, Thomas | 2 | F14 | 12/01 | 13/01 |  |
| F16 | Unit + functional tests on success and failure paths (ongoing) | ALL | 4 | F05 | 04/01 | 08/01 |  |
| F17 | CD: automatic deployment without manual steps | David | 2 | M25 | 07/01 | 08/01 |  |
| F18 | ADRs finalised (≥ 3, supersessions linked) | Romane | 0.5 | F10 | 08/01 | 08/01 |  |
| F19 | README, HOWTOCONTRIBUTE, technical docs (failure semantics, persistence, feature→criteria map) | Léandre, David | 2 | F10, F17 | 12/01 | 13/01 | 🔴 |
| F20 | Final planning artifacts + post-mortem | ALL | 1 | F19 | 14/01 | 14/01 | 🔴 |
| F21 | Presentation, live demo script, fallback recording | ALL | 1.5 | F12, F15, F20 | 15/01 | 16/01 | 🔴 |
| F22 | Freeze and final delivery (before 23:42) | ALL | 0.5 | F21 | 17/01 | 17/01 | 🔴 |
| ◆3 | **Milestone 3: Final defense** | ALL | — | F22 | 18/01 | 18/01 | 🔴 |

## Critical path

P03 → P04 → P11 → P14 → P15 → P16 → P17 → M01 → M04 → M08 → M10 → M11 → M12 → M27 → M28 → M30 → ◆2 → F01 → F03 → F10 → F12 → F21 → F22 → ◆3

The **workflow engine chain (M04 → M12)** owned by Léandre is the spine of the project: the builder (M19), the services (M13) and the mobile lists (M24) all wait for it. The web builder (M19) has almost no float either.

## Schedule analysis

- **Can slip by two days without moving a milestone**: M15 (`/health` v1), P10 (Views spike), M26 (ADRs), F09 (SYS-HEALTH completion). They have several days of float.
- **Moves everything the moment it slips by one hour**: M11 (engine). M27 (end-to-end MVP) starts the day after M12 ends and the MVP defense is fixed.
- **Two tasks fighting over the same person**:
  - Léandre on 08–09/12: hook scheduler (M12) and MVP services (M13). Resolved by giving M13 to David, with Léandre reviewing.
  - Romane on 24–25/11 and 06–10/12: both web spikes, then builder + services page + history. Risk accepted; Thomas can take M20 if Romane is late.
  - David carries auth, OAuth, infra and two security features: watch at each weekly review; Thomas can take M25 (APK build) if needed.

## Risks

| Risk | Impact | Mitigation |
|---|---|---|
| Third-party OAuth app approval / quotas (Google, Microsoft) | Service unusable at demo | Create apps in week 1, use test users, keep a fallback recording |
| Engine late (critical path) | MVP fails | Engine scope frozen at "linear + 1 condition"; Thomas helps on tests |
| Accessibility left to the end | Final requirement missed | axe in CI from M16, audit F15 planned early enough to fix |
| Holiday break | ~2 weeks lost | Nothing critical scheduled over it; F13 split around it |

## Change log

| Date | Change | Reason | Cost |
|---|---|---|---|
| 2026-11-23 | v1 | Initial plan | — |
