# Technology selection: front-end (web + mobile)

> 🇫🇷 [tech-selection-frontend.fr.md](tech-selection-frontend.fr.md) · Status: **Draft: web choice open, mobile choice provisional (spikes due 26/11)** · Owners: Romane (web), Thomas (mobile)

## 0. Constraints that shape both choices

- Clients only handle presentation and interaction; **all business rules live on the server**. Both clients consume the same OpenAPI contract.
- **School rule: no framework that builds both web and mobile** (React Native, Flutter, Ionic/Capacitor, Kotlin/Compose Multiplatform…). Web and mobile are two separate codebases.
- No full-stack web framework (Next.js, Nuxt, SvelteKit in SSR mode…): the web client is a **single-page application** served as static files.
- **WCAG 2.x level AA** on both clients, with a committed audit report.
- **At least two languages** across the whole main flow (registration → AREA creation).
- The **builder** (editing nodes and data mapping) is **web only**. Mobile lists workflows, enables/disables them and shows their runs.
- Mobile targets **Android**, with a configurable server address, and must be buildable as an installable APK inside the Docker Compose stack.

---

## Part A: Web client

### A.1 Candidates

| Candidate | Why it is on the list |
|---|---|
| **React + Vite + TypeScript** | Largest ecosystem; **React Flow** (xyflow) for a node-graph builder; **React Aria** / Radix for accessible components; `react-i18next`; mature testing (Testing Library, Playwright). |
| **Svelte 5 + Vite + TypeScript** (SPA, no SvelteKit SSR) | One member already used Svelte; less boilerplate, small bundles; **Svelte Flow** (same xyflow team); `svelte-i18n`; built-in a11y compiler warnings. |
| **Vue 3 + Vite + TypeScript** | Gentle learning curve, Vue Flow for graphs, `vue-i18n`; good middle ground. |

Angular was considered but rejected for this project: heavy for a 4-person, 8-week project where only one person works full-time on the web client.

### A.2 Criteria

| # | Criterion | Weight | Measure |
|---|---|---|---|
| W1 | Builder feasibility (graph/list editing, data mapping UI) | 3 | Spike step 2: 3-node graph editable |
| W2 | Accessibility (WCAG AA, keyboard-only editing, ARIA) | 3 | Keyboard-only spike step + axe/Lighthouse score |
| W3 | Internationalisation | 2 | Runtime language switch in spike |
| W4 | Security (XSS-safe defaults, no `eval`, CSP compatibility, dependency count) | 2 | Default escaping, need for `dangerouslySetInnerHTML`/`{@html}`, `npm audit` |
| W5 | OpenAPI client generation (typed API calls) | 2 | openapi-typescript / orval works out of the box |
| W6 | Team skill and design workflow (Romane) | 2 | Romane's comfort + time spent in spike |
| W7 | Testing tooling | 1 | Component + E2E test written |

### A.3 Comparison (provisional)

| Criterion (weight) | React | Svelte | Vue |
|---|---|---|---|
| W1 Builder (3) | 5 | 4 | 4 |
| W2 Accessibility (3) | 5 | 4 | 4 |
| W3 i18n (2) | 5 | 4 | 5 |
| W4 Security (2) | 4 | 4 | 4 |
| W5 OpenAPI client (2) | 5 | 5 | 5 |
| W6 Team skill (2) | _Romane_ | _Romane_ | _Romane_ |
| W7 Testing (1) | 5 | 4 | 4 |
| **Weighted total excl. W6 (max 65)** | **63** | **54** | **56** |

Reading: React leads on ecosystem (builder and accessible components), Svelte has the member experience and simplicity. **W6 is decisive and must be scored by Romane after the spikes.**

### A.4 Decision

**Open: React or Svelte, decided after `spikes/web-react/` and `spikes/web-svelte/` (target 26/11).** Common choices regardless of framework: Vite, TypeScript strict, API client generated from the OpenAPI description, Playwright for E2E, axe-core in CI.

---

## Part B: Android client

### B.1 Candidates

| Candidate | Why it is on the list |
|---|---|
| **Kotlin + Jetpack Compose** | Google's recommended modern UI toolkit; declarative (close to web frameworks mentally); accessibility via `semantics`; Material 3; strong tooling. |
| **Kotlin + Android Views (XML)** | The historical toolkit; huge amount of documentation; very stable. |
| **Java + Android Views** | Language some members may know from school; same toolkit as above. |

Excluded by the school rule: React Native, Flutter, Ionic/Capacitor, Compose Multiplatform (they target web as well).

### B.2 Criteria

| # | Criterion | Weight | Measure |
|---|---|---|---|
| M1 | Accessibility (TalkBack, touch targets, contrast, font scaling) | 3 | Accessibility Scanner on spike screens |
| M2 | Productivity for list/detail/settings screens | 3 | Screens built within the timebox |
| M3 | OAuth / OIDC on mobile (Custom Tabs, deep links, PKCE via AppAuth) | 3 | Spike step 4 |
| M4 | i18n | 2 | `strings.xml` per locale, works in all candidates |
| M5 | API client from OpenAPI (openapi-generator: Retrofit / Ktor) | 2 | Generated client compiles |
| M6 | Learning curve for Thomas | 2 | Time spent in spike |
| M7 | Headless build in Docker (APK) | 1 | `./gradlew assembleDebug` in a container |

### B.3 Comparison (provisional)

| Criterion (weight) | Kotlin + Compose | Kotlin + Views | Java + Views |
|---|---|---|---|
| M1 Accessibility (3) | 4 | 4 | 4 |
| M2 Productivity (3) | 5 | 3 | 2 |
| M3 OAuth (3) | 4 | 4 | 4 |
| M4 i18n (2) | 5 | 5 | 5 |
| M5 OpenAPI client (2) | 5 | 5 | 4 |
| M6 Learning curve (2) | 3 | 3 | 4 |
| M7 Docker build (1) | 4 | 4 | 4 |
| **Weighted total (max 80)** | **69** | **63** | **60** |

### B.4 Decision (provisional)

**Kotlin + Jetpack Compose**, Material 3, Retrofit client generated from the OpenAPI description, AppAuth for OAuth/OIDC with PKCE, DataStore for the server address.

Accepted costs:
- Compose is newer: some accessibility behaviours (focus order, custom semantics) need explicit work: mitigated by Accessibility Scanner checks on every screen.
- Android-only: no iOS bonus. Accepted, the subject only requires Android.
- Separate codebase from the web: duplicated presentation logic; mitigated by keeping all rules server-side and generating both API clients from the same OpenAPI file.

See ADRs [0004](../adr/0004-mobile-client.md) and [0005](../adr/0005-web-client.md).
