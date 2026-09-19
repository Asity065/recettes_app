/// Niveau de difficulté d'une recette.
enum Difficulty { facile, moyen, difficile }

/// Modèle de données représentant une recette de cuisine.
///
/// Ce modèle est volontairement immuable (tous les champs sont `final`) :
/// toute modification passe par la création d'une nouvelle instance,
/// ce qui évite les effets de bord dans les widgets qui l'affichent.
class Recipe {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageUrl;
  final int prepTimeMinutes;
  final Difficulty difficulty;
  final double rating;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.prepTimeMinutes,
    required this.difficulty,
    required this.rating,
    required this.ingredients,
    required this.steps,
  });

  /// Libellé lisible de la difficulté, utilisé dans l'UI.
  String get difficultyLabel {
    switch (difficulty) {
      case Difficulty.facile:
        return 'Facile';
      case Difficulty.moyen:
        return 'Moyen';
      case Difficulty.difficile:
        return 'Difficile';
    }
  }
}
