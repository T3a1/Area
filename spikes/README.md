# Spikes (proofs of concept)

> 🇫🇷 [README.fr.md](README.fr.md)

A spike is a **fixed slice of time spent buying information**, not building a feature. When the timer rings, you stop, working or not. Spikes are the practical evidence behind `docs/plan/tech-selection-*.md`.

## Rules

1. Same timebox for every candidate of a layer (default: **3 hours**, see below).
2. Same target for every candidate (below).
3. One folder per candidate: `spikes/<layer>-<technology>/`, containing the code and a `SPIKE.md`.
4. Write `SPIKE.md` **immediately** when the timer rings.
5. Do not extend the timebox for the technology you already like.

Why 3 hours: long enough to reach the OpenAPI and database steps where candidates really differ, short enough to run three candidates per layer before 27/11.

## Targets per layer

### Backend (`spikes/backend-<tech>/`)
1. Server on the port read from the `PORT` environment variable (default 8080).
2. `GET /ping` → `200` with exact body `{"status":"ok"}`.
3. `POST /workflows` validating a small JSON body (reject invalid input with `400` and an error body).
4. OpenAPI description served + browsable UI, generated or written; it must include the `400` response.
5. One automated test that fails when the implementation and the OpenAPI description disagree.
6. Persist the workflow in PostgreSQL (or the persistence candidate) and read it back.
7. Bonus: a background job running every 30 s without any HTTP request.

### Web (`spikes/web-<tech>/`)
1. SPA built with Vite, calling `GET /ping` on a configurable server URL.
2. A 3-node graph (trigger → condition → reaction) editable **with the keyboard only**.
3. Two languages switchable at runtime.
4. Lighthouse / axe accessibility score recorded.

### Mobile (`spikes/mobile-<tech>/`)
1. Settings screen to set the server address, persisted.
2. Calls `GET /ping` and displays the result; error state if unreachable.
3. Two languages (follows system language).
4. Opens an OAuth authorization URL in a Custom Tab and receives the redirect (deep link).
5. Debug APK built from the command line (`./gradlew assembleDebug`).

### Persistence (`spikes/db-<tech>/`)
1. Store a workflow (variable number of nodes) and query "all enabled workflows whose trigger is X".
2. Two concurrent workers pick pending events **without processing the same one twice**.
3. Insert the same external event id twice: the second insert is rejected or ignored (deduplication).
4. Backup and restore with a single command.

## `SPIKE.md` template

```markdown
# Spike: <technology>
- Author(s):
- Date / timebox:
- Steps reached (1..n):
## Where we were when time ran out
## What consumed the most minutes
## What we would need to go further
## Security observations (auth libs, validation, defaults, known CVEs)
## Verdict (1 line)
```

## `DISTANCE.md`

One table per layer comparing candidates. Our definition of **distance travelled** = number of target steps fully reached within the timebox, weighted by how hard each step is for *our* project (OpenAPI contract test and background jobs count double), plus the number of blockers met.
