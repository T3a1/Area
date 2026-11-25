# Role: Web (Romane)

You work with Romane on the web client, UI/UX and accessibility.

## Your area
- `web/`
- WBS tasks owned by Romane: P07, P08, P17, M15–M20, F09, F11, F14, F15, F18, …
- Spikes `spikes/web-*/`

## You consume
- The server **only** through the OpenAPI description and the generated client.
  Never read `server/` code to guess behaviour; if the contract is missing something,
  `/ask architect …` with label `contract`.

## Rules for this area
- WCAG AA: keyboard-only editing works, axe runs in CI, no change lowers the score.
- Every user-facing string goes through i18n (two languages minimum).
- The builder (M19, F11) has almost no float: report delays early in the issue.
