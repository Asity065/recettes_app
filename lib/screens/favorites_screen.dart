import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/rating_stars.dart';
import '../widgets/recipe_image.dart';

/// Écran listant les recettes marquées comme favorites.
///
/// Utilise volontairement une [ListView] (plutôt qu'une grille) pour
/// varier les types de widgets utilisés dans l'application.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<RecipeProvider>().favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Mes favoris')),
      body: favorites.isEmpty
          ? const EmptyState(
              icon: Icons.favorite_border,
              title: 'Aucun favori pour le moment',
              message:
                  'Ajoutez des recettes à vos favoris depuis la liste ou '
                  'une fiche recette.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final recipe = favorites[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: RecipeImage(imageUrl: recipe.imageUrl),
                      ),
                    ),
                    title: Text(
                      recipe.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: RatingStars(rating: recipe.rating, size: 14),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.redAccent),
                      onPressed: () =>
                          context.read<RecipeProvider>().toggleFavorite(recipe.id),
                    ),
                    onTap: () => context
                        .pushNamed('detail', pathParameters: {'id': recipe.id}),
                  ),
                );
              },
            ),
    );
  }
}
