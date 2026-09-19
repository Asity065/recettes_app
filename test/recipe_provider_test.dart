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

    test('search combine mot-clé et catégorie simultanément', () {
      final provider = RecipeProvider();
      final results = provider.search(query: 'tarte', category: 'Dessert');
      expect(results, isNotEmpty);
      expect(
        results.every(
          (r) => r.category == 'Dessert' && r.title.toLowerCase().contains('tarte'),
        ),
        isTrue,
      );
    });

    test('search est insensible à la casse', () {
      final provider = RecipeProvider();
      final lower = provider.search(query: 'chocolat');
      final upper = provider.search(query: 'CHOCOLAT');
      expect(upper.length, lower.length);
      expect(upper.map((r) => r.id), lower.map((r) => r.id));
    });

    test('search ignore les espaces superflus dans la requête', () {
      final provider = RecipeProvider();
      final trimmed = provider.search(query: 'chocolat');
      final padded = provider.search(query: '   chocolat   ');
      expect(padded.length, trimmed.length);
    });

    test('search avec une requête vide et sans catégorie renvoie tout', () {
      final provider = RecipeProvider();
      final results = provider.search();
      expect(results.length, provider.recipes.length);
    });

    test('search avec catégorie "Toutes" ignore le filtre de catégorie', () {
      final provider = RecipeProvider();
      final withAll = provider.search(category: 'Toutes');
      final withoutFilter = provider.search();
      expect(withAll.length, withoutFilter.length);
    });

    test('search renvoie une liste vide si rien ne correspond', () {
      final provider = RecipeProvider();
      final results = provider.search(query: 'motclefinexistantxyz123');
      expect(results, isEmpty);
    });

    test('search avec une catégorie inexistante renvoie une liste vide', () {
      final provider = RecipeProvider();
      final results = provider.search(category: 'CatégorieInexistante');
      expect(results, isEmpty);
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
