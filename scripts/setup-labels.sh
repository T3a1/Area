#!/usr/bin/env bash
# Creates the project's GitHub labels. Run once from the repo root after `gh auth login`.
# Progress is tracked by the board's Status field, so there are no status:* labels.
set -euo pipefail

label() { gh label create "$1" --color "$2" --description "$3" --force; }

for a in server web mobile auth infra docs; do
  label "area:$a" "ededed" "Area: $a"
done

label "request"         "1d76db" "One area asks another for something"
label "contract"        "5319e7" "Changes a shared contract (OpenAPI, DB schema, workflow format)"
label "bug"             "d73a4a" "Something does not work as specified"
label "decision"        "c5def5" "A technical choice, becomes an ADR"

label "blocked"         "b60205" "Cannot progress, needs someone"
label "question"        "d876e3" "Needs an answer before continuing"
label "needs-approval"  "e99695" "Every human must approve"

echo "Labels ready."
