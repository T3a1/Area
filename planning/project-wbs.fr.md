# WBS du projet (découpage en tâches)

> 🇬🇧 [project-wbs.md](project-wbs.md) · État : **Brouillon v1 (2026-11-23)** : revu chaque lundi ; les changements sont notés en bas.

Les durées sont en jours ouvrés (0,5 = une demi-journée). Les tâches marquées 🔴 sont sur le **chemin critique** : si l'une glisse, un jalon glisse. Les responsables suivent la répartition convenue : Romane (web, accessibilité), Léandre (serveur, moteur), Thomas (mobile), David (auth, infra).

## Phase 1 : Plan (23/11 → 01/12)

| ID | Tâche | Responsable | Jours | Prédécesseurs | Début | Fin | Crit. |
|---|---|---|---|---|---|---|---|
| P01 | Inscrire l'équipe à toutes les soutenances (limite 29/11 23:42) | Tous | 0,1 | — | 23/11 | 23/11 |  |
| P02 | Structure du dépôt, protection de `main`, board GitHub Project avec limites de WIP | David | 0,5 | — | 23/11 | 23/11 |  |
| P03 | Lire le sujet ensemble, fixer les critères par couche et la timebox des spikes | Tous | 0,5 | — | 23/11 | 23/11 | 🔴 |
| P04 | Spike back-end : NestJS | Léandre | 0,5 | P03 | 24/11 | 24/11 | 🔴 |
| P05 | Spike back-end : ASP.NET Core | David | 0,5 | P03 | 24/11 | 24/11 |  |
| P06 | Spike back-end : FastAPI | Thomas | 0,5 | P03 | 24/11 | 24/11 |  |
| P07 | Spike web : React + React Flow | Romane | 0,5 | P03 | 24/11 | 24/11 |  |
| P08 | Spike web : Svelte + Svelte Flow | Romane | 0,5 | P03 | 25/11 | 25/11 |  |
| P09 | Spike mobile : Kotlin + Compose (+ redirection AppAuth) | Thomas | 0,5 | P03 | 25/11 | 25/11 |  |
| P10 | Spike mobile : Kotlin + Views (XML) | Thomas | 0,5 | P03 | 25/11 | 25/11 |  |
| P11 | Spike persistance : PostgreSQL (déduplication, SKIP LOCKED, sauvegarde) | Léandre | 0,5 | P04 | 25/11 | 25/11 | 🔴 |
| P12 | Spike persistance : MongoDB | David | 0,5 | P05 | 25/11 | 25/11 |  |
| P13 | Spike auth : login OIDC Google + OAuth GitHub sur le candidat back-end | David | 0,5 | P04 | 26/11 | 26/11 |  |
| P14 | Rédiger chaque `SPIKE.md` et `spikes/DISTANCE.md` | Tous | 0,5 | P04–P12 | 26/11 | 26/11 | 🔴 |
| P15 | Noter les matrices chacun de son côté, discuter les écarts > 2 points | Tous | 0,5 | P14 | 26/11 | 26/11 | 🔴 |
| P16 | Finaliser les 3 documents de choix techno (back, front, persistance) | Léandre, Romane, Thomas | 0,5 | P15 | 27/11 | 27/11 | 🔴 |
| P17 | Passer les ADR 0002–0005 en Accepté (ou les réviser) | Romane | 0,5 | P16 | 27/11 | 27/11 | 🔴 |
| P18 | Relire le catalogue de services : garder ceux que l'équipe utilise vraiment | Tous | 0,5 | P13 | 26/11 | 26/11 |  |
| P19 | Sélection des features et responsables (fait : 9 points) | Tous | 0,25 | — | 23/11 | 23/11 |  |
| P20 | Chaque membre réécrit sa question d'architecture | Chaque membre | 0,25 | P14 | 27/11 | 27/11 |  |
| P21 | Document de gestion de projet + board configuré | David | 0,5 | P02 | 27/11 | 27/11 |  |
| P22 | Relire ce WBS, charger chaque tâche dans GitHub Projects avec responsable, dates et dépendances | Léandre | 1 | P16, P18, P19 | 28/11 | 28/11 | 🔴 |
| P23 | Répétition de la soutenance Plan et relecture finale | Tous | 0,5 | P17, P20, P21, P22 | 30/11 | 30/11 | 🔴 |
| ◆1 | **Jalon 1 : soutenance Plan** | Tous | — | P23 | 01/12 | 01/12 | 🔴 |

