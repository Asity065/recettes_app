import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../providers/recipe_provider.dart';
import 'rating_stars.dart';

/// Carte affichant l'aperçu d'une recette (image, catégorie, note,
/// temps de préparation) et permettant de basculer le favori ou
/// d'ouvrir l'écran de détail.
///
/// Ce widget reçoit une [Recipe] en paramètre : il n'accède jamais
/// directement aux données de démonstration.
class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<RecipeProvider>().isFavorite(recipe.id);

    return Card(
      child: InkWell(
        onTap: () =>
            context.pushNamed('detail', pathParameters: {'id': recipe.id}),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'recipe-image-${recipe.id}',
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stack) => Container(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: const Icon(Icons.restaurant, size: 40),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Material(
                      color: Colors.black45,
                      shape: const CircleBorder(),
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.redAccent : Colors.white,
                        ),
                        onPressed: () =>
                            context.read<RecipeProvider>().toggleFavorite(recipe.id),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: Chip(
                      label: Text(recipe.category, style: const TextStyle(fontSize: 11)),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Colors.black45,
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      RatingStars(rating: recipe.rating, size: 14),
                      const Spacer(),
                      const Icon(Icons.timer_outlined, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        '${recipe.prepTimeMinutes} min',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
