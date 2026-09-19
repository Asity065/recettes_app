import 'package:flutter/material.dart';

/// Définit les thèmes clair et sombre de l'application à partir
/// d'une couleur de base (seed color), pour rester cohérent avec
/// Material 3 tout en gardant une identité visuelle propre.
class AppTheme {
  AppTheme._();

  static const Color _seedColor = Color(0xFFE85D2F);

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: _seedColor,
    );
    return _applyCommon(base);
  }

  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: _seedColor,
    );
    return _applyCommon(base);
  }

  static ThemeData _applyCommon(ThemeData base) {
    return base.copyWith(
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
      navigationBarTheme: const NavigationBarThemeData(elevation: 4),
    );
  }
}
