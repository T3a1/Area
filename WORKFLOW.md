# Team workflow: four humans, four Claudes

Each teammate runs their own Claude (Claude Code) on their own machine, in their own clone.
The Claudes never talk to each other directly and never share a chat. **GitHub is the shared
memory and the communication channel**: issues are tasks and requests, PRs are handoffs,
ADRs are decisions, the GitHub Project board shows who does what.

```
               WBS (planning/project-wbs.md)
                        │  /plan-milestone (architect, human approves)
                        ▼
      issues on the board, one owner each ◄──────── /ask (request issue to another area)
                        │  /start-task
                        ▼
      branch ── commits ── PR ──► review by the owner of the folders touched
                        │                         (and every impacted owner for a contract)
                        └─ /handoff comment               │
                                                   a human merges ✅
```

Why this shape: each Claude keeps only its own context (one issue, its folders, its role),
and anything another Claude must know is written where that Claude will look: an issue
assigned to its human, or a review request.

## One-time setup (each teammate)

1. Install Claude Code and the GitHub CLI, then give `gh` access to Projects:
   ```bash
   gh auth login
   gh auth refresh -s project
   ```
2. Clone the repo and create your personal file (never committed):
   ```bash
   # Léandre
   printf '@docs/roles/server.md\n@docs/roles/architect.md\n' > CLAUDE.local.md
   # Romane
   echo '@docs/roles/web.md' > CLAUDE.local.md
   # Thomas
   echo '@docs/roles/mobile.md' > CLAUDE.local.md
   # David
   echo '@docs/roles/auth-infra.md' > CLAUDE.local.md
   ```
3. Put your GitHub login in `.github/CODEOWNERS` in place of your placeholder
   (`@ROMANE`, `@THOMAS`, `@DAVID`) and open a PR for it.
4. Start `claude` in the repo. It reads `CLAUDE.md`, your role and the shared settings
   (`.claude/settings.json`) automatically.

Once per repo (David, task P02/P21):

- Run `scripts/setup-labels.sh`.
- Fill in `.github/board.env` (owner and number of the GitHub Project).
- Protect `main`: require a PR, 1 approval, review from Code Owners, CI green.
- Add the `DISCORD_WEBHOOK_URL` repository secret for notifications.

## Daily loop

| Who | Command | What happens |
|---|---|---|
| Everyone | `/inbox` | Lists what waits for your human: assigned issues, requests, review requests, mentions, blocked items |
| Everyone | `/start-task <n>` | Reads the issue, creates the branch, moves the card to **In progress**, proposes a plan; human OKs it |
| Everyone | `/ask <role> <what>` | Drafts a `request` issue for another area; human OKs it before it is created |
| Everyone | `/handoff` | Posts a status comment on the issue or PR |
| Everyone | `/review-pr <n>` | Checks out a PR, runs the tests, drafts a per-criterion review |
| Architect | `/plan-milestone <phase>` | Turns WBS tasks into issues on the board; human approves the list first |
| Anyone | `/new-adr <topic>` | Drafts an ADR PR labelled `needs-approval` |

## Messages between Claudes

There are only five kinds, each with a fixed place, so no Claude has to read anything else.

| Kind | Where | Who acts |
|---|---|---|
| **Task** | issue from the task template, on the board | its assignee |
| **Request** ("I need X from your area") | issue from the request template, label `request` + `area:<theirs>`, assigned to the owner | the owner decides, plans it, or says no in a comment |
| **Contract change** (OpenAPI, DB schema, workflow format, `about.json`) | request issue with label `contract`, assigned to Léandre | Léandre; the PR needs a review from every impacted owner |
| **Question / blocker** on a task | comment on that issue + label `question` or `blocked` + @mention | the mentioned human |
| **Handoff** | `/handoff` comment on the issue or PR | whoever picks it up next |

Rules for requests:

- A request says **what** is needed and **why** (which task is waiting), never **how** to do it
  inside the other area.
- The requester's Claude links the request in its own task ("Depends on #n") and moves its card
  to **Blocked** if it cannot continue.
- The owner answers in the request issue. When it is delivered, the PR says `Closes #n`, which
  notifies the requester.

## Board (GitHub Projects)

The board's **Status** field is the source of truth for progress; there are no `status:*` labels.
Columns and WIP limits come from `docs/plan/project-management.md`:

| Column | WIP | Moved by |
|---|---|---|
| Backlog | – | `/plan-milestone` adds cards here |
| Ready | 8 | architect, when all dependencies are done |
| In progress | 4 (1 per person) | `/start-task` |
| In review | 4 | when the PR is opened |
| Blocked | 3 | when label `blocked` is added |
| Done | – | automatically when the PR is merged (built-in Project workflow) |

Claudes move cards with `scripts/board-move.sh <issue> "<column>"`. Turn on the built-in Project
workflows "Item closed → Done" and "Pull request merged → Done".

Issues are created **phase by phase** from the WBS, not all 78 at once: the WBS is revised every
Monday and after the spikes, and issues created too early go stale. Phase 1 now, Phase 2 at task
P22 (28/11), Phase 3 at F01.

## Labels

- Area: `area:server`, `area:web`, `area:mobile`, `area:auth`, `area:infra`, `area:docs`
- Kind: `request`, `contract`, `bug`, `decision`
- Attention: `blocked`, `question`, `needs-approval`
- Milestone: use GitHub milestones `Plan`, `MVP`, `Final`, not labels.

## Approval rules

- **ADRs**: every human approves the PR.
- **Contract changes**: Léandre + every owner whose area consumes it.
- **Everything else**: one approval from the CODEOWNERS of the folders touched.
- Humans merge. Claudes never merge, approve or push to `main`.

## Notifications

- GitHub (web or mobile app): review requests, assignments and mentions.
- Discord: `.github/workflows/notify-discord.yml` posts **only** when a human is needed
  (new request, review requested, `blocked`, `needs-approval`). Agent chatter never goes to Discord.

## Making limits last

- One issue per session; `/clear` between issues.
- Keep issues ≤ 1 day, like the WBS tasks.
- Write the answer in the issue once, so no other session has to rediscover it.
