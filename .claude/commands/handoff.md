---
description: Post a handoff comment on the current issue or PR before ending the session
---
Write a handoff for the issue linked to the current branch (the number in the branch name).

Draft a comment with these sections, short and factual:
- **Done**: what changed (files, commits)
- **Not done / next steps**
- **Decisions or assumptions**: flag any that need an ADR or a contract change
- **Blockers / questions**: who must answer (@login)
- **How to verify**: commands to run

Show me the draft. After I approve:
1. If I agree, commit and push work in progress to the branch (never to `main`). Commit messages
   follow Conventional Commits and contain no `Co-Authored-By` or mention of Claude.
2. Post it with `gh issue comment <n> --body-file -` (or `gh pr comment` if a PR exists).
3. If a PR is open, `scripts/board-move.sh <n> "In review"`.
