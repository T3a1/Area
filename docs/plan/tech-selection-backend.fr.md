# Choix technologique : back-end

> 🇬🇧 [tech-selection-backend.md](tech-selection-backend.md) · État : **Brouillon : notes provisoires jusqu'à la fin des spikes (objectif 26/11)** · Responsable : Léandre

## 1. Besoin

Le serveur applicatif porte **toute la logique métier** : comptes, authentification locale et OIDC, abonnements OAuth2 aux services et stockage des jetons, catalogue des services (`about.json`), validation des workflows, moteur d'exécution, et **hooks qui tournent sans client ouvert**. Il doit servir une **description OpenAPI** qui sert de contrat avec deux clients développés séparément, et des tests doivent échouer si implémentation et description divergent.

Conséquences pour le choix :
- OpenAPI doit être un citoyen de première classe (généré depuis le code ou validé contre lui).
- La planification de tâches de fond (hooks par polling) puis les retries doivent être simples.
- Des bibliothèques mûres et maintenues pour OIDC, OAuth2, hachage de mots de passe, validation des entrées, limitation de débit.
- Quatre étudiants, trois semaines jusqu'au MVP : la courbe d'apprentissage compte.

## 2. Candidats

| Candidat | Pourquoi il est sur la liste |
|---|---|
| **NestJS** (TypeScript, Node.js) | L'équipe connaît déjà TypeScript ; architecture modulaire (modules / providers) qui colle à « un module par service » ; `@nestjs/swagger` génère l'OpenAPI depuis les décorateurs ; `@nestjs/schedule`, intégration BullMQ. |
| **ASP.NET Core** (C#) | Un membre l'a déjà utilisé ; support OpenAPI intégré, typage fort, excellentes performances, middleware d'identité/auth mûr, Hangfire/Quartz pour les tâches. |
| **FastAPI** (Python) | OpenAPI généré nativement depuis les annotations de type, Swagger UI inclus ; prototypage très rapide ; validation Pydantic. |

Écartés avant les spikes : les frameworks full-stack (Next.js, Nuxt, SvelteKit, Django avec templates…) car le sujet déconseille fortement de mélanger client et serveur ; Go et Rust ont été envisagés mais jugés trop coûteux à apprendre en parallèle du reste en trois semaines.

## 3. Critères et poids

Poids : **3** = peut faire échouer le projet, **2** = coût ou risque important, **1** = appréciable.

| # | Critère | Poids | Comment on le mesure |
|---|---|---|---|
| C1 | Contrat OpenAPI : génération + test de contrat | 3 | Étapes 4–5 du spike atteintes ? Effort pour garder spec et code synchronisés |
| C2 | Écosystème sécurité (clients OIDC/OAuth2, hachage, validation, rate limiting, historique CVE) | 3 | Bibliothèques trouvées et maintenues ; réglages sûrs par défaut observés pendant le spike |
| C3 | Tâches de fond / planification pour les hooks | 3 | Étape 7 du spike atteinte ; options pour des tâches persistantes |
| C4 | Courbe d'apprentissage de l'équipe | 2 | Temps passé en boilerplate vs fonctionnalités pendant le spike |
| C5 | Outillage de test (unitaire, fonctionnel, HTTP) | 2 | Test écrit et lancé pendant le spike |
| C6 | Structure pour l'extensibilité (ajouter un service sans toucher au moteur) | 2 | Pattern naturel de plugins / registre |
| C7 | Simplicité de l'image Docker et de la CI | 1 | Taille de l'image, temps de build |
| C8 | Performance / empreinte à l'exécution | 1 | Mémoire au repos, peu critique à notre échelle |

## 4. Comparaison (provisoire, à remplacer par les résultats des spikes)

Notes de 1 à 5. Chaque membre remplit la matrice **seul** après les spikes ; les écarts de plus de 2 points sont discutés et notés plus bas.

| Critère (poids) | NestJS | ASP.NET Core | FastAPI |
|---|---|---|---|
| C1 OpenAPI (3) | 4 | 5 | 5 |
| C2 Écosystème sécurité (3) | 4 | 5 | 4 |
| C3 Tâches de fond (3) | 4 | 5 | 3 |
| C4 Courbe d'apprentissage (2) | 5 | 3 | 4 |
| C5 Tests (2) | 4 | 4 | 4 |
| C6 Extensibilité (2) | 5 | 4 | 3 |
| C7 Docker/CI (1) | 4 | 3 | 4 |
| C8 Performance (1) | 3 | 5 | 3 |
| **Total pondéré (max 85)** | **71** | **75** | **65** |

Lecture : ASP.NET Core est légèrement devant sur le papier (75 contre 71), surtout grâce à sa maturité (sécurité, tâches de fond, performances) ; NestJS gagne sur la courbe d'apprentissage et l'extensibilité. Un écart de 4 points sur des notes provisoires n'est pas une décision : les spikes doivent trancher C1 (à quel point le test de contrat est pénible) et C4 (à quelle vitesse l'équipe avance réellement). FastAPI est plus faible sur les tâches persistantes et la structure pour un projet de cette taille.

## 5. Preuves pratiques

| Spike | Dossier | Étapes atteintes | Notes |
|---|---|---|---|
| NestJS | `spikes/backend-nestjs/` | _à remplir_ | |
| ASP.NET Core | `spikes/backend-aspnet/` | _à remplir_ | |
| FastAPI | `spikes/backend-fastapi/` | _à remplir_ | |

## 6. Divergences entre membres

_À remplir après la notation individuelle._

## 7. Décision (provisoire)

**NestJS (TypeScript)**, sauf si les spikes confirment l'avance d'ASP.NET Core sur C1–C3. C'est un pari assumé sur la vélocité de l'équipe (C4) pour un MVP en 3 semaines ; si les spikes montrent que l'équipe est aussi rapide en C#, ASP.NET Core l'emporte.

Raisons principales : même langage que le client web (modèle mental partagé, client TypeScript généré depuis l'OpenAPI), montée en compétence la plus rapide pour toute l'équipe, système de modules adapté à ENG-EXT (un module par service / type de nœud).

Coûts acceptés :
- L'arbre de dépendances Node.js est grand : plus d'exposition à la chaîne d'approvisionnement (atténué par le lockfile, `npm audit` en CI, Dependabot).
- L'OpenAPI généré par décorateurs peut s'écarter de la réalité si les DTO ne sont pas utilisés partout : atténué par un test de contrat (schemathesis ou jest + validateur OpenAPI) en CI.
- Performances brutes inférieures à .NET : sans importance à notre échelle.

Sous-décisions à prendre pendant le MVP : ORM (Prisma vs Drizzle vs TypeORM), bibliothèque de tâches (`@nestjs/schedule` + PostgreSQL vs BullMQ + Redis).

Voir l'ADR [0002](../adr/0002-backend-framework.fr.md).
