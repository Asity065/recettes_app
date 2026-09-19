# Changelog

## v1.2 — Corrections suite à revue externe

Un rapport de revue automatisé signalait deux problèmes présentés comme
« critiques ». Vérification faite sur le code réellement livré :

- **`toggleFavorite` prétendument tronqué** : **faux**. La méthode est
  complète dans `recipe_provider.dart` (v1.0/v1.1). Vérifié ligne par ligne.
- **`search_filter_bar.dart` prétendument manquant** : **faux**. Le fichier
  existe, est complet, et déjà utilisé par `home_screen.dart` depuis la v1.0.

Ces deux signalements semblent provenir d'un outil n'ayant reçu qu'un
sous-ensemble tronqué des fichiers, pas l'archive complète. En revanche, le
reste du rapport contenait des remarques légitimes, traitées ci-dessous :

### Architecture — séparation des responsabilités
- **Nouveau `FavoritesProvider`** (`lib/providers/favorites_provider.dart`) :
  la gestion des favoris (ajout/retrait/consultation) est désormais isolée
  de `RecipeProvider`, qui ne s'occupe plus que du catalogue de recettes
  (données, recherche, filtrage, ajout). `RecipeProvider` expose une
  nouvelle méthode `favoritesAmong(Set<String> ids)` pour croiser les deux
  sans les coupler.
- Tous les écrans et widgets concernés (`RecipeCard`, `FavoritesScreen`,
  `RecipeDetailScreen`, `main.dart`) ont été mis à jour en conséquence.

### Modèle
- Ajout de `Recipe.copyWith(...)` pour créer des variantes modifiées d'une
  recette sans rompre l'immuabilité du modèle.

### Tests — passage de 2 à 6 fichiers de test
- `recipe_provider_test.dart` — mis à jour (recherche, filtrage, ajout,
  `favoritesAmong`, sans plus mélanger la logique de favoris).
- `favorites_provider_test.dart` — nouveau, couvre le provider extrait.
- `recipe_model_test.dart` — nouveau, teste `copyWith` et `difficultyLabel`.
- `widgets_test.dart` — nouveau, **tests de widgets** (`testWidgets` +
  `pumpWidget`) sur `RatingStars` et `EmptyState` : on vérifie le rendu
  réel, pas seulement la logique sous-jacente.
- `search_filter_bar_test.dart` — nouveau, teste les interactions
  utilisateur (saisie de texte, tap sur un chip) via `tester.enterText` et
  `tester.tap`.
- `theme_provider_test.dart` — conservé de la v1.1.

### Intégration continue
- Ajout de `.github/workflows/flutter_ci.yml` : `flutter analyze` et
  `flutter test` s'exécutent automatiquement sur chaque push et pull
  request vers `main`.

## v1.1 — Corrections et améliorations

Corrections apportées après relecture, sans avoir pu compiler le projet
(pas d'environnement Flutter disponible) :

### Corrections de bugs probables
- **`DropdownButtonFormField`** : remplacement de `initialValue:` (qui n'existe
  pas sur ce widget) par `value:`, le paramètre correct. C'était une erreur
  de compilation quasi certaine dans `add_recipe_screen.dart`.

### Robustesse face aux versions de Flutter
- Suppression de toute dépendance à `colorScheme.surfaceVariant`, un champ
  renommé `surfaceContainerHighest` dans les versions récentes de Material 3.
  La logique d'image de repli est désormais centralisée dans un nouveau
  widget `RecipeImage`, qui calcule sa couleur de fond directement à partir
  de la luminosité du thème (`Theme.of(context).brightness`) plutôt que de
  dépendre d'un nom de champ instable.

### Nouveau widget réutilisable
- `lib/widgets/recipe_image.dart` — centralise l'affichage d'image réseau
  (chargement + repli en cas d'erreur), utilisé désormais par `RecipeCard`,
  `FavoritesScreen` et `RecipeDetailScreen`.

### UX du formulaire
- Ajout de `AutovalidateMode` : les erreurs de validation s'affichent en
  temps réel dès qu'une première tentative de soumission a échoué, au lieu
  de rester invisibles tant qu'on ne resoumettait pas.

### Accessibilité
- Ajout de `tooltip` explicites ("Ajouter aux favoris" / "Retirer des
  favoris") sur les boutons favoris de la carte de recette et de l'écran
  de détail, pour les lecteurs d'écran et les utilisateurs desktop.

### Tests
- Ajout de `test/theme_provider_test.dart` (3 tests) pour couvrir le
  deuxième provider de l'application, qui n'était pas testé auparavant.

## v1.0 — Version initiale

Première version complète : 5 écrans, navigation GoRouter, recherche/
filtrage, formulaire avec validation, thème clair/sombre, UI responsive,
5 widgets réutilisables.
