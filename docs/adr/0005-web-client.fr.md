# 0005. Technologie du client web

- **Statut** : Proposé (ouvert : React ou Svelte, décidé après les spikes web, objectif 2026-11-26)
- **Date** : 2026-11-23
- **Pourquoi cette décision mérite un registre** : le client web héberge le builder, l'écran le plus complexe du produit et le plus sensible en accessibilité.

## Contexte
Voir [tech-selection-frontend.fr.md](../plan/tech-selection-frontend.fr.md). SPA uniquement (pas de framework full-stack), builder avec édition des nœuds et mapping de données, accessible au clavier, WCAG AA, deux langues.

## Options encore ouvertes
- **React + Vite** : écosystème le plus fort pour l'édition de graphes (React Flow) et les composants accessibles (React Aria).
- **Svelte 5 + Vite (SPA)** : expérience d'un membre, moins de code, Svelte Flow disponible.

Écartés : **Vue 3** (pas d'avantage décisif sur les deux autres pour cette équipe), **Angular** (trop lourd pour une seule personne à plein temps sur le web), **Next.js / SvelteKit SSR** (full-stack, déconseillé par le sujet).

## Décision
_En attente des spikes. Commun aux deux : Vite, TypeScript strict, client généré depuis l'OpenAPI, E2E Playwright, axe-core en CI._

## Conséquences (attendues, quelle que soit l'option)
- ➖ Un builder en graphe est plus difficile à rendre accessible au clavier qu'une liste d'étapes ; on pourra livrer un builder en liste avec un aperçu en graphe si le spike révèle des problèmes d'accessibilité.
