# Features additionnelles : sélection

> 🇬🇧 [additional-features.md](additional-features.md) · État : **Choisie par l'équipe le 2026-11-23** (révisable une fois, au jalon MVP du 2026-12-14)

## Résumé

| Id | Sujet | Difficulté | Domaine | Responsable | Observable au MVP ? |
|---|---|---|---|---|---|
| ENG-ADR | Registres de décisions d'architecture | 1 | Génie logiciel | Romane | ✅ oui |
| ENG-EXT | Connecteurs extensibles | 2 | Génie logiciel | Léandre | 🟡 en partie (interface de nœud + registre) |
| ENG-RETRY | Retries et idempotence | 2 | Génie logiciel | Thomas | ❌ après le MVP |
| SEC-CRYPTO | Chiffrement au repos | 2 | Sécurité | David | 🟡 en partie (jetons chiffrés) |
| SYS-HEALTH | Health checks | 1 | Système | Romane | ✅ oui |
| SYS-SECRETS | Gestion des secrets | 1 | Système | David | ✅ oui |
| **Total D** | | **9** | 3 domaines | | ≥ 3 points au MVP (1/3 de 9) |

Exigence : **D ≥ 2 × M = 8**. On prend **9** pour garder un point de marge : une feature pas entièrement livrée ne compte pour rien.

## Justification de la sélection

1. **Synergie avec la base commune.** Chaque feature renforce quelque chose que la base commune exige déjà : ADR (décisions documentées), HOWTOCONTRIBUTE.md (ENG-EXT), stockage des jetons OAuth (SEC-CRYPTO), configuration Docker Compose (SYS-SECRETS), hooks autonomes (SYS-HEALTH, ENG-RETRY). Peu d'effort part dans des features à côté du produit.
2. **Trois domaines.** Génie logiciel, sécurité et système, comme le recommande le sujet.
3. **Contre nos faiblesses, pas par confort.** Les responsables sont volontairement placés hors de leur domaine principal quand c'est possible : Romane (UI/UX) porte deux features serveur/processus ; Thomas (mobile) porte le moteur de retry.
4. **Risque.** Aucune feature de difficulté 3 : le MVP arrive trois semaines après le début, et une grosse feature ratée coûterait 3 points d'un coup. AI-NODE (3) reste candidate pour l'unique révision autorisée au MVP.

## Par feature : objectif d'apprentissage et critères d'acceptation

### ENG-ADR (1) : Romane
*Apprentissage* : écrire une décision pour qu'une personne absente puisse la reformuler avec son coût.
- [ ] ≥ 3 ADR significatifs, dont un sur le **moteur de workflows**, chacun disant pourquoi il mérite un registre.
- [ ] Chacun a un contexte, de vraies alternatives, une décision, des conséquences acceptées.
- [ ] Les alternatives sont écartées *pour ce projet*.
- [ ] Datés, avec statut ; les remplacés pointent vers leur remplaçant.
- [ ] Chaque membre sait décrire le produit avec une option écartée.
*Où l'observer* : `docs/adr/`.

### ENG-EXT (2) : Léandre
*Apprentissage* : concevoir une frontière de plugins (interface + registre) qui garde le moteur fermé à la modification.
- [ ] Interface de nœud commune et documentée (validation + exécution).
- [ ] Types de nœuds enregistrés au démarrage, sans chargement dynamique de code tiers.
- [ ] Le commit qui ajoute le dernier type de nœud ne touche que ce nœud et son enregistrement.
- [ ] Procédure dans `HOWTOCONTRIBUTE.md` ; un nœud trivial est ajouté en live pendant la soutenance.
- [ ] Une nouvelle Action/REAction apparaît dans `about.json` sans second catalogue.
*Où l'observer* : `server/src/nodes/`, historique git, `HOWTOCONTRIBUTE.md`, `GET /about.json`.

### ENG-RETRY (2) : Thomas
*Apprentissage* : comprendre comment retry, persistance et idempotence dépendent les uns des autres.
- [ ] Retries automatiques bornés avec délais croissants, annoncés à l'avance.
- [ ] Aucun broker requis.
- [ ] REActions à effet de bord protégées contre les doublons (clé d'idempotence par exécution + nœud).
- [ ] Stockage des dead letters, consultable et rejouable.
- [ ] L'évaluateur supprime la cause et rejoue avec succès une exécution en dead letter.
- [ ] La politique (tentatives, délais) est de la configuration.
*Où l'observer* : `server/src/engine/retry`, API + vue web des dead letters, fichier de configuration.

### SEC-CRYPTO (2) : David
*Apprentissage* : chiffrement authentifié, gestion et rotation des clés.
- [ ] Montrer ce qu'un dump de la base exposait **avant** le chiffrement.
- [ ] Jetons tiers chiffrés avec un chiffrement authentifié (AES-256-GCM) ; l'évaluateur lit du texte chiffré.
- [ ] Clé hors du code, du dépôt et de la base ; mise à disposition documentée.
- [ ] Aucun jeton (en clair ou chiffré) dans les logs d'une exécution complète.
- [ ] Rotation de clé documentée (identifiant de clé stocké avec chaque texte chiffré).
- [ ] Un octet modifié → jeton refusé.
*Où l'observer* : `docs/security/SEC-CRYPTO.md` (modèle de preuve), session `psql`, logs.

### SYS-HEALTH (1) : Romane
*Apprentissage* : modéliser les dépendances et borner les vérifications.
- [ ] `GET /health` rapporte séparément la base, les fournisseurs OIDC et l'ordonnanceur des hooks (JSON).
- [ ] Dépendance requise en panne → statut en échec (HTTP 503).
- [ ] L'arrêt du conteneur de base est identifié.
- [ ] Répond en moins d'1 s même si une dépendance est injoignable.
- [ ] Aucun secret, chaîne de connexion ou stack trace exposé.

### SYS-SECRETS (1) : David
*Apprentissage* : hygiène des secrets dans le code, l'historique, les images et les logs.
- [ ] Scan de secrets (gitleaks) sur le contenu et l'historique propre, en CI.
- [ ] `.env.example` complet avec descriptions et valeurs inoffensives.
- [ ] Clone neuf + `.env` issu de l'exemple démarre le produit.
- [ ] Secrets uniquement par l'environnement, jamais intégrés aux images.
- [ ] Aucun secret dans les logs des services (grep d'une exécution complète).

## Politique de révision
La sélection peut être révisée **une fois**, au MVP (2026-12-14). Candidates si une feature s'avère plus dure que prévu : AI-NODE (3), SEC-DEPS (1), SYS-BACKUP (2). Toute mauvaise surprise de difficulté est signalée tout de suite au responsable local et notée pour le post-mortem.
