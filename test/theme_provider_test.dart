import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recettes_app/providers/theme_provider.dart';

void main() {
  group('ThemeProvider', () {
    test('démarre en mode système par défaut', () {
      final provider = ThemeProvider();
      expect(provider.mode, ThemeMode.system);
      expect(provider.isDark, isFalse);
    });

    test('setMode met à jour le mode et notifie les auditeurs', () {
      final provider = ThemeProvider();
      var notified = false;
      provider.addListener(() => notified = true);

      provider.setMode(ThemeMode.dark);

      expect(provider.mode, ThemeMode.dark);
      expect(provider.isDark, isTrue);
      expect(notified, isTrue);
    });

    test('setMode avec la même valeur ne notifie pas inutilement', () {
      final provider = ThemeProvider();
      provider.setMode(ThemeMode.light);

      var notified = false;
      provider.addListener(() => notified = true);
      provider.setMode(ThemeMode.light);

      expect(notified, isFalse);
    });
  });
}
