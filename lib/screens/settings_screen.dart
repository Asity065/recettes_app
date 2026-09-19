import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/section_header.dart';

/// Écran de réglages permettant de choisir le thème de l'application
/// (clair, sombre ou suivant le système) et affichant des informations
/// générales sur l'application.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Réglages')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(icon: Icons.brightness_6, title: 'Apparence'),
          Card(
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: const Text('Clair'),
                  secondary: const Icon(Icons.light_mode),
                  value: ThemeMode.light,
                  groupValue: themeProvider.mode,
                  onChanged: (mode) => themeProvider.setMode(mode!),
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Sombre'),
                  secondary: const Icon(Icons.dark_mode),
                  value: ThemeMode.dark,
                  groupValue: themeProvider.mode,
                  onChanged: (mode) => themeProvider.setMode(mode!),
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Système'),
                  secondary: const Icon(Icons.settings_suggest),
                  value: ThemeMode.system,
                  groupValue: themeProvider.mode,
                  onChanged: (mode) => themeProvider.setMode(mode!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(icon: Icons.info_outline, title: 'À propos'),
          const Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.restaurant_menu)),
              title: Text('Mes Recettes'),
              subtitle: Text(
                'Application de démonstration Flutter — navigation, '
                'recherche, formulaire et thèmes clair/sombre.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
