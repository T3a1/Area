# Architecture questions: one per member

> 🇫🇷 [architecture-questions.fr.md](architecture-questions.fr.md) · Status: **Proposals: each member rewrites theirs in their own words before 01/12**

The subject asks each member to identify, at Plan, **one significant technical question** to investigate, and to defend at Final **one architectural decision** they materially contributed to (need, alternatives, evidence, decision, trade-offs, observed result). These questions are chosen so that each one leads to a defendable ADR.

| Member | Question | Why it matters | Investigation plan | Expected ADR |
|---|---|---|---|---|
| **Léandre** | How do hooks detect each external event **exactly once** (polling vs provider webhooks, event identity, cursor persistence), even after a server restart? | Without it, workflows fire repeatedly or miss events; it is the heart of the product. | Compare polling with stored cursor vs webhooks on GitHub and Gmail; prototype `UNIQUE (hook_id, external_event_id)` in the PostgreSQL spike; kill the server mid-poll and observe. | Hook scheduling and event deduplication |
| **David** | How do we **link external identities** (OIDC `iss` + `sub`) to local accounts, and manage the **lifecycle of delegated OAuth tokens** (storage, encryption, refresh, revocation on account deletion)? | Mixing "who the user is" (OIDC) and "what we may do" (OAuth2) is the classic design error of this project, and tokens are the most sensitive data. | Spike Google OIDC login + GitHub OAuth on the chosen back-end; test account linking with the same email on two providers; test token expiry and refresh. | Identity linking and token lifecycle |
| **Romane** | Which **builder form** (graph canvas, step list, wizard) lets users map data between nodes while meeting **WCAG AA with keyboard-only editing**? | The builder is the core web screen and the hardest one to make accessible. | Prototype React Flow / Svelte Flow vs an accessible step list; test keyboard-only and screen-reader use; measure with axe. | Builder interaction model |
| **Thomas** | How does the **Android app** run OAuth/OIDC securely (Custom Tabs, redirect deep link, PKCE, token storage on device) when the server address is user-configurable? | The subject requires a configurable server; redirect URIs and token storage on mobile are where auth commonly breaks. | Spike AppAuth with PKCE against Google; compare app-link vs custom-scheme redirect; decide what the phone stores (server session only vs provider tokens). | Mobile authentication flow |

Additional shared question (whole team, before MVP): **workflow data model**, how nodes, the single condition and key-path references are stored and validated so that "4 reactions" is not a structural maximum.
