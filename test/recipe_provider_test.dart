import 'package:flutter_test/flutter_test.dart';
import 'package:recettes_app/providers/recipe_provider.dart';

void main() {
  group('RecipeProvider', () {
    test('contient des recettes au démarrage', () {
      final provider = RecipeProvider();
      expect(provider.recipes, isNotEmpty);
    });

    test('search filtre par mot-clé', () {
      final provider = RecipeProvider();
      final results = provider.search(query: 'chocolat');
      expect(results, isNotEmpty);
      expect(
        results.every(
          (r) =>
              r.title.toLowerCase().contains('chocolat') ||
              r.description.toLowerCase().contains('chocolat'),
        ),
        isTrue,
      );
    });

    test('search filtre par catégorie', () {
      final provider = RecipeProvider();
      final results = provider.search(category: 'Dessert');
      expect(results, isNotEmpty);
      expect(results.every((r) => r.category == 'Dessert'), isTrue);
    });

    test('toggleFavorite ajoute puis retire un favori', () {
      final provider = RecipeProvider();
      final id = provider.recipes.first.id;

      expect(provider.isFavorite(id), isFalse);

      provider.toggleFavorite(id);
      expect(provider.isFavorite(id), isTrue);
      expect(provider.favorites.any((r) => r.id == id), isTrue);

      provider.toggleFavorite(id);
      expect(provider.isFavorite(id), isFalse);
    });

    test('addRecipe insère une nouvelle recette en tête de liste', () {
      final provider = RecipeProvider();
      final countBefore = provider.recipes.length;

      provider.addRecipe(
        provider.recipes.first,
      );

      expect(provider.recipes.length, countBefore + 1);
    });
  });
}
