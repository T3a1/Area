# AREA: rules for every Claude working on this repo

Read this file fully at the start of every session. It is short on purpose.

## What we are building

AREA is an automation platform inspired by IFTTT and Zapier: when an **Action** happens in one
service, the platform runs one or more **REActions** in other services, optionally through a
condition. Three parts talk only through a documented HTTP API (OpenAPI):

| Part | Folder | Main owner |
|---|---|---|
| Application server: accounts, services, hooks, workflow engine, OpenAPI | `server/` | Léandre (auth/OAuth modules: David) |
| Web client: account, subscriptions, workflow builder, monitoring | `web/` | Romane |
| Android client: account, subscriptions, workflows, run history | `mobile/` | Thomas |
| Infrastructure: Docker Compose, CI/CD, secrets | root config, `.github/` | David |

Context: `README.md`, `docs/plan/`, `docs/adr/`. Plan and owners of every task: `planning/project-wbs.md`.

## Who you are

Four humans, four Claudes. Each Claude works for **one** human and only on that human's work.
Your human and your role are set in `CLAUDE.local.md` (personal, never committed), for example:

```
@docs/roles/server.md
@docs/roles/architect.md
```

If `CLAUDE.local.md` is missing, **ask your human who they are before doing anything**.
Roles: `architect`, `server`, `web`, `mobile`, `auth-infra` (see `docs/roles/`).

## How Claudes communicate

**You never talk to another Claude directly. GitHub is the shared memory and the only channel.**
The other Claudes cannot see your chat with your human, and you cannot see theirs.

| You need to… | Do this |
|---|---|
| Know what is waiting for you | `/inbox` |
| Start a task | `/start-task <issue>` |
| Get something from another area (endpoint, field, fix, review) | `/ask <owner-role> <what>`: opens a `request` issue assigned to that human |
| Change a shared contract (OpenAPI, DB schema, workflow format) | `/ask architect …` with label `contract`; never edit it yourself |
| Ask a question on your task | comment on the issue, add label `question`, @mention the human who must answer |
| Report you are stuck | comment on the issue, add label `blocked`, move the card to **Blocked** |
| Record a technical choice | `/new-adr <topic>` (status stays `Proposed`) |
| End a session | `/handoff` |

Full protocol, board and labels: `WORKFLOW.md`.

## Non-negotiable rules

- **No issue, no work.** Every session works on exactly one GitHub issue, assigned to your human.
- **One issue = one branch = one PR.** Branch: `<type>/<scope>-<issue>-<short>`,
  e.g. `feat/server-42-hook-cursor`. Use a git worktree (`.worktrees/`) if another task is in progress.
- **Stay in scope.** Only touch the folders the issue lists under "Folders allowed".
  A file owned by someone else (see `.github/CODEOWNERS`) is **read-only** for you:
  open a request with `/ask` instead of editing it, even for a one-line fix.
- **Never touch another human's branch, PR or worktree.** Never close or reassign their issues.
- **Never push to `main`, never merge, never approve a PR.** Humans review and merge.
- **Technical choices are decisions.** Any new library, protocol, data format or architecture change
  needs an accepted ADR in `docs/adr/`. Check the ADR index first; don't decide for the team.
- **Write it down on GitHub.** Questions, blockers, assumptions and handoffs go in the issue or PR,
  never only in your chat. Assume the next reader has no context.
- **Authorship: the human is the only author.** Never add `Co-Authored-By`, "Generated with",
  your name or any mention of Claude/AI in commits, PRs, issues, comments or files.
- **Ask before anything outward-facing**: show your human every issue, comment, review or PR text
  before posting it, and every commit before pushing it.

## Keeping context small

- Read only: the issue, its linked ADRs, the files it names, and your role file.
- Don't explore the whole repo or read the other clients' code "to understand".
  If you need to know how another part behaves, read the OpenAPI description or ask with `/ask`.
- One issue per session; `/clear` or a new session between issues.

## Repo map

| Path | Content |
|---|---|
| `docs/plan/` | Milestone 1 deliverables (technology selection, features, management) |
| `docs/adr/` | Architecture Decision Records (format in `docs/adr/README.md`) |
| `docs/roles/` | One file per Claude role |
| `planning/` | WBS, schedule, critical path |
| `spikes/` | Proofs of concept (one folder per candidate, `SPIKE.md`) |
| `server/`, `web/`, `mobile/` | Created at MVP (task M01) |
| `.claude/commands/` | Shared slash commands |

## Conventions

- Issues, PRs, commits, code comments and these Claude files: **English**.
  Project docs in `docs/` and `planning/` exist in English (`*.md`) and French (`*.fr.md`):
  if you change one, change both. Talk to your human in their language.
- Commits: Conventional Commits with the issue, e.g. `feat(server): persist hook cursor (#42)`.
- Definition of done: code + tests + docs/ADR if a decision was made + CI green + reviewed.
- Current status: **Milestone 1 (Plan)**. Only ADR-0001 is accepted; nothing is coded yet.
