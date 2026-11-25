---
description: Show what is waiting for my human on GitHub (start every session with this)
---
List what needs my human, using only `gh` (read-only, post nothing):

1. `gh api user -q .login` to get my human's login.
2. Issues assigned to them: `gh issue list --assignee @me --state open`.
3. Requests for them: `gh issue list --assignee @me --label request --state open`
   and `--label contract` if my role is architect.
4. PRs waiting for their review: `gh pr list --search "review-requested:@me"`.
5. Recent mentions: `gh search issues --mentions @me --state open --repo <this repo>`.
6. Their own items labelled `blocked` or `question`, and whether someone answered since.

Show a short table grouped as: **To answer** (requests, questions, mentions), **To review**,
**To work on** (assigned, Ready first), **Blocked**. Then suggest one item to handle first and
wait for my human to choose. Don't open or read the other items in detail.
