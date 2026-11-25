---
description: Ask another area for something by opening a request issue (never edit their files)
argument-hint: <architect|server|web|mobile|auth-infra> <what you need>
---
Draft a request to another area: $ARGUMENTS

1. Find the owner: read `docs/roles/<role>.md` and `.github/CODEOWNERS` for the GitHub login.
   Contract changes (OpenAPI, DB schema, workflow format, `about.json`) always go to `architect`.
2. Check it doesn't exist already: `gh issue list --label request --search "<keywords>"`.
3. Draft the issue with the request template fields:
   - **Needed**: what must exist or change, from my side of the contract (inputs, outputs,
     example payload). Not how to implement it in their area.
   - **Why / waiting task**: the issue of mine that waits (`#n`) and its WBS id.
   - **Needed by**: date, from the WBS.
   - **Proposal** (optional): what I would suggest, clearly marked as a suggestion.
   Labels: `request`, `area:<their area>`, plus `contract` if it changes a shared contract.
   Assignee: the owner.
4. Show me the draft. **Create nothing until I approve.** Then:
   `gh issue create --title "<title>" --body-file - --label ... --assignee <owner>`.
5. On my task issue, comment "Depends on #<new>", and if I can't continue, add `blocked` and run
   `scripts/board-move.sh <my issue> "Blocked"`.