## Phase 2 : MVP (01/12 → 14/12)

| ID | Tâche | Responsable | Jours | Prédécesseurs | Début | Fin | Crit. |
|---|---|---|---|---|---|---|---|
| M01 | Squelette du monorepo (`server/`, `web/`, `mobile/`) + Docker Compose minimal avec PostgreSQL | David | 1 | P17 | 01/12 | 01/12 | 🔴 |
| M02 | CI : lint + tests + build par composant sur chaque PR, échec visible | David | 1 | M01 | 02/12 | 02/12 |  |
| M03 | `.env.example` + gitleaks en CI (SYS-SECRETS v1) | David | 0,5 | M02 | 03/12 | 03/12 |  |
| M04 | Schéma de base v1 + migrations (utilisateurs, identités, abonnements, jetons, workflows, exécutions, événements) | Léandre | 1 | M01 | 02/12 | 02/12 | 🔴 |
| M05 | Auth locale : inscription, confirmation par mail, connexion, sessions | David | 1,5 | M04 | 03/12 | 04/12 |  |
| M06 | Connexion OIDC avec Google | David | 1 | M05 | 05/12 | 05/12 |  |
| M07 | Framework d'abonnement OAuth2 + stockage chiffré des jetons (SEC-CRYPTO v1) | David | 2 | M05 | 06/12 | 07/12 |  |
| M08 | Interface de nœud + registre (ENG-EXT) | Léandre | 1 | M04 | 03/12 | 03/12 | 🔴 |
| M09 | `about.json` généré depuis le registre | Léandre | 0,5 | M08 | 04/12 | 04/12 |  |
| M10 | Modèle de workflow + validation à l'enregistrement (structure, key paths) | Léandre | 1,5 | M08 | 04/12 | 05/12 | 🔴 |
| M11 | Moteur : chaîne linéaire, condition, substitution par key path, enregistrement des exécutions | Léandre | 2 | M10 | 06/12 | 07/12 | 🔴 |
| M12 | Ordonnanceur de hooks : polling, curseur, déduplication | Léandre | 1,5 | M11 | 08/12 | 09/12 | 🔴 |
| M13 | Services du MVP : GitHub (nouvelle issue, commentaire), Gmail (envoi), Discord (message), Timer | David | 2 | M07, M08 | 08/12 | 09/12 |  |
| M14 | OpenAPI servi + Swagger UI + test de contrat en CI | Thomas | 1 | M02 | 03/12 | 03/12 |  |
| M15 | `GET /health` v1 (SYS-HEALTH) | Romane | 0,5 | M01 | 03/12 | 03/12 |  |
| M16 | Web : mise en place, routage, design tokens, i18n (2 langues), axe en CI | Romane | 1,5 | M01 | 01/12 | 02/12 |  |
| M17 | Web : écrans inscription / connexion / connexion Google | Romane | 1,5 | M16, M05 | 04/12 | 05/12 |  |
| M18 | Web : page des services (s'abonner / se désabonner) | Romane | 1 | M17, M07 | 09/12 | 09/12 |  |
| M19 | Web : builder v1 (trigger, condition, réactions, sélecteur de key path) | Romane | 3 | M17, M10 | 06/12 | 08/12 | 🔴 |
| M20 | Web : liste des workflows + historique des exécutions | Romane | 1 | M11 | 10/12 | 10/12 |  |
| M21 | Mobile : mise en place, réglage de l'adresse serveur, i18n, composants de base | Thomas | 1,5 | M01 | 01/12 | 02/12 |  |
| M22 | Mobile : client API généré + écrans d'auth (dont Google via AppAuth) | Thomas | 2 | M21, M05, M14 | 05/12 | 06/12 |  |
| M23 | Mobile : abonnement aux services (Custom Tabs) | Thomas | 1,5 | M22, M07 | 08/12 | 09/12 |  |
| M24 | Mobile : liste des workflows, activer/désactiver, exécutions | Thomas | 1,5 | M23, M11 | 09/12 | 10/12 |  |
| M25 | Docker Compose complet + service de build de l'APK | David | 1 | M02, M21 | 10/12 | 10/12 |  |
| M26 | ADR : moteur de workflows, déduplication des hooks, stockage des jetons | Romane, Léandre | 0,5 | M12 | 10/12 | 10/12 |  |
| M27 | Workflow MVP de bout en bout (trigger + 2 réactions + 1 condition) sur les deux clients | Tous | 1 | M12, M13, M19, M24, M25 | 11/12 | 11/12 | 🔴 |
| M28 | Documentation technique v1 + plan mis à jour + analyse des changements | Léandre, David | 1 | M27 | 12/12 | 12/12 | 🔴 |
| M29 | Décider de la (dernière) révision de la sélection de features | Tous | 0,25 | M27 | 12/12 | 12/12 |  |
| M30 | Répétition MVP + enregistrement de secours de la démo | Tous | 0,5 | M28 | 13/12 | 13/12 | 🔴 |
| ◆2 | **Jalon 2 : soutenance MVP** | Tous | — | M30 | 14/12 | 14/12 | 🔴 |

## Phase 3 : Produit final (15/12 → 18/01)

Vacances : **22/12 → 03/01**, aucune tâche prévue hormis de la marge optionnelle. Le week-end du **09–10/01** sert de marge.

| ID | Tâche | Responsable | Jours | Prédécesseurs | Début | Fin | Crit. |
|---|---|---|---|---|---|---|---|
| F01 | Rétrospective MVP + mise à jour du plan | Tous | 0,5 | ◆2 | 15/12 | 15/12 | 🔴 |
| F02 | Connexion OIDC Microsoft + règles de liaison d'identités | David | 1,5 | F01 | 16/12 | 17/12 |  |
| F03 | Services : Google Calendar, Outlook + Microsoft To Do | Léandre | 3 | F01 | 16/12 | 18/12 | 🔴 |
| F04 | Services : Spotify, Météo, actions GitHub supplémentaires | David | 2 | F02 | 18/12 | 21/12 |  |
| F05 | ENG-RETRY : politique configurable, backoff, clés d'idempotence | Thomas | 3 | M11 | 16/12 | 18/12 |  |
| F06 | ENG-RETRY : stockage des dead letters, API de rejeu, vue web | Thomas | 2 | F05 | 05/01 | 06/01 |  |
| F07 | SEC-CRYPTO : dump avant/après, détection d'altération, rotation de clé, vérification des logs, fiche de preuve | David | 2 | M07 | 04/01 | 05/01 |  |
| F08 | SYS-SECRETS : scan de l'historique, grep des logs, test sur clone neuf, preuves | David | 1 | M03 | 06/01 | 06/01 |  |
| F09 | SYS-HEALTH : vérifs OIDC + ordonnanceur, borne d'1 s, 503, aucune fuite | Romane | 1 | M15 | 16/12 | 16/12 |  |
| F10 | ENG-EXT : `HOWTOCONTRIBUTE.md`, dernier nœud dans un commit isolé, répétition de l'ajout en live | Léandre | 2 | F03 | 05/01 | 06/01 | 🔴 |
| F11 | Builder v2 : UX du mapping, erreurs de validation, branches de condition, ≥ 4 réactions | Romane | 3 | M19 | 17/12 | 21/12 |  |
| F12 | Workflow démo avec ≥ 4 nœuds réaction (tri des bugs) | Léandre | 1 | F03, F11, F10 | 07/01 | 07/01 | 🔴 |
| F13 | Parité mobile : chaque service souscriptible, détail des exécutions | Thomas | 3 | M24, F03, F04 | 21/12 | 04/01 |  |
| F14 | i18n complète sur tout le parcours principal, deux clients | Romane, Thomas | 1 | F11, F13 | 11/01 | 11/01 |  |
| F15 | Audit WCAG AA des deux clients, corrections, rapport d'audit | Romane, Thomas | 2 | F14 | 12/01 | 13/01 |  |
| F16 | Tests unitaires + fonctionnels sur les cas de succès et d'échec (en continu) | Tous | 4 | F05 | 04/01 | 08/01 |  |
| F17 | CD : déploiement automatique sans étape manuelle | David | 2 | M25 | 07/01 | 08/01 |  |
| F18 | ADR finalisés (≥ 3, remplacements liés) | Romane | 0,5 | F10 | 08/01 | 08/01 |  |
| F19 | README, HOWTOCONTRIBUTE, doc technique (sémantique d'échec, persistance, carte features→critères) | Léandre, David | 2 | F10, F17 | 12/01 | 13/01 | 🔴 |
| F20 | Artefacts de planning finaux + post-mortem | Tous | 1 | F19 | 14/01 | 14/01 | 🔴 |
| F21 | Présentation, scénario de démo live, enregistrement de secours | Tous | 1,5 | F12, F15, F20 | 15/01 | 16/01 | 🔴 |
| F22 | Gel et rendu final (avant 23:42) | Tous | 0,5 | F21 | 17/01 | 17/01 | 🔴 |
| ◆3 | **Jalon 3 : soutenance finale** | Tous | — | F22 | 18/01 | 18/01 | 🔴 |

## Chemin critique

P03 → P04 → P11 → P14 → P15 → P16 → P17 → M01 → M04 → M08 → M10 → M11 → M12 → M27 → M28 → M30 → ◆2 → F01 → F03 → F10 → F12 → F21 → F22 → ◆3

La **chaîne du moteur de workflows (M04 → M12)**, portée par Léandre, est la colonne vertébrale du projet : le builder (M19), les services (M13) et les listes mobiles (M24) l'attendent tous. Le builder web (M19) n'a presque pas de marge non plus.

## Analyse du planning

- **Peut glisser de deux jours sans déplacer un jalon** : M15 (`/health` v1), P10 (spike Views), M26 (ADR), F09 (finalisation SYS-HEALTH). Elles ont plusieurs jours de marge.
- **Décale tout dès qu'elle glisse d'une heure** : M11 (moteur). M27 (MVP de bout en bout) commence le lendemain de la fin de M12 et la soutenance MVP est fixe.
- **Deux tâches qui se disputent la même personne** :
  - Léandre les 08–09/12 : ordonnanceur de hooks (M12) et services du MVP (M13). Résolu en confiant M13 à David, relu par Léandre.
  - Romane les 24–25/11 et 06–10/12 : les deux spikes web, puis builder + page services + historique. Risque accepté ; Thomas peut prendre M20 si Romane est en retard.
  - David porte l'auth, l'OAuth, l'infra et deux features de sécurité : à surveiller à chaque revue hebdomadaire ; Thomas peut prendre M25 (build APK) si besoin.

## Risques

| Risque | Impact | Atténuation |
|---|---|---|
| Validation des apps OAuth / quotas (Google, Microsoft) | Service inutilisable en démo | Créer les apps dès la semaine 1, utiliser des utilisateurs de test, garder un enregistrement de secours |
| Moteur en retard (chemin critique) | MVP raté | Périmètre du moteur figé à « linéaire + 1 condition » ; Thomas aide sur les tests |
| Accessibilité repoussée à la fin | Exigence finale ratée | axe en CI dès M16, audit F15 prévu assez tôt pour corriger |
| Vacances | ~2 semaines perdues | Rien de critique dessus ; F13 réparti autour |

## Journal des changements

| Date | Changement | Raison | Coût |
|---|---|---|---|
| 2026-11-23 | v1 | Plan initial | — |
