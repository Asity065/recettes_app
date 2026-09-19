import 'package:flutter/foundation.dart';

/// Gère uniquement l'état des favoris (un ensemble d'identifiants de
/// recettes), indépendamment des données des recettes elles-mêmes.
///
/// Séparer ce provider de [RecipeProvider] évite qu'un seul provider ne
/// mélange deux responsabilités (les données du catalogue et les
/// préférences de l'utilisateur), ce qui facilite l'évolution de chacune
/// indépendamment (ex. persister les favoris plus tard sans toucher au
/// chargement des recettes).
class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = <String>{};

  /// Identifiants des recettes actuellement en favoris.
  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }
}
