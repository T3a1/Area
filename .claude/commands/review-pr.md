---
description: Test and review a pull request my human was asked to review
argument-hint: <pr-number>
---
Review PR #$ARGUMENTS.

1. `gh pr view $ARGUMENTS --comments` and read the linked issue's acceptance criteria.
2. Check it out in a worktree, never in my working tree:
   `git worktree add .worktrees/pr-$ARGUMENTS && cd .worktrees/pr-$ARGUMENTS && gh pr checkout $ARGUMENTS`.
   Run the tests and every command under "How to verify".
3. Check each acceptance criterion: ✅ / ❌ with evidence. Check scope (only the folders the issue
   allows), ADR compliance, the OpenAPI contract test, and that no commit or text credits Claude.
4. Draft the review and show me. After my OK, post it with `gh pr review $ARGUMENTS --comment`
   (or `--request-changes`). **Approving is my human's decision, never yours.**
5. Never push to the PR branch. Suggested fixes go in the review.
If you couldn't run something, say so explicitly.
