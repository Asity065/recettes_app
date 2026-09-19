import 'package:flutter/material.dart';

/// Affiche l'image d'une recette avec un état de chargement et un
/// repli propre en cas d'échec (pas de connexion, URL invalide, etc.).
///
/// Centraliser ce comportement ici évite de dupliquer la logique de
/// repli dans [RecipeCard], [FavoritesScreen] et [RecipeDetailScreen],
/// et évite de dépendre d'un champ de `ColorScheme` (ex. `surfaceVariant`)
/// dont le nom a changé selon les versions de Flutter : on calcule ici
/// une couleur neutre directement à partir de la luminosité du thème.
class RecipeImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const RecipeImage({super.key, required this.imageUrl, this.fit = BoxFit.cover});

  Color _placeholderColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.grey.shade800 : Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: _placeholderColor(context),
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
      errorBuilder: (context, error, stack) => Container(
        color: _placeholderColor(context),
        alignment: Alignment.center,
        child: Icon(
          Icons.restaurant,
          size: 40,
          color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
        ),
      ),
    );
  }
}
