import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../utils/responsive.dart';
import '../widgets/rating_stars.dart';
import '../widgets/recipe_image.dart';
import '../widgets/section_header.dart';

/// Écran de détail d'une recette.
///
/// L'identifiant [recipeId] est reçu via un paramètre de route GoRouter
/// (`/recette/:id`) : cet écran ne reçoit donc jamais l'objet [Recipe]
/// directement, ce qui illustre le passage de paramètres entre écrans.
class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final recipe = context.watch<RecipeProvider>().findById(recipeId);

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Recette introuvable.')),
      );
    }

    final isFavorite = context.watch<RecipeProvider>().isFavorite(recipe.id);
    final isTablet = Responsive.isTablet(context);

    final ingredientsCard = Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              icon: Icons.shopping_basket_outlined,
              title: 'Ingrédients',
            ),
            ...recipe.ingredients.map(
              (ingredient) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(ingredient)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final stepsCard = Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(icon: Icons.checklist, title: 'Préparation'),
            ...List.generate(recipe.steps.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(recipe.steps[index])),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );

    final descriptionAndMeta = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(
              avatar: const Icon(Icons.category_outlined, size: 16),
              label: Text(recipe.category),
            ),
            Chip(
              avatar: const Icon(Icons.timer_outlined, size: 16),
              label: Text('${recipe.prepTimeMinutes} min'),
            ),
            Chip(
              avatar: const Icon(Icons.speed, size: 16),
              label: Text(recipe.difficultyLabel),
            ),
          ],
        ),
        const SizedBox(height: 8),
        RatingStars(rating: recipe.rating, size: 20),
        const SizedBox(height: 16),
        const SectionHeader(icon: Icons.description_outlined, title: 'Description'),
        Text(recipe.description, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            actions: [
              IconButton(
                tooltip: isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () =>
                    context.read<RecipeProvider>().toggleFavorite(recipe.id),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'recipe-image-${recipe.id}',
                child: RecipeImage(imageUrl: recipe.imageUrl),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: isTablet
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4, child: descriptionAndMeta),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              ingredientsCard,
                              const SizedBox(height: 16),
                              stepsCard,
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        descriptionAndMeta,
                        const SizedBox(height: 16),
                        ingredientsCard,
                        const SizedBox(height: 16),
                        stepsCard,
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
