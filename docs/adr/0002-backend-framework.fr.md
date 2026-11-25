# 0002. Framework back-end

- **Statut** : Proposé (à accepter après les spikes back-end, objectif 2026-11-26)
- **Date** : 2026-11-23
- **Pourquoi cette décision mérite un registre** : le serveur porte toute la logique métier et le contrat OpenAPI ; en changer plus tard revient à réécrire l'essentiel du produit.

## Contexte
Voir [tech-selection-backend.fr.md](../plan/tech-selection-backend.fr.md). Besoins : OpenAPI servi et testé par contrat, bibliothèques OIDC + OAuth2, hooks en tâche de fond, modules de services extensibles, MVP en 3 semaines à quatre étudiants qui connaissent TypeScript.

## Alternatives envisagées
- **ASP.NET Core** : le plus solide en maturité, performances et auth intégrée ; écarté *pour l'instant* car un seul membre connaît le C# et le client web sera en TypeScript, donc l'équipe travaillerait dans deux langages sur le chemin critique. Serait retenu si les spikes montrent une vélocité équivalente.
- **FastAPI** : la meilleure histoire OpenAPI ; écarté pour ce projet car les tâches de fond persistantes et la structure d'un gros projet demandent plus d'assemblage.

## Décision
**NestJS** (TypeScript, Node.js LTS), OpenAPI via `@nestjs/swagger`, validation des DTO avec `class-validator`, un module Nest par service.

## Conséquences
- ➕ Un seul langage partagé avec le client web ; client typé généré.
- ➕ Le pattern module/provider permet un registre de nœuds sans toucher au moteur (ENG-EXT).
- ➖ Le gros arbre de dépendances npm augmente le risque sur la chaîne d'approvisionnement ; accepté avec lockfiles, `npm audit` et Dependabot en CI.
- ➖ L'OpenAPI par décorateurs peut s'écarter du comportement réel ; accepté, avec un test de contrat en CI.
