# Project management: method and tools

> 🇫🇷 [project-management.fr.md](project-management.fr.md) · Status: **Proposed** · Owner: David

## Method: Kanban with a weekly rhythm ("Scrumban")

| Option considered | Verdict for this project |
|---|---|
| **Scrum** (fixed sprints, roles, ceremonies) | Rejected: ceremonies are heavy for 4 people, and our milestones (01/12, 14/12, 18/01) are irregular, so fixed sprints would not align. |
| **Pure Kanban** (continuous flow, WIP limits) | Good fit for flow, but gives no fixed moment to re-plan. |
| **V-model / plan-driven** | Rejected: the subject expects the plan to change with evidence. |
| **Kanban + weekly review (chosen)** | Continuous flow with WIP limits, plus one fixed weekly meeting to re-plan, update the WBS and record plan changes (required at MVP). |

### Rituals
- **Weekly review** (Monday, 45 min): what moved, what is blocked, WBS update, risks, decisions to record as ADRs.
- **Async daily check-in** (Discord thread, 3 lines: done / doing / blocked).
- **Milestone retrospective** after each defense: keep / stop / try, feeds the post-mortem.

### Board (GitHub Projects)
Columns and WIP limits:

| Column | WIP limit | Why |
|---|---|---|
| Backlog | none | Everything from the WBS |
| Ready | 8 | Two tasks ready per person, so nobody waits |
| In progress | **4** (1 per person) | Forces finishing before starting; context switching is our main risk |
| In review | 4 | A PR waiting for review blocks its author: reviewing comes before starting |
| Blocked | 3 | If full, the weekly review is brought forward |
| Done | none | |

Each card = one WBS task, with owner, estimate (days), milestone, component label (`server`, `web`, `mobile`, `infra`, `docs`, feature id) and "blocked by" links for dependencies.

## Tools

| Need | Tool | Why |
|---|---|---|
| Board, issues, roadmap | **GitHub Projects** (kept, the team already uses it) | Linked to issues and PRs (cards move automatically), roadmap view shows the schedule, sub-issues and "blocked by" show dependencies, no extra account. |
| Code, reviews | GitHub, pull requests, 1 approval required on `main` | History is evidence for individual defenses |
| CI/CD | GitHub Actions | Lint, tests, build on every PR (required at MVP), deploy at Final |
| Communication | Discord | Already used |
| Design | Figma (Romane) | Mock-ups and accessibility checks before coding |
| Documentation | Markdown in the repo (`docs/`) | Reviewed like code, read by evaluators |

Alternatives to GitHub Projects considered: **Jira** (powerful, but separate account and overkill for 4), **Notion** (flexible, but not linked to PRs), **Trello** (simple, but no link to code). Kept GitHub Projects.

## Conventions
- Branches: `feat/<scope>-<short>`, `fix/…`, `docs/…`; no direct push to `main`.
- Commits: Conventional Commits (`feat(server): …`), useful for changelogs.
- Definition of done: code + tests + docs/ADR if a decision was made + CI green + reviewed.
