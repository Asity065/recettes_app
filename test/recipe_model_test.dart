import 'package:flutter_test/flutter_test.dart';
import 'package:recettes_app/models/recipe.dart';

Recipe _sample({
  String id = 'r1',
  String title = 'Recette test',
  Difficulty difficulty = Difficulty.facile,
}) {
  return Recipe(
    id: id,
    title: title,
    category: 'Plat',
    description: 'Une description de test suffisamment longue.',
    imageUrl: 'https://example.com/image.jpg',
    prepTimeMinutes: 30,
    difficulty: difficulty,
    rating: 4.0,
    ingredients: const ['Ingrédient 1'],
    steps: const ['Étape 1'],
  );
}

void main() {
  group('Recipe', () {
    test('difficultyLabel renvoie le bon libellé pour chaque valeur', () {
      expect(_sample(difficulty: Difficulty.facile).difficultyLabel, 'Facile');
      expect(_sample(difficulty: Difficulty.moyen).difficultyLabel, 'Moyen');
      expect(_sample(difficulty: Difficulty.difficile).difficultyLabel, 'Difficile');
    });

    test('copyWith sans argument renvoie une recette identique', () {
      final original = _sample();
      final copy = original.copyWith();

      expect(copy.id, original.id);
      expect(copy.title, original.title);
      expect(copy.rating, original.rating);
    });

    test('copyWith ne modifie que les champs fournis', () {
      final original = _sample(title: 'Titre original');
      final copy = original.copyWith(title: 'Nouveau titre');

      expect(copy.title, 'Nouveau titre');
      expect(copy.id, original.id);
      expect(copy.category, original.category);
      // L'original n'est pas muté : le modèle reste immuable.
      expect(original.title, 'Titre original');
    });
  });
}
