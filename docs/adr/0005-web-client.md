# 0005. Web client technology

- **Status**: Proposed (open: React or Svelte, decided after the web spikes, target 2026-11-26)
- **Date**: 2026-11-23
- **Why this deserves a record**: the web client hosts the builder, the most complex and most accessibility-sensitive screen of the product.

## Context
See [tech-selection-frontend.md](../plan/tech-selection-frontend.md#part-a-web-client). SPA only (no full-stack framework), builder with node editing and data mapping, keyboard-accessible, WCAG AA, two languages.

## Options still open
- **React + Vite**: strongest ecosystem for graph editing (React Flow) and accessible primitives (React Aria).
- **Svelte 5 + Vite (SPA)**: member experience, less code, Svelte Flow available.

Rejected: **Vue 3** (no decisive advantage over the two above for this team), **Angular** (too heavy for one full-time web developer), **Next.js / SvelteKit SSR** (full-stack, discouraged by the subject).

## Decision
_Pending spikes. Common to both: Vite, TypeScript strict, OpenAPI-generated client, Playwright E2E, axe-core in CI._

## Consequences (expected, either option)
- ➖ A graph builder is harder to make keyboard-accessible than a step list; we may ship a list-based builder with a graph preview if the spike shows accessibility issues.
