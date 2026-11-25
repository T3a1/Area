# 0003. Persistance

- **Statut** : Proposé (à accepter après les spikes de persistance, objectif 2026-11-26)
- **Date** : 2026-11-23
- **Pourquoi cette décision mérite un registre** : la déduplication des hooks, les retries et la sécurité des jetons reposent tous sur ce que la base garantit.

## Contexte
Voir [tech-selection-persistence.fr.md](../plan/tech-selection-persistence.fr.md). Données surtout relationnelles, définitions de workflows à forme variable, traitement concurrent des hooks qui ne doit jamais traiter deux fois le même événement.

## Alternatives envisagées
- **MongoDB** : le plus adapté pour stocker des documents de workflow ; écarté pour ce projet car utilisateurs, identités, jetons et exécutions sont relationnels et notre problème le plus dur est la concurrence, où l'on reconstruirait en code ce que PostgreSQL fournit.
- **MySQL/MariaDB** : proche de PostgreSQL ; écarté car le support JSON et la familiarité avec l'outillage PostgreSQL sont moindres.

## Décision
**PostgreSQL 16** : schéma relationnel, définitions de workflows en `JSONB`, `UNIQUE (hook_id, external_event_id)` pour la déduplication, `SELECT … FOR UPDATE SKIP LOCKED` pour prendre du travail.

## Conséquences
- ➕ Pas besoin de broker pour les hooks et les retries (ENG-RETRY n'en exige explicitement pas).
- ➕ `pg_dump`/`pg_restore` simplifient les sauvegardes.
- ➖ Chaque changement de schéma demande une migration ; accepté, géré par l'ORM.
- ➖ La base devient la file : débit limité, et une panne de la base arrête tout ; accepté à notre échelle et rendu visible par SYS-HEALTH.
