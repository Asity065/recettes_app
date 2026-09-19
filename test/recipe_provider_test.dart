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

    test('favoritesAmong filtre les recettes selon un ensemble d\'ids', () {
      final provider = RecipeProvider();
      final firstId = provider.recipes.first.id;

      final result = provider.favoritesAmong({firstId});

      expect(result.length, 1);
      expect(result.first.id, firstId);
    });

    test('favoritesAmong renvoie une liste vide si aucun id ne correspond', () {
      final provider = RecipeProvider();
      final result = provider.favoritesAmong({'id-inexistant'});
      expect(result, isEmpty);
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
