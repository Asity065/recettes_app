import 'package:flutter/widgets.dart';

/// Centralise les règles de responsive design de l'application.
///
/// Utiliser cette classe partout où une décision dépend de la taille
/// d'écran évite de dupliquer des seuils "magiques" dans les widgets.
class Responsive {
  Responsive._();

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1000;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  /// Nombre de colonnes pour les grilles de recettes selon la largeur.
  static int gridColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= desktopBreakpoint) return 4;
    if (width >= tabletBreakpoint) return 3;
    return 2;
  }
}
