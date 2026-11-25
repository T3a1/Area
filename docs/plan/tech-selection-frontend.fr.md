# Choix technologique : front-end (web + mobile)

> 🇬🇧 [tech-selection-frontend.md](tech-selection-frontend.md) · État : **Brouillon : choix web ouvert, choix mobile provisoire (spikes pour le 26/11)** · Responsables : Romane (web), Thomas (mobile)

## 0. Contraintes communes aux deux choix

- Les clients ne gèrent que la présentation et l'interaction ; **toutes les règles métier sont sur le serveur**. Les deux clients consomment le même contrat OpenAPI.
- **Règle de l'école : aucun framework qui construit à la fois le web et le mobile** (React Native, Flutter, Ionic/Capacitor, Kotlin/Compose Multiplatform…). Web et mobile sont deux bases de code séparées.
- Pas de framework web full-stack (Next.js, Nuxt, SvelteKit en mode SSR…) : le client web est une **application monopage (SPA)** servie en fichiers statiques.
- **WCAG 2.x niveau AA** sur les deux clients, avec un rapport d'audit commité.
- **Au moins deux langues** sur tout le parcours principal (inscription → création d'un AREA).
- Le **builder** (édition des nœuds et du mapping de données) est **uniquement web**. Le mobile liste les workflows, les active/désactive et montre leurs exécutions.
- Le mobile cible **Android**, avec une adresse de serveur configurable, et doit être constructible en APK installable dans la stack Docker Compose.

---

## Partie A : client web

### A.1 Candidats

| Candidat | Pourquoi il est sur la liste |
|---|---|
| **React + Vite + TypeScript** | Plus grand écosystème ; **React Flow** (xyflow) pour un builder en graphe ; **React Aria** / Radix pour des composants accessibles ; `react-i18next` ; tests mûrs (Testing Library, Playwright). |
| **Svelte 5 + Vite + TypeScript** (SPA, sans SSR SvelteKit) | Un membre a déjà fait du Svelte ; moins de boilerplate, bundles légers ; **Svelte Flow** (même équipe xyflow) ; `svelte-i18n` ; avertissements d'accessibilité intégrés au compilateur. |
| **Vue 3 + Vite + TypeScript** | Courbe d'apprentissage douce, Vue Flow pour les graphes, `vue-i18n` ; bon compromis. |

Angular a été envisagé mais écarté pour ce projet : lourd pour un projet de 4 personnes sur 8 semaines où une seule personne travaille à plein temps sur le web.

### A.2 Critères

| # | Critère | Poids | Mesure |
|---|---|---|---|
| W1 | Faisabilité du builder (édition en graphe/liste, UI de mapping de données) | 3 | Étape 2 du spike : graphe de 3 nœuds modifiable |
| W2 | Accessibilité (WCAG AA, édition au clavier seul, ARIA) | 3 | Étape clavier du spike + score axe/Lighthouse |
| W3 | Internationalisation | 2 | Changement de langue à la volée dans le spike |
| W4 | Sécurité (échappement XSS par défaut, pas d'`eval`, compatibilité CSP, nombre de dépendances) | 2 | Échappement par défaut, besoin de `dangerouslySetInnerHTML`/`{@html}`, `npm audit` |
| W5 | Génération du client OpenAPI (appels typés) | 2 | openapi-typescript / orval fonctionne directement |
| W6 | Compétences de l'équipe et workflow design (Romane) | 2 | Aisance de Romane + temps passé dans le spike |
| W7 | Outillage de test | 1 | Test de composant + E2E écrit |

### A.3 Comparaison (provisoire)

| Critère (poids) | React | Svelte | Vue |
|---|---|---|---|
| W1 Builder (3) | 5 | 4 | 4 |
| W2 Accessibilité (3) | 5 | 4 | 4 |
| W3 i18n (2) | 5 | 4 | 5 |
| W4 Sécurité (2) | 4 | 4 | 4 |
| W5 Client OpenAPI (2) | 5 | 5 | 5 |
| W6 Compétences (2) | _Romane_ | _Romane_ | _Romane_ |
| W7 Tests (1) | 5 | 4 | 4 |
| **Total pondéré hors W6 (max 65)** | **63** | **54** | **56** |

Lecture : React mène grâce à son écosystème (builder et composants accessibles), Svelte a l'expérience d'un membre et la simplicité. **W6 est décisif et doit être noté par Romane après les spikes.**

### A.4 Décision

**Ouverte : React ou Svelte, décidé après `spikes/web-react/` et `spikes/web-svelte/` (objectif 26/11).** Choix communs quel que soit le framework : Vite, TypeScript strict, client API généré depuis la description OpenAPI, Playwright pour l'E2E, axe-core en CI.

---

## Partie B : client Android

### B.1 Candidats

| Candidat | Pourquoi il est sur la liste |
|---|---|
| **Kotlin + Jetpack Compose** | Toolkit UI moderne recommandé par Google ; déclaratif (proche mentalement des frameworks web) ; accessibilité via `semantics` ; Material 3 ; très bon outillage. |
| **Kotlin + Android Views (XML)** | Le toolkit historique ; énormément de documentation ; très stable. |
| **Java + Android Views** | Langage que certains membres connaissent peut-être de l'école ; même toolkit que ci-dessus. |

Exclus par la règle de l'école : React Native, Flutter, Ionic/Capacitor, Compose Multiplatform (ils ciblent aussi le web).

### B.2 Critères

| # | Critère | Poids | Mesure |
|---|---|---|---|
| M1 | Accessibilité (TalkBack, taille des cibles tactiles, contraste, taille de police) | 3 | Accessibility Scanner sur les écrans du spike |
| M2 | Productivité pour les écrans liste/détail/réglages | 3 | Écrans construits dans la timebox |
| M3 | OAuth / OIDC sur mobile (Custom Tabs, deep links, PKCE via AppAuth) | 3 | Étape 4 du spike |
| M4 | i18n | 2 | `strings.xml` par langue, fonctionne pour tous les candidats |
| M5 | Client API depuis l'OpenAPI (openapi-generator : Retrofit / Ktor) | 2 | Le client généré compile |
| M6 | Courbe d'apprentissage pour Thomas | 2 | Temps passé dans le spike |
| M7 | Build sans interface dans Docker (APK) | 1 | `./gradlew assembleDebug` dans un conteneur |

### B.3 Comparaison (provisoire)

| Critère (poids) | Kotlin + Compose | Kotlin + Views | Java + Views |
|---|---|---|---|
| M1 Accessibilité (3) | 4 | 4 | 4 |
| M2 Productivité (3) | 5 | 3 | 2 |
| M3 OAuth (3) | 4 | 4 | 4 |
| M4 i18n (2) | 5 | 5 | 5 |
| M5 Client OpenAPI (2) | 5 | 5 | 4 |
| M6 Courbe d'apprentissage (2) | 3 | 3 | 4 |
| M7 Build Docker (1) | 4 | 4 | 4 |
| **Total pondéré (max 80)** | **69** | **63** | **60** |

### B.4 Décision (provisoire)

**Kotlin + Jetpack Compose**, Material 3, client Retrofit généré depuis la description OpenAPI, AppAuth pour OAuth/OIDC avec PKCE, DataStore pour l'adresse du serveur.

Coûts acceptés :
- Compose est plus récent : certains comportements d'accessibilité (ordre du focus, sémantique personnalisée) demandent un travail explicite ; atténué par un passage d'Accessibility Scanner sur chaque écran.
- Android uniquement : pas de bonus iOS. Accepté, le sujet n'exige qu'Android.
- Base de code séparée du web : logique de présentation dupliquée ; atténué en gardant toutes les règles côté serveur et en générant les deux clients API depuis le même fichier OpenAPI.

Voir les ADR [0004](../adr/0004-mobile-client.fr.md) et [0005](../adr/0005-web-client.fr.md).
