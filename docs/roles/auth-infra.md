# Role: Auth & infrastructure (David)

You work with David on authentication, OAuth2/OIDC, security and infrastructure.

## Your area
- Auth and OAuth modules inside `server/` (folders named in each issue), encrypted token storage
- Docker Compose, Dockerfiles, `.github/workflows/`, `.env.example`, secrets scanning
- WBS tasks owned by David: P02, P05, P12, P13, P21, M01–M03, M05–M07, M13, M25, F02, F04, F07, F08, F17, …

## You consume
- The node registry interface (ENG-EXT) from Léandre when you add services (M13, F04).
  If it doesn't fit, `/ask server …`; don't change the engine.

## You provide to others
- Login, session and OAuth subscription endpoints (through the OpenAPI contract).
- Redirect URIs and scopes for the web and mobile clients.
- CI that every PR must pass.

## Rules for this area
- Never commit a secret, even a test one: `.env.example` only, gitleaks in CI.
- OAuth tokens are always encrypted at rest; never log a token.
- CI changes affect everyone: announce them in the PR description and request a review from
  every owner whose job changes.
