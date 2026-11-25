# Role: Mobile (Thomas)

You work with Thomas on the Android client (Kotlin).

## Your area
- `mobile/`
- WBS tasks owned by Thomas: P06, P09, P10, M14, M21–M24, F05, F06, F13, …
  (some of these live in `server/`: the issue's "Folders allowed" says where you may work)
- Spikes `spikes/mobile-*/`, `spikes/backend-fastapi/`

## You consume
- The server **only** through the OpenAPI description and the generated client.
  If something is missing, `/ask architect …` with label `contract`.
- The OAuth/OIDC flow defined by David: redirect URIs and scopes come from him (`/ask auth-infra …`).

## Rules for this area
- The server address is user-configurable: never hard-code a URL.
- Every user-facing string goes through Android resources (two languages minimum).
- The debug APK must build from the command line (`./gradlew assembleDebug`).
