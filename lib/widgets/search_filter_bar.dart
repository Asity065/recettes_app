import 'package:flutter/material.dart';

/// Barre de recherche textuelle combinée à des filtres par catégorie
/// (sous forme de [ChoiceChip] défilables horizontalement).
///
/// Ce widget ne connaît ni les recettes ni le provider : il reçoit
/// uniquement des données et des callbacks, ce qui le rend réutilisable
/// dans n'importe quel écran de liste filtrable.
class SearchFilterBar extends StatelessWidget {
  final TextEditingController controller;
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onQueryChanged;

  const SearchFilterBar({
    super.key,
    required this.controller,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onQueryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: onQueryChanged,
          decoration: InputDecoration(
            hintText: 'Rechercher une recette...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      onQueryChanged('');
                    },
                  )
                : null,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category == selectedCategory;
              return ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (_) => onCategorySelected(category),
              );
            },
          ),
        ),
      ],
    );
  }
}
