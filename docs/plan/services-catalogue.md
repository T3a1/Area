# Services, Actions and REActions (v1 proposal)

> 🇫🇷 [services-catalogue.fr.md](services-catalogue.fr.md) · Status: **Draft for team review**

## Quotas for M = 4

| Quantity | Rule | Minimum | Our target (margin) |
|---|---|---|---|
| S: services available on **both** clients | S ≥ 1 + M, at least half with OAuth2 | 5, of which ≥ 3 OAuth2 | **7**, of which 5 OAuth2 |
| A + R | A + R ≥ 2M + 2 | 10 | **~18** |

Counts are taken on the **less complete client**, so every service must be subscribable from mobile too.

## Authentication providers (who the user is)

| Provider | Protocol | Notes |
|---|---|---|
| Local | username + password, email confirmation | Required |
| **Google** | OpenID Connect | Discovery document, ID token |
| **Microsoft** (Entra ID, personal + work accounts) | OpenID Connect | Discovery document, ID token |
| GitHub | OAuth 2.0 only (**not OIDC**) | Can be offered as "Sign in with GitHub", but does not satisfy the OIDC requirement on its own; documented as such |

## Services (what the app may do on the user's behalf)

| Service | Access | Actions (detected by hooks) | REActions |
|---|---|---|---|
| **GitHub** | OAuth2 | New issue in a repo (with label filter) · New pull request · Push on a branch | Create an issue · Comment on an issue/PR |
| **Gmail** | OAuth2 (Google) | New mail matching a filter (sender, subject, has attachment) | Send a mail |
| **Google Calendar** | OAuth2 (Google) | Event starts in N minutes | Create an event |
| **Outlook** (Microsoft Graph) | OAuth2 (Microsoft) | New mail matching a filter | Send a mail · Create a Microsoft To Do task |
| **Discord** | Bot token (server installs the bot) | New message containing a keyword in a channel | Post a message in a channel |
| **Spotify** | OAuth2 | New track saved to "Liked songs" | Add a track to a playlist |
| **Timer** | none | Every day at HH:MM · Every N minutes | (none) |
| **Weather** (Open-Meteo, no key) | none | Rain forecast for tomorrow in a city · Temperature below/above X | (none) |

Totals: **8 services, 5 with OAuth2** (GitHub, Gmail, Google Calendar, Outlook, Spotify), **A = 12, R = 8, A + R = 20**.

> ⚠️ Gmail and Google Calendar share one Google OAuth client. An evaluator could count them as one "Google" service. Even then we keep 7 services, 4 of them OAuth2, still above the minimum (5 services, 3 OAuth2).

### MVP scope (14/12)
GitHub, Gmail, Discord, Timer: enough to run the MVP workflow (trigger + 2 reactions + 1 condition) and already 4 services.

## Use cases that save real time

1. **Bug triage (demo workflow, 4+ reactions).** *Trigger*: new GitHub issue labelled `bug`. *Condition*: title or labels contain `critical`.
   - **then**: post in Discord `#alerts` with `{{ trigger.title }}` and `{{ trigger.url }}` → create a Google Calendar event "Fix {{ trigger.title }}" tomorrow at 10:00 → send an Outlook mail to the on-call person → comment on the issue "Acknowledged, scheduled for {{ node_3.start }}".
   - **else**: create a Microsoft To Do task "Look at {{ trigger.title }}".
2. **Coursework inbox.** *Trigger*: Gmail from a teacher's address with an attachment → Discord message to the group → Calendar reminder 2 days later → To Do task.
3. **Morning brief.** *Trigger*: Timer every day at 07:30. *Condition*: Weather says rain → Discord "take an umbrella"; else nothing.
4. **Release watch.** *Trigger*: push on `main` of a repo → Discord message → mail to the team.
5. **Music sharing.** *Trigger*: Spotify liked song → add to a shared group playlist → Discord message.

## Open questions for the team
- Which of these do *you* actually use? Replace any service nobody uses (the subject values real use).
- Discord bot or webhook only? A webhook is simpler but gives no Action.
