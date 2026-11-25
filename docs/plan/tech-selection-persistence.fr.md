# Choix technologique : persistance

> 🇬🇧 [tech-selection-persistence.md](tech-selection-persistence.md) · État : **Brouillon : notes provisoires jusqu'à la fin des spikes (objectif 26/11)** · Responsable : Léandre (avec David pour la sécurité et les sauvegardes)

## 1. Besoin

Ce qu'on stocke et ce que ça implique :

| Donnée | Forme | Contrainte |
|---|---|---|
| Utilisateurs, identifiants locaux (hachés), identités externes (`sub` OIDC + émetteur) | Relationnelle, fortement liée | Contraintes d'unicité, cascade à la suppression du compte |
| Abonnements aux services et **jetons OAuth délégués** | Relationnelle + secret | Chiffrés au repos (SEC-CRYPTO), jamais journalisés |
| Définitions de workflows (nombre de nœuds variable, une condition optionnelle, mappings par key path) | Arbre/graphe, semi-structuré | Validées à l'enregistrement, versionnées, requêtées par type de trigger |
| État des hooks et **événements externes déjà vus** | Beaucoup d'insertions | **Déduplication** : la même occurrence ne doit jamais déclencher deux fois |
| Exécutions et exécutions de nœuds (entrées, sorties, résultat) | Ajout seulement | Requêtées pour l'historique, le suivi, les retries / dead letters (ENG-RETRY) |

Point clé : la difficulté n'est pas de stocker du JSON, c'est **la concurrence et un traitement « presque exactement une fois »** (hooks en parallèle, retries sans effets de bord en double).

## 2. Candidats

| Candidat | Pourquoi il est sur la liste |
|---|---|
| **PostgreSQL** | Intégrité relationnelle + `JSONB` pour les définitions de workflows ; `SELECT … FOR UPDATE SKIP LOCKED` permet d'utiliser la base comme file de tâches simple ; index uniques pour la déduplication ; `pg_dump` / `pg_restore`. |
| **MongoDB** | Le modèle document colle naturellement aux définitions de workflows ; schéma flexible ; populaire dans les projets Node.js. |
| **MySQL / MariaDB** | Base relationnelle mûre, type de colonne JSON, `SKIP LOCKED` depuis MySQL 8. |

Redis n'est pas candidat comme stockage principal : il pourra être ajouté plus tard comme cache ou file (ENG-ASYNC non retenu).

## 3. Critères et poids

| # | Critère | Poids | Mesure |
|---|---|---|---|
| P1 | Intégrité : transactions, clés étrangères, contraintes d'unicité | 3 | Spike : cascade à la suppression du compte, violations de contraintes |
| P2 | Primitives de concurrence pour hooks / déduplication / retries | 3 | Étapes 2–3 du spike : deux workers, insertion d'un événement en double |
| P3 | Sécurité (rôles, TLS, authentification, options de chiffrement, historique CVE) | 3 | Revue de la configuration par défaut pendant le spike |
| P4 | Stockage de définitions de workflows à forme variable | 2 | Étape 1 du spike |
| P5 | Support driver / ORM avec le back-end (TypeScript) | 2 | Support Prisma/Drizzle/TypeORM constaté |
| P6 | Outils de sauvegarde et restauration | 2 | Étape 4 du spike |
| P7 | Simplicité d'exploitation dans Docker | 1 | Image officielle, healthcheck |

## 4. Comparaison (provisoire)

| Critère (poids) | PostgreSQL | MongoDB | MySQL/MariaDB |
|---|---|---|---|
| P1 Intégrité (3) | 5 | 3 | 5 |
| P2 Concurrence (3) | 5 | 3 | 4 |
| P3 Sécurité (3) | 5 | 4 | 4 |
| P4 Formes variables (2) | 4 | 5 | 3 |
| P5 Support ORM (2) | 5 | 4 | 4 |
| P6 Sauvegarde (2) | 5 | 4 | 4 |
| P7 Docker (1) | 5 | 5 | 5 |
| **Total pondéré (max 80)** | **78** | **61** | **66** |

## 5. Preuves pratiques

| Spike | Dossier | Étapes atteintes | Notes |
|---|---|---|---|
| PostgreSQL | `spikes/db-postgresql/` | _à remplir_ | |
| MongoDB | `spikes/db-mongodb/` | _à remplir_ | |
| MySQL | `spikes/db-mysql/` (optionnel, si le temps le permet) | _à remplir_ | |

## 6. Décision (provisoire)

**PostgreSQL 16**, avec les définitions de workflows en `JSONB` (validées par le serveur avant enregistrement) et tout le reste en relationnel.

Pourquoi : nos données sont surtout relationnelles, et notre problème le plus dur (dédupliquer les événements, prendre du travail en concurrence, retries) est résolu par des primitives de la base (`UNIQUE (hook_id, external_event_id)`, `SKIP LOCKED`, transactions), ce qui évite d'avoir besoin d'un broker.

Coûts acceptés :
- Une migration de schéma est nécessaire à chaque changement : itération plus lente qu'avec MongoDB ; atténué par un ORM avec outil de migration.
- Le contenu `JSONB` n'est pas contraint par la base : le validateur du serveur est le seul garde-fou ; atténué par des tests de validation à l'enregistrement.
- Utiliser la base comme file ne tient pas un très gros débit : acceptable pour notre charge ; ENG-ASYNC pourrait la remplacer plus tard.

Voir l'ADR [0003](../adr/0003-persistence.fr.md).
