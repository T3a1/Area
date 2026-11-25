---
description: Start work on one GitHub issue
argument-hint: <issue-number>
---
Start work on issue #$ARGUMENTS.

1. `gh issue view $ARGUMENTS --comments`. Check it is assigned to my human
   (`gh api user -q .login`) and that its "Depends on" issues are closed. If not, stop and tell me.
2. Read only: the issue, the ADRs it links, my role file, and the files in its "Folders allowed".
3. Create the branch from an up-to-date `main`:
   `git fetch origin && git switch -c <type>/<scope>-$ARGUMENTS-<short-slug> origin/main`
   (or `git worktree add .worktrees/$ARGUMENTS ...` if my current tree has uncommitted work).
4. `scripts/board-move.sh $ARGUMENTS "In progress"`.
5. Propose a short plan (files to touch, tests to write) and **wait for my OK** before coding.
   If the plan needs a file outside "Folders allowed", or a technical choice no accepted ADR
   covers, say so and stop: that becomes an `/ask` or a `/new-adr`.
