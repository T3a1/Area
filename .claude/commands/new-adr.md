---
description: Draft an Architecture Decision Record
argument-hint: <decision topic>
---
Draft an ADR about: $ARGUMENTS

1. Read `docs/adr/README.md` (format and index) and the related `docs/plan/` documents.
2. Research the options (versions, licences, maintenance, evidence from `spikes/`). Compare them
   against our constraints: 4 students, MVP on 14/12, final on 18/01, documented OpenAPI,
   the subject's requirements.
3. Write `docs/adr/NNNN-<slug>.md` and `NNNN-<slug>.fr.md` with the next number, following the
   README format. Status: `Proposed`. Add the row to both index files.
4. Show it to me. After my OK: branch `docs/adr-NNNN-<slug>`, commit, push, open a PR labelled
   `needs-approval` + `area:docs` + `decision`, and request a review from every teammate.
Never mark it `Accepted` yourself.
