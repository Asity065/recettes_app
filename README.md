# 🍳 Mes Recettes — App Flutter multi-écrans

Application Flutter de démonstration sur le thème des **recettes de cuisine**,
construite pour valider la maîtrise des widgets Flutter et de la navigation
multi-écrans.

## 📱 Aperçu des écrans

| Écran | Description |
|---|---|
| **Accueil** | Grille de recettes avec barre de recherche + filtres par catégorie (chips), responsive (2/3/4 colonnes) |
| **Détail recette** | Image en en-tête (Hero + SliverAppBar), ingrédients, étapes, favoris — reçoit l'id de la recette en paramètre de route |
| **Favoris** | Liste des recettes marquées comme favorites |
| **Réglages** | Choix du thème clair / sombre / système |
| **Ajouter une recette** | Formulaire avec validation (titre, catégorie, temps de préparation, difficulté, description, ingrédients) |

*(Ajoutez ici vos captures d'écran une fois l'app lancée, par exemple dans
un dossier `screenshots/` : `screenshots/accueil.png`,
`screenshots/detail.png`, `screenshots/formulaire.png`,
`screenshots/theme_sombre.png`.)*

```markdown
![Accueil](screenshots/accueil.png)
![Détail](screenshots/detail.png)
![Formulaire](screenshots/formulaire.png)
![Thème sombre](screenshots/theme_sombre.png)
```

## ✅ Fonctionnalités

- **5 écrans distincts** (dépasse le minimum de 4) : Accueil, Détail, Favoris,
  Réglages, Formulaire d'ajout.
- **Navigation avec GoRouter**, routes nommées (`accueil`, `detail`,
  `ajouter`) et passage de paramètre dynamique (`/recette/:id`).
- **Écran de liste avec recherche + filtrage** par catégorie (chips).
- **Écran de détail avec passage de paramètres** (id de recette dans l'URL,
  résolu via le `RecipeProvider`).
- **Formulaire avec validation** : 6 champs, dont 3 obligatoires et validés
  (titre ≥ 3 caractères, temps de préparation numérique > 0, description
  ≥ 10 caractères).
- **Thème clair / sombre / système**, géré via un `ThemeProvider` et
  persistant pendant la session (écran Réglages).
- **UI responsive** : la grille de recettes passe de 2 à 3 puis 4 colonnes
  selon la largeur d'écran (`lib/utils/responsive.dart`), et l'écran de
  détail bascule en layout deux colonnes sur tablette.
- **Aucune donnée en dur dans les widgets** : toutes les recettes viennent de
  `lib/data/recipes_seed.dart`, exposées uniquement via `RecipeProvider`.

## 🧱 Widgets utilisés (plus de 8 types différents)

`GridView`, `ListView`, `Stack`, `Card`, `Chip` / `ChoiceChip`,
`TextFormField`, `DropdownButtonFormField`, `Form`, `CustomScrollView` /
`SliverAppBar` / `SliverToBoxAdapter`, `Hero`, `FlexibleSpaceBar`,
`NavigationBar`, `RadioListTile`, `FloatingActionButton`, `CircleAvatar`,
`Wrap`, `InkWell`, `IndexedStack`, `Image.network`.

## 🧩 Widgets réutilisables (`lib/widgets/`)

- `RecipeCard` — carte de recette utilisée dans la grille d'accueil.
- `SearchFilterBar` — barre de recherche + filtres par catégorie.
- `RatingStars` — étoiles de notation (accueil, favoris, détail).
- `SectionHeader` — en-tête de section avec icône (détail, réglages).
- `EmptyState` — état vide générique (aucun résultat / aucun favori).

## 🗂️ Architecture du projet

