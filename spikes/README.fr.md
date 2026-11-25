# Spikes (preuves de concept)

> 🇬🇧 [README.md](README.md)

Un spike est un **temps fixe passé à acheter de l'information**, pas à construire une fonctionnalité. Quand le minuteur sonne, on s'arrête, que ça marche ou non. Les spikes sont les preuves pratiques derrière `docs/plan/tech-selection-*.md`.

## Règles

1. Même timebox pour chaque candidat d'une couche (par défaut : **3 heures**, voir plus bas).
2. Même objectif pour chaque candidat (ci-dessous).
3. Un dossier par candidat : `spikes/<couche>-<techno>/`, avec le code et un `SPIKE.md`.
4. Rédiger le `SPIKE.md` **immédiatement** quand le minuteur sonne.
5. Ne pas prolonger la timebox pour la techno qu'on préfère déjà.

Pourquoi 3 heures : assez pour atteindre les étapes OpenAPI et base de données, là où les candidats diffèrent vraiment, et assez court pour passer trois candidats par couche avant le 27/11.

## Objectifs par couche

### Back-end (`spikes/backend-<techno>/`)
1. Serveur sur le port lu dans la variable d'environnement `PORT` (8080 par défaut).
2. `GET /ping` → `200` avec exactement `{"status":"ok"}`.
3. `POST /workflows` qui valide un petit corps JSON (refus en `400` avec un corps d'erreur).
4. Description OpenAPI servie avec une interface navigable, générée ou écrite ; elle doit inclure la réponse `400`.
5. Un test automatisé qui échoue quand l'implémentation et la description OpenAPI divergent.
6. Enregistrer le workflow en PostgreSQL (ou le candidat de persistance) et le relire.
7. Bonus : une tâche de fond qui tourne toutes les 30 s sans requête HTTP.

### Web (`spikes/web-<techno>/`)
1. SPA construite avec Vite, appelant `GET /ping` sur une URL de serveur configurable.
2. Un graphe de 3 nœuds (trigger → condition → réaction) modifiable **uniquement au clavier**.
3. Deux langues, changeables à la volée.
4. Score d'accessibilité Lighthouse / axe noté.

### Mobile (`spikes/mobile-<techno>/`)
1. Écran de réglages pour saisir l'adresse du serveur, persistée.
2. Appel à `GET /ping` et affichage du résultat ; état d'erreur si injoignable.
3. Deux langues (suivant la langue du système).
4. Ouvre une URL d'autorisation OAuth dans un Custom Tab et reçoit la redirection (deep link).
5. APK debug construit en ligne de commande (`./gradlew assembleDebug`).

### Persistance (`spikes/db-<techno>/`)
1. Stocker un workflow (nombre de nœuds variable) et requêter « tous les workflows actifs dont le trigger est X ».
2. Deux workers concurrents prennent des événements en attente **sans traiter deux fois le même**.
3. Insérer deux fois le même identifiant d'événement externe : le second est refusé ou ignoré (déduplication).
4. Sauvegarde et restauration en une seule commande.

## Modèle de `SPIKE.md`

```markdown
# Spike : <techno>
- Auteur(s) :
- Date / timebox :
- Étapes atteintes (1..n) :
## Où on en était quand le temps s'est écoulé
## Ce qui a pris le plus de minutes
## Ce qu'il faudrait pour aller plus loin
## Observations de sécurité (libs d'auth, validation, réglages par défaut, CVE connues)
## Verdict (1 ligne)
```

## `DISTANCE.md`

Un tableau par couche comparant les candidats. Notre définition de la **distance parcourue** = nombre d'étapes de l'objectif entièrement atteintes dans la timebox, pondérées par leur difficulté pour *notre* projet (le test de contrat OpenAPI et les tâches de fond comptent double), plus le nombre de blocages rencontrés.
