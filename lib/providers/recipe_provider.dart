import 'package:flutter/foundation.dart';

import '../data/recipes_seed.dart';
import '../models/recipe.dart';

/// Source de vérité unique pour les recettes et les favoris.
///
/// Toutes les données affichées par l'UI passent par ce provider :
/// aucun widget ne contient de recette codée en dur.
class RecipeProvider extends ChangeNotifier {
  final List<Recipe> _recipes = List<Recipe>.from(seedRecipes);
  final Set<String> _favoriteIds = <String>{};

  /// Liste (non modifiable depuis l'extérieur) de toutes les recettes.
  List<Recipe> get recipes => List.unmodifiable(_recipes);

  /// Catégories disponibles, déduites dynamiquement des données.
  List<String> get categories {
    final unique = _recipes.map((r) => r.category).toSet().toList();
    unique.sort();
    return unique;
  }

  /// Recettes actuellement marquées comme favorites.
  List<Recipe> get favorites =>
      _recipes.where((r) => _favoriteIds.contains(r.id)).toList();

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }

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
