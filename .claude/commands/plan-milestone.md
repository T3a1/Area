---
description: Turn one WBS phase into GitHub issues on the board (architect)
argument-hint: <Plan|MVP|Final>
---
Plan the phase: $ARGUMENTS

1. Read the matching phase table in `planning/project-wbs.md`, accepted ADRs, and existing issues
   (`gh issue list --state all --limit 200`) to avoid duplicates (titles start with the WBS id).
2. Propose one issue per WBS task, as a table: title `[<WBS id>] <task>`, assignee (owner from the
   WBS; split tasks owned by several people into one issue per person), folders allowed,
   acceptance criteria (checkable), linked ADRs, labels (`area:*`), milestone, "Depends on"
   (from the predecessors column), estimate. Flag tasks that need an ADR first, and tasks over
   1 day that should be split.
3. Show me the full table. **Create nothing until I approve.**
4. After approval, create them in dependency order with `gh issue create` (task template fields),
   then add each to the board:
   `source .github/board.env && gh project item-add "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --url <issue url>`,
   and fill "Depends on" with the real issue numbers.
5. Move to **Ready** only the issues with no open dependency: `scripts/board-move.sh <n> "Ready"`.
