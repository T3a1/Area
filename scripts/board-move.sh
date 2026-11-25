#!/usr/bin/env bash
# Moves the board card of an issue (or PR) to a column of the GitHub Project.
# Usage: scripts/board-move.sh <issue-number> "<column>"
#   e.g. scripts/board-move.sh 42 "In progress"
# Needs: gh with the `project` scope (gh auth refresh -s project), jq, .github/board.env filled in.
set -euo pipefail

[ $# -eq 2 ] || { echo "Usage: $0 <issue-number> \"<column>\"" >&2; exit 2; }
NUMBER="$1"
COLUMN="$2"

ROOT="$(git rev-parse --show-toplevel)"
# shellcheck source=/dev/null
source "$ROOT/.github/board.env"
[ -n "${PROJECT_NUMBER:-}" ] || { echo "PROJECT_NUMBER is empty in .github/board.env" >&2; exit 1; }

REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"

PROJECT_ID="$(gh project view "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --format json -q .id)"

FIELDS="$(gh project field-list "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --format json)"
FIELD_ID="$(jq -r --arg f "$STATUS_FIELD" '.fields[] | select(.name == $f) | .id' <<<"$FIELDS")"
OPTION_ID="$(jq -r --arg f "$STATUS_FIELD" --arg c "$COLUMN" \
  '.fields[] | select(.name == $f) | .options[] | select(.name == $c) | .id' <<<"$FIELDS")"
[ -n "$FIELD_ID" ] || { echo "No field named '$STATUS_FIELD' on the project" >&2; exit 1; }
[ -n "$OPTION_ID" ] || { echo "No column named '$COLUMN' in field '$STATUS_FIELD'" >&2; exit 1; }

ITEM_ID="$(gh project item-list "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --format json --limit 1000 \
  | jq -r --arg r "$REPO" --argjson n "$NUMBER" \
      '.items[] | select(.content.number == $n and .content.repository == $r) | .id' | head -n1)"

if [ -z "$ITEM_ID" ]; then
  URL="$(gh issue view "$NUMBER" --json url -q .url 2>/dev/null || gh pr view "$NUMBER" --json url -q .url)"
  ITEM_ID="$(gh project item-add "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --url "$URL" --format json -q .id)"
fi

gh project item-edit --id "$ITEM_ID" --project-id "$PROJECT_ID" \
  --field-id "$FIELD_ID" --single-select-option-id "$OPTION_ID" >/dev/null
echo "#$NUMBER → $COLUMN"
