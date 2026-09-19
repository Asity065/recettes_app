# Changelog

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
  `FavoritesScreen` et `RecipeDetailScreen`. Porte le total de widgets
  réutilisables à **6** (contre 5 minimum requis étaient 3).

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
  Total : 8 tests unitaires sur 2 fichiers de test.

## v1.0 — Version initiale

Première version complète : 5 écrans, navigation GoRouter, recherche/
filtrage, formulaire avec validation, thème clair/sombre, UI responsive,
5 widgets réutilisables.