```
lib/
├── main.dart                     # Point d'entrée, providers, MaterialApp.router
├── models/
│   └── recipe.dart                # Modèle de données Recipe + enum Difficulty
├── data/
│   └── recipes_seed.dart          # Jeu de données initial (aucune donnée dans l'UI)
├── providers/
│   ├── recipe_provider.dart       # État recettes/favoris + recherche/filtrage
│   └── theme_provider.dart        # État du thème clair/sombre/système
├── router/
│   └── app_router.dart            # Configuration GoRouter (routes nommées)
├── theme/
│   └── app_theme.dart             # ThemeData clair et sombre (Material 3)
├── utils/
│   └── responsive.dart            # Breakpoints et helpers responsive
├── screens/
│   ├── main_screen.dart           # Coquille avec NavigationBar (Accueil/Favoris/Réglages)
│   ├── home_screen.dart           # Liste + recherche + filtres
│   ├── recipe_detail_screen.dart  # Détail (paramètre d'URL)
│   ├── favorites_screen.dart      # Liste des favoris
│   ├── settings_screen.dart       # Choix du thème
│   └── add_recipe_screen.dart     # Formulaire avec validation
└── widgets/
    ├── recipe_card.dart
    ├── search_filter_bar.dart
    ├── rating_stars.dart
    ├── section_header.dart
    └── empty_state.dart
test/
└── recipe_provider_test.dart      # Tests unitaires sur la logique métier
```

## 🛠️ Stack technique

- **Flutter** (Material 3)
- [`go_router`](https://pub.dev/packages/go_router) — navigation déclarative, routes nommées
- [`provider`](https://pub.dev/packages/provider) — gestion d'état (recettes, favoris, thème)
- Images de démonstration via [picsum.photos](https://picsum.photos) (nécessite une connexion internet à l'exécution)

## 🚀 Installation et lancement

### Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installé (canal stable recommandé)
- Un émulateur/simulateur, un appareil physique, ou un navigateur pour Flutter Web

### Étapes

```bash
# 1. Cloner le repo
git clone https://github.com/<votre-utilisateur>/recettes_app.git
cd recettes_app

# 2. Installer les dépendances
flutter pub get

# 3. Lancer l'application (choisissez une cible)
flutter run                # sur l'appareil/émulateur connecté par défaut
flutter run -d chrome      # sur navigateur (Flutter Web)
flutter devices            # pour lister les cibles disponibles

# 4. Lancer les tests unitaires
flutter test
```

### Générer un build

```bash
flutter build apk --release      # Android
flutter build ios --release      # iOS (nécessite macOS + Xcode)
flutter build web --release      # Web
```

## 📤 Publier ce projet sur GitHub

Ce dépôt n'a pas encore de remote GitHub configuré. Pour le publier :

```bash
cd recettes_app
git init
git add .
git commit -m "Initial commit — app Flutter multi-écrans de recettes"
git branch -M main
git remote add origin https://github.com/<votre-utilisateur>/recettes_app.git
git push -u origin main
```

Pensez ensuite à :
1. Rendre le repo **public** dans les réglages GitHub.
2. Ajouter vos **captures d'écran** dans `screenshots/` et les lier dans ce README.
3. Vérifier que `flutter pub get` puis `flutter run` fonctionnent bien depuis un clone propre.

## 🩹 Dépannage

- **Erreur `initialValue` inconnu sur `DropdownButtonFormField`** : certaines
  anciennes versions de Flutter utilisent `value:` au lieu de `initialValue:`.
  Si votre SDK est plus ancien que Flutter 3.24, remplacez `initialValue:` par
  `value:` dans `lib/screens/add_recipe_screen.dart`.
- **Erreur sur `colorScheme.surfaceVariant`** : ce champ a été renommé
  `surfaceContainerHighest` dans les versions très récentes de Flutter. En cas
  d'erreur, remplacez `surfaceVariant` par `surfaceContainerHighest` dans
  `recipe_card.dart` et `favorites_screen.dart`.
- **Images qui ne s'affichent pas** : les images de démonstration viennent de
  `picsum.photos` et nécessitent une connexion internet sur l'appareil/émulateur ;
  en cas d'absence de réseau, un `Icon(Icons.restaurant)` de repli s'affiche
  automatiquement (`errorBuilder`).
- **Version de `go_router` / `provider`** : si `flutter pub get` échoue sur les
  contraintes de version, ajustez les bornes `^` dans `pubspec.yaml` selon la
  version de votre SDK Flutter.

## 📄 Licence

MIT — voir le fichier [`LICENSE`](LICENSE).
