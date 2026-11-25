# 0004. Technologie du client Android

- **Statut** : Proposé (à accepter après le spike mobile, objectif 2026-11-26)
- **Date** : 2026-11-23
- **Pourquoi cette décision mérite un registre** : une règle de l'école interdit les frameworks multiplateformes web+mobile, ce qui retire les options les plus courantes et doit être expliqué.

## Contexte
Voir [tech-selection-frontend.fr.md](../plan/tech-selection-frontend.fr.md). Android uniquement, adresse du serveur configurable, OAuth sur mobile, WCAG AA, deux langues, APK construit dans Docker. React Native, Flutter, Ionic et Compose Multiplatform sont **interdits** par l'école.

## Alternatives envisagées
- **Kotlin + Views (XML)** : stable et bien documenté ; écarté car construire de nombreux écrans liste/détail/réglages est plus lent, et le modèle déclaratif de Compose est plus proche du client web.
- **Java + Views** : langage familier ; écarté car les bibliothèques Android modernes (Compose, coroutines, exemples AppAuth) sont pensées pour Kotlin.

## Décision
**Kotlin + Jetpack Compose** (Material 3), client Retrofit généré depuis la description OpenAPI, AppAuth avec PKCE, DataStore pour les réglages.

## Conséquences
- ➕ Développement rapide des écrans, sémantique d'accessibilité intégrée.
- ➖ Pas de version iOS (bonus abandonné) ; accepté.
- ➖ Logique de présentation dupliquée avec le web ; accepté, toutes les règles restent sur le serveur.
