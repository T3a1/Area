# Architecture Decision Records (registres de décisions)

> 🇬🇧 [README.md](README.md)

Un fichier par décision significative, numéroté dans l'ordre : `NNNN-<slug>.md` (anglais) et `NNNN-<slug>.fr.md` (français).

Format (adapté du modèle de Michael Nygard et de MADR) :

- **Statut** : `Proposé` → `Accepté` → (`Obsolète` | `Remplacé par NNNN`). Un registre remplacé n'est jamais supprimé ; il pointe vers son remplaçant.
- **Date** du dernier changement de statut.
- **Pourquoi cette décision mérite un registre** : une phrase (exigé par ENG-ADR).
- **Contexte** : les forces en jeu, pour *ce* projet.
- **Alternatives envisagées** : de vraies options, écartées *pour ce projet*, pas déclarées mauvaises dans l'absolu.
- **Décision**.
- **Conséquences** : positives et **au moins une conséquence négative acceptée**.

| # | Titre | Statut |
|---|---|---|
| [0001](0001-record-architecture-decisions.fr.md) | Consigner les décisions d'architecture | Accepté |
| [0002](0002-backend-framework.fr.md) | Framework back-end | Proposé |
| [0003](0003-persistence.fr.md) | Persistance | Proposé |
| [0004](0004-mobile-client.fr.md) | Technologie du client Android | Proposé |
| [0005](0005-web-client.fr.md) | Technologie du client web | Proposé (ouvert) |

Prévus avant le MVP : modèle du moteur de workflows (chaîne linéaire + une condition, substitution par key path), déduplication des événements des hooks, stockage et chiffrement des jetons OAuth.
