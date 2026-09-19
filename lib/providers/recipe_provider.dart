import 'package:flutter/foundation.dart';

import '../data/recipes_seed.dart';
import '../models/recipe.dart';

/// Source de vérité unique pour le catalogue de recettes (recherche,
/// filtrage, ajout). La gestion des favoris est déléguée à
/// [FavoritesProvider] pour garder une responsabilité unique par provider.
class RecipeProvider extends ChangeNotifier {
  final List<Recipe> _recipes = List<Recipe>.from(seedRecipes);

  /// Liste (non modifiable depuis l'extérieur) de toutes les recettes.
  List<Recipe> get recipes => List.unmodifiable(_recipes);

  /// Catégories disponibles, déduites dynamiquement des données.
  List<String> get categories {
    final unique = _recipes.map((r) => r.category).toSet().toList();
    unique.sort();
    return unique;
  }

  /// Filtre le catalogue selon un ensemble d'identifiants favoris fourni
  /// par [FavoritesProvider]. Ce provider ne connaît pas lui-même l'état
  /// des favoris : on le lui passe explicitement.
  List<Recipe> favoritesAmong(Set<String> favoriteIds) =>
      _recipes.where((r) => favoriteIds.contains(r.id)).toList();

  /// Recherche + filtrage combinés, utilisés par l'écran d'accueil.
  List<Recipe> search({String query = '', String? category}) {
    final lowerQuery = query.trim().toLowerCase();
    return _recipes.where((r) {
      final matchesQuery = lowerQuery.isEmpty ||
          r.title.toLowerCase().contains(lowerQuery) ||
          r.description.toLowerCase().contains(lowerQuery);
      final matchesCategory =
          category == null || category == 'Toutes' || r.category == category;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  Recipe? findById(String id) {
    for (final recipe in _recipes) {
      if (recipe.id == id) return recipe;
    }
    return null;
  }

  /// Ajoute une nouvelle recette créée depuis le formulaire.
  void addRecipe(Recipe recipe) {
    _recipes.insert(0, recipe);
    notifyListeners();
  }
}
