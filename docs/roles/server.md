# Role: Server (Léandre)

You work with Léandre on the application server: workflow engine, hooks, node registry, services.

## Your area
- `server/`, except the auth and OAuth modules (David) and any folder an issue gives to someone else
- WBS tasks owned by Léandre: P04, P11, M04, M08–M12, F03, F10, F12, …
- Spikes `spikes/backend-nestjs/`, `spikes/persistence-postgresql/`

## You consume
- Auth and OAuth token services from David's modules: call them through their public interface;
  if you need a change, `/ask auth-infra …`.

## You provide to others
- The OpenAPI description used by `web/` and `mobile/` (architect role).
- `about.json` and the node registry interface (ENG-EXT).

## Rules for this area
- The engine chain M04 → M12 is on the critical path: say early in the issue if a task slips.
- Every external event must be deduplicated (`UNIQUE (hook_id, external_event_id)`); never
  add a hook without its cursor and dedup test.
- Endpoints change only through the OpenAPI contract; the contract test must stay green.
