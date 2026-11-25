# Services, Actions et REActions (proposition v1)

> 🇬🇧 [services-catalogue.md](services-catalogue.md) · État : **Brouillon à relire en équipe**

## Quotas pour M = 4

| Grandeur | Règle | Minimum | Notre objectif (marge) |
|---|---|---|---|
| S : services disponibles sur **les deux** clients | S ≥ 1 + M, dont au moins la moitié en OAuth2 | 5, dont ≥ 3 OAuth2 | **7**, dont 5 OAuth2 |
| A + R | A + R ≥ 2M + 2 | 10 | **~18** |

Les comptes se font sur le **client le moins complet**, donc chaque service doit aussi pouvoir être souscrit depuis le mobile.

## Fournisseurs d'authentification (qui est l'utilisateur)

| Fournisseur | Protocole | Remarques |
|---|---|---|
| Local | identifiant + mot de passe, confirmation par mail | Obligatoire |
| **Google** | OpenID Connect | Document de découverte, ID token |
| **Microsoft** (Entra ID, comptes perso et pro) | OpenID Connect | Document de découverte, ID token |
| GitHub | OAuth 2.0 seulement (**pas OIDC**) | Peut être proposé en « Se connecter avec GitHub », mais ne remplit pas à lui seul l'exigence OIDC ; documenté comme tel |

## Services (ce que l'application peut faire au nom de l'utilisateur)

| Service | Accès | Actions (détectées par les hooks) | REActions |
|---|---|---|---|
| **GitHub** | OAuth2 | Nouvelle issue dans un dépôt (filtre par label) · Nouvelle pull request · Push sur une branche | Créer une issue · Commenter une issue/PR |
| **Gmail** | OAuth2 (Google) | Nouveau mail correspondant à un filtre (expéditeur, objet, pièce jointe) | Envoyer un mail |
| **Google Calendar** | OAuth2 (Google) | Un événement commence dans N minutes | Créer un événement |
| **Outlook** (Microsoft Graph) | OAuth2 (Microsoft) | Nouveau mail correspondant à un filtre | Envoyer un mail · Créer une tâche Microsoft To Do |
| **Discord** | Jeton de bot (le serveur installe le bot) | Nouveau message contenant un mot-clé dans un salon | Poster un message dans un salon |
| **Spotify** | OAuth2 | Nouveau titre ajouté aux « Titres likés » | Ajouter un titre à une playlist |
| **Timer** | aucun | Chaque jour à HH:MM · Toutes les N minutes | (aucune) |
| **Météo** (Open-Meteo, sans clé) | aucun | Pluie prévue demain dans une ville · Température en dessous/au-dessus de X | (aucune) |

Totaux : **8 services, dont 5 en OAuth2** (GitHub, Gmail, Google Calendar, Outlook, Spotify), **A = 12, R = 8, A + R = 20**.

> ⚠️ Gmail et Google Calendar partagent un même client OAuth Google. Un évaluateur pourrait les compter comme un seul service « Google ». Même dans ce cas, on garde 7 services dont 4 en OAuth2, toujours au-dessus du minimum (5 services, 3 OAuth2).

### Périmètre MVP (14/12)
GitHub, Gmail, Discord, Timer : de quoi faire tourner le workflow du MVP (trigger + 2 réactions + 1 condition), et déjà 4 services.

## Cas d'usage qui font gagner du temps

1. **Tri des bugs (workflow démo, 4 réactions ou plus).** *Trigger* : nouvelle issue GitHub labellisée `bug`. *Condition* : le titre ou les labels contiennent `critical`.
   - **si oui** : message Discord dans `#alerts` avec `{{ trigger.title }}` et `{{ trigger.url }}` → événement Google Calendar « Corriger {{ trigger.title }} » demain à 10h → mail Outlook à la personne d'astreinte → commentaire sur l'issue « Pris en compte, prévu le {{ node_3.start }} ».
   - **sinon** : tâche Microsoft To Do « Regarder {{ trigger.title }} ».
2. **Boîte des cours.** *Trigger* : mail Gmail d'un prof avec pièce jointe → message Discord au groupe → rappel Calendar 2 jours plus tard → tâche To Do.
3. **Brief du matin.** *Trigger* : Timer chaque jour à 7h30. *Condition* : la météo annonce de la pluie → Discord « prends un parapluie » ; sinon rien.
4. **Veille de release.** *Trigger* : push sur `main` d'un dépôt → message Discord → mail à l'équipe.
5. **Partage musical.** *Trigger* : titre liké sur Spotify → ajout à une playlist de groupe → message Discord.

## Questions ouvertes pour l'équipe
- Lesquels de ces services utilisez-*vous* vraiment ? Remplacez tout service que personne n'utilise (le sujet valorise l'usage réel).
- Bot Discord ou simple webhook ? Un webhook est plus simple mais ne fournit pas d'Action.
