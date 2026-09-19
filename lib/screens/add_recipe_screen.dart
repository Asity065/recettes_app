import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

/// Écran de formulaire permettant d'ajouter une nouvelle recette.
///
/// Contient 6 champs (titre, catégorie, temps de préparation,
/// difficulté, description, ingrédients), dont 3 sont obligatoires
/// et validés (titre, temps de préparation, description).
class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();

  String _category = 'Plat';
  Difficulty _difficulty = Difficulty.facile;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  static const List<String> _categories = [
    'Entrée',
    'Plat',
    'Dessert',
    'Petit-déjeuner',
    'Végétarien',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _prepTimeController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  void _submit() {
    // Dès qu'un premier submit échoue, on repasse en validation "live"
    // pour guider l'utilisateur champ par champ.
    setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);

    if (!_formKey.currentState!.validate()) return;

    final ingredients = _ingredientsController.text
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    final newId = DateTime.now().millisecondsSinceEpoch.toString();

    final newRecipe = Recipe(
      id: newId,
      title: _titleController.text.trim(),
      category: _category,
      description: _descriptionController.text.trim(),
      imageUrl: 'https://picsum.photos/seed/$newId/700/500',
      prepTimeMinutes: int.parse(_prepTimeController.text.trim()),
      difficulty: _difficulty,
      rating: 0,
      ingredients: ingredients.isEmpty ? ['À compléter'] : ingredients,
      steps: const ['À compléter'],
    );

    context.read<RecipeProvider>().addRecipe(newRecipe);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${newRecipe.title}" a été ajoutée !')),
    );

    Navigator.of(context).pop();
  }

  String _difficultyLabel(Difficulty d) {
    switch (d) {
      case Difficulty.facile:
        return 'Facile';
      case Difficulty.moyen:
        return 'Moyen';
      case Difficulty.difficile:
        return 'Difficile';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle recette')),
      body: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titre de la recette',
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.trim().length < 3) {
                  return 'Le titre doit contenir au moins 3 caractères.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'Catégorie',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: _categories
                  .map(
                    (category) =>
                        DropdownMenuItem(value: category, child: Text(category)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _category = value ?? _category),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _prepTimeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Temps de préparation (minutes)',
                prefixIcon: Icon(Icons.timer_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez indiquer un temps de préparation.';
                }
                final parsed = int.tryParse(value.trim());
                if (parsed == null || parsed <= 0) {
                  return 'Veuillez entrer un nombre de minutes valide.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Difficulty>(
              value: _difficulty,
              decoration: const InputDecoration(
                labelText: 'Difficulté',
                prefixIcon: Icon(Icons.speed),
              ),
              items: Difficulty.values
                  .map(
                    (d) => DropdownMenuItem(
                      value: d,
                      child: Text(_difficultyLabel(d)),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  setState(() => _difficulty = value ?? _difficulty),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().length < 10) {
                  return 'La description doit contenir au moins 10 caractères.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ingredientsController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Ingrédients (un par ligne, facultatif)',
                prefixIcon: Icon(Icons.shopping_basket_outlined),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Enregistrer la recette'),
            ),
          ],
        ),
      ),
    );
  }
}
