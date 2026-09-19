import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../utils/responsive.dart';
import '../widgets/empty_state.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_filter_bar.dart';

/// Écran de liste principal : recherche textuelle + filtrage par
/// catégorie, affichés dans une grille dont le nombre de colonnes
/// s'adapte à la largeur de l'écran (mobile / tablette / desktop).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  String _selectedCategory = 'Toutes';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeProvider>();
    final categories = ['Toutes', ...recipeProvider.categories];
    final results =
        recipeProvider.search(query: _query, category: _selectedCategory);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes Recettes')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Ajouter une recette',
        onPressed: () => context.pushNamed('ajouter'),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchFilterBar(
              controller: _controller,
              categories: categories,
              selectedCategory: _selectedCategory,
              onQueryChanged: (value) => setState(() => _query = value),
              onCategorySelected: (value) =>
                  setState(() => _selectedCategory = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: results.isEmpty
                  ? const EmptyState(
                      icon: Icons.search_off,
                      title: 'Aucune recette trouvée',
                      message:
                          'Essayez un autre mot-clé ou une autre catégorie.',
                    )
                  : GridView.builder(
                      itemCount: results.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.gridColumns(context),
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) =>
                          RecipeCard(recipe: results[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
