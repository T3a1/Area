# Gestion de projet : méthode et outils

> 🇬🇧 [project-management.md](project-management.md) · État : **Proposé** · Responsable : David

## Méthode : Kanban avec un rythme hebdomadaire (« Scrumban »)

| Option envisagée | Verdict pour ce projet |
|---|---|
| **Scrum** (sprints fixes, rôles, cérémonies) | Écarté : cérémonies lourdes pour 4 personnes, et nos jalons (01/12, 14/12, 18/01) sont irréguliers, donc des sprints fixes ne s'aligneraient pas. |
| **Kanban pur** (flux continu, limites de WIP) | Adapté au flux, mais sans moment fixe pour replanifier. |
| **Cycle en V / piloté par le plan** | Écarté : le sujet attend que le plan évolue avec les preuves. |
| **Kanban + revue hebdomadaire (retenu)** | Flux continu avec limites de WIP, plus une réunion hebdomadaire fixe pour replanifier, mettre à jour le WBS et noter les changements de plan (exigés au MVP). |

### Rituels
- **Revue hebdomadaire** (lundi, 45 min) : ce qui a avancé, ce qui bloque, mise à jour du WBS, risques, décisions à consigner en ADR.
- **Point quotidien asynchrone** (fil Discord, 3 lignes : fait / en cours / bloqué).
- **Rétrospective de jalon** après chaque soutenance : garder / arrêter / essayer, alimente le post-mortem.

### Board (GitHub Projects)
Colonnes et limites de WIP :

| Colonne | Limite | Pourquoi |
|---|---|---|
| Backlog | aucune | Tout le WBS |
| Prêt | 8 | Deux tâches prêtes par personne, pour que personne n'attende |
| En cours | **4** (1 par personne) | Oblige à finir avant de commencer ; le changement de contexte est notre principal risque |
| En revue | 4 | Une PR en attente bloque son auteur : relire passe avant commencer |
| Bloqué | 3 | Si pleine, la revue hebdomadaire est avancée |
| Terminé | aucune | |

Chaque carte = une tâche du WBS, avec responsable, estimation (jours), jalon, label de composant (`server`, `web`, `mobile`, `infra`, `docs`, id de feature) et liens « blocked by » pour les dépendances.

## Outils

| Besoin | Outil | Pourquoi |
|---|---|---|
| Board, issues, roadmap | **GitHub Projects** (conservé, l'équipe l'utilise déjà) | Lié aux issues et PR (les cartes bougent toutes seules), vue roadmap pour le calendrier, sous-issues et « blocked by » pour les dépendances, pas de compte supplémentaire. |
| Code, revues | GitHub, pull requests, 1 approbation requise sur `main` | L'historique sert de preuve pour les soutenances individuelles |
| CI/CD | GitHub Actions | Lint, tests, build sur chaque PR (exigé au MVP), déploiement au Final |
| Communication | Discord | Déjà utilisé |
| Design | Figma (Romane) | Maquettes et vérifications d'accessibilité avant de coder |
| Documentation | Markdown dans le dépôt (`docs/`) | Relu comme du code, lu par les évaluateurs |

Alternatives à GitHub Projects envisagées : **Jira** (puissant, mais compte séparé et surdimensionné pour 4), **Notion** (souple, mais pas lié aux PR), **Trello** (simple, mais aucun lien avec le code). GitHub Projects est conservé.

## Conventions
- Branches : `feat/<périmètre>-<court>`, `fix/…`, `docs/…` ; pas de push direct sur `main`.
- Commits : Conventional Commits (`feat(server): …`), utiles pour les changelogs.
- Définition de « terminé » : code + tests + doc/ADR si une décision a été prise + CI verte + relu.
