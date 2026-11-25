# 0001. Consigner les décisions d'architecture

- **Statut** : Accepté
- **Date** : 2026-11-23
- **Pourquoi cette décision mérite un registre** : elle définit comment toutes les autres décisions sont documentées et défendues (ENG-ADR, soutenances individuelles).

## Contexte
Le sujet exige de documenter les décisions d'architecture importantes « avec les alternatives envisagées, les conséquences et les révisions ultérieures », et chaque membre doit défendre une décision à laquelle il a contribué. Des décisions éparpillées dans des messages sont perdues et indéfendables.

## Alternatives envisagées
- **Un seul document « architecture.md »** : simple à écrire, mais les révisions écrasent l'historique ; écarté car on doit montrer comment les décisions ont évolué.
- **Wiki (GitHub Wiki / Notion)** : vit hors du dépôt et hors de la revue de code ; écarté car les évaluateurs lisent le dépôt.

## Décision
On garde les ADR dans `docs/adr/`, un par décision, en anglais et en français, au format décrit dans le [README](README.fr.md). Un ADR est ajouté dans la même pull request que le changement qu'il justifie.

## Conséquences
- ➕ Les décisions sont relues comme du code et versionnées avec lui.
- ➕ Les remplacements sont explicites, ce qui alimente l'analyse des changements du MVP et le post-mortem.
- ➖ Écrire et traduire chaque registre prend du temps (≈30 min par ADR) ; on l'accepte et on garde les registres courts.
