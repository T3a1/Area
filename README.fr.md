# AREA

> 🇬🇧 English version: [README.md](README.md)

AREA est une plateforme d'automatisation inspirée d'IFTTT et de Zapier. Les utilisateurs connectent les services qu'ils utilisent déjà (mail, hébergement de code, messagerie, agenda…) et construisent des **workflows** : quand une **Action** se produit dans un service, la plateforme exécute une ou plusieurs **REActions** dans d'autres services, éventuellement en passant par une condition.

Le produit se compose de trois parties qui ne communiquent que par une API HTTP documentée (OpenAPI) :

| Partie | Rôle |
|---|---|
| `server/` | Serveur applicatif : comptes, services, hooks, moteur de workflows, description OpenAPI |
| `web/` | Client web : compte, abonnements aux services, **builder de workflows**, suivi |
| `mobile/` | Client Android : compte, abonnements, liste des workflows, activation/désactivation, historique des exécutions |

> État : **Jalon 1 (Plan)** en cours. Les dossiers de code n'existent pas encore ; les choix technologiques sont validés par des preuves de concept dans `spikes/`.

## Équipe

| Membre | Domaine principal |
|---|---|
| Romane | Client web, UI/UX, accessibilité |
| Léandre | Serveur applicatif, moteur de workflows, hooks |
| Thomas | Client Android |
| David | Authentification, OAuth2/OIDC, infrastructure (Docker, CI/CD) |

## Jalons

| Date | Événement |
|---|---|
| 23/11/2026 | Début du projet |
| 29/11/2026 23:42 | Date limite d'inscription aux soutenances |
| **01/12/2026** | Soutenance jalon 1 : **Plan** |
| **14/12/2026** | Soutenance jalon 2 : **MVP** |
| 17/01/2027 23:42 | Fin du projet (rendu final) |
| **18/01/2027** | Soutenance jalon 3 : **Produit final** |

## Organisation du dépôt

| Chemin | Contenu |
|---|---|
| `docs/plan/` | Livrables du jalon 1 : choix technologiques, features additionnelles, questions d'architecture, gestion de projet |
| `docs/adr/` | Architecture Decision Records (registres de décisions) |
| `planning/` | Découpage en tâches (WBS), calendrier, chemin critique |
| `spikes/` | Code exploratoire (preuves de concept) servant de preuves pour les choix technologiques |
| `WORKFLOW.md`, `CLAUDE.md`, `docs/roles/`, `.claude/` | Comment l'équipe et l'assistant Claude de chaque membre travaillent ensemble via GitHub (en anglais) |

Chaque document existe en anglais (`*.md`) et en français (`*.fr.md`). L'anglais est la version de référence.

## Démarrage

Les instructions de build et de lancement (Docker Compose, endpoints, APK Android) seront ajoutées avec le MVP.
