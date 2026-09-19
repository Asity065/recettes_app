import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/add_recipe_screen.dart';
import '../screens/main_screen.dart';
import '../screens/recipe_detail_screen.dart';

/// Configuration centralisée de la navigation avec GoRouter.
///
/// Toutes les routes sont nommées afin de naviguer via
/// `context.pushNamed('nom', pathParameters: {...})` plutôt qu'avec
/// des chaînes d'URL construites à la main dans les écrans.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'accueil',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/recette/:id',
      name: 'detail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return RecipeDetailScreen(recipeId: id);
      },
    ),
    GoRoute(
      path: '/ajouter',
      name: 'ajouter',
      builder: (context, state) => const AddRecipeScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Erreur')),
    body: Center(child: Text('Page introuvable : ${state.uri}')),
  ),
);
