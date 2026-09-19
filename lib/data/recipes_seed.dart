import '../models/recipe.dart';

/// Jeu de données initial de l'application.
///
/// Cette liste simule une source de données (API ou base locale).
/// Aucun widget n'accède directement à ce fichier : tout passe par
/// [RecipeProvider], ce qui garde l'UI totalement découplée des données.
final List<Recipe> seedRecipes = [
  Recipe(
    id: 'r1',
    title: 'Salade César maison',
    category: 'Entrée',
    description:
        'Une salade fraîche et croquante avec du poulet grillé, des croûtons '
        'dorés maison et une sauce césar onctueuse préparée minute.',
    imageUrl: 'https://picsum.photos/seed/r1/700/500',
    prepTimeMinutes: 20,
    difficulty: Difficulty.facile,
    rating: 4.3,
    ingredients: [
      '1 laitue romaine',
      '2 filets de poulet grillés',
      'Une poignée de croûtons',
      '50 g de parmesan',
      '4 c. à soupe de sauce césar',
    ],
    steps: [
      'Laver et essorer la laitue romaine, puis la couper en morceaux.',
      'Griller le poulet à la poêle puis le couper en lamelles.',
      'Répartir la laitue dans les assiettes et ajouter le poulet.',
      'Parsemer de croûtons et de copeaux de parmesan.',
      'Napper de sauce césar juste avant de servir.',
    ],
  ),
  Recipe(
    id: 'r2',
    title: 'Bœuf bourguignon traditionnel',
    category: 'Plat',
    description:
        'Un grand classique de la cuisine française : du bœuf mijoté '
        'longuement dans du vin rouge avec carottes, lardons et champignons.',
    imageUrl: 'https://picsum.photos/seed/r2/700/500',
    prepTimeMinutes: 180,
    difficulty: Difficulty.moyen,
    rating: 4.8,
    ingredients: [
      '1 kg de bœuf à braiser',
      '75 cl de vin rouge',
      '200 g de lardons',
      '3 carottes',
      '250 g de champignons de Paris',
      '2 oignons',
      'Bouquet garni',
    ],
    steps: [
      'Faire mariner la viande coupée en cubes dans le vin rouge une nuit.',
      'Faire revenir les lardons puis dorer la viande égouttée.',
      'Ajouter les oignons, carottes et le bouquet garni.',
      'Mouiller avec le vin de la marinade et laisser mijoter 3 heures.',
      'Ajouter les champignons 30 minutes avant la fin de la cuisson.',
    ],
  ),
  Recipe(
    id: 'r3',
    title: 'Tarte au citron meringuée',
    category: 'Dessert',
    description:
        'Une pâte sablée croustillante, une crème au citron acidulée et '
        'une meringue légère dorée au chalumeau.',
    imageUrl: 'https://picsum.photos/seed/r3/700/500',
    prepTimeMinutes: 90,
    difficulty: Difficulty.difficile,
    rating: 4.6,
    ingredients: [
      '1 pâte sablée',
      '3 citrons',
      '4 œufs',
      '150 g de sucre',
      '80 g de beurre',
      '2 blancs d\'œufs pour la meringue',
    ],
    steps: [
      'Cuire la pâte sablée à blanc pendant 15 minutes.',
      'Préparer la crème au citron avec le jus, le zeste, les œufs et le sucre.',
      'Faire épaissir la crème à feu doux puis incorporer le beurre.',
      'Garnir le fond de tarte refroidi avec la crème au citron.',
      'Monter les blancs en neige, garnir la tarte et dorer au chalumeau.',
    ],
  ),
  Recipe(
    id: 'r4',
    title: 'Pancakes moelleux',
    category: 'Petit-déjeuner',
    description:
        'Des pancakes américains bien épais et moelleux, parfaits avec du '
        'sirop d\'érable et des fruits frais.',
    imageUrl: 'https://picsum.photos/seed/r4/700/500',
    prepTimeMinutes: 25,
    difficulty: Difficulty.facile,
    rating: 4.5,
    ingredients: [
      '250 g de farine',
      '2 œufs',
      '30 cl de lait',
      '2 c. à soupe de sucre',
      '1 sachet de levure chimique',
      '30 g de beurre fondu',
    ],
    steps: [
      'Mélanger les ingrédients secs dans un grand bol.',
      'Ajouter les œufs, le lait et le beurre fondu, puis fouetter.',
      'Laisser reposer la pâte 10 minutes.',
      'Cuire des petites louches de pâte à la poêle beurrée, 2 minutes par face.',
    ],
  ),
  Recipe(
    id: 'r5',
    title: 'Curry de légumes au lait de coco',
    category: 'Végétarien',
    description:
        'Un curry doux et parfumé aux légumes de saison, mijoté dans un '
        'lait de coco onctueux avec des épices douces.',
    imageUrl: 'https://picsum.photos/seed/r5/700/500',
    prepTimeMinutes: 40,
    difficulty: Difficulty.facile,
    rating: 4.4,
    ingredients: [
      '400 ml de lait de coco',
      '2 patates douces',
      '1 courgette',
      '200 g de pois chiches',
      '2 c. à soupe de pâte de curry',
      'Coriandre fraîche',
    ],
    steps: [
      'Faire revenir la pâte de curry dans un peu d\'huile.',
      'Ajouter les légumes coupés en dés et mélanger.',
      'Verser le lait de coco et laisser mijoter 25 minutes.',
      'Ajouter les pois chiches et parsemer de coriandre avant de servir.',
    ],
  ),
  Recipe(
    id: 'r6',
    title: 'Risotto aux champignons',
    category: 'Plat',
    description:
        'Un risotto crémeux à souhait, préparé lentement avec un bouillon '
        'parfumé et des champignons poêlés au beurre.',
    imageUrl: 'https://picsum.photos/seed/r6/700/500',
    prepTimeMinutes: 45,
    difficulty: Difficulty.moyen,
    rating: 4.5,
    ingredients: [
      '320 g de riz arborio',
      '400 g de champignons mélangés',
      '1 l de bouillon de légumes',
      '1 oignon',
      '80 g de parmesan',
      '10 cl de vin blanc',
    ],
    steps: [
      'Faire revenir l\'oignon puis nacrer le riz.',
      'Déglacer au vin blanc et laisser réduire.',
      'Ajouter le bouillon chaud louche par louche en remuant.',
      'Poêler les champignons séparément puis les incorporer en fin de cuisson.',
      'Terminer avec le parmesan hors du feu.',
    ],
  ),
  Recipe(
    id: 'r7',
    title: 'Houmous et légumes croquants',
    category: 'Entrée',
    description:
        'Un houmous maison crémeux au tahini, servi avec des bâtonnets de '
        'légumes frais et croquants.',
    imageUrl: 'https://picsum.photos/seed/r7/700/500',
    prepTimeMinutes: 15,
    difficulty: Difficulty.facile,
    rating: 4.1,
    ingredients: [
      '400 g de pois chiches cuits',
      '2 c. à soupe de tahini',
      '1 citron',
      '1 gousse d\'ail',
      'Huile d\'olive',
      'Carottes et concombre',
    ],
    steps: [
      'Mixer les pois chiches avec le tahini, le jus de citron et l\'ail.',
      'Ajouter de l\'huile d\'olive jusqu\'à obtenir une texture lisse.',
      'Rectifier l\'assaisonnement puis réserver au frais.',
      'Servir avec des bâtonnets de légumes frais.',
    ],
  ),
  Recipe(
    id: 'r8',
    title: 'Mousse au chocolat noir',
    category: 'Dessert',
    description:
        'Une mousse au chocolat aérienne et intense, avec seulement trois '
        'ingrédients et beaucoup de patience.',
    imageUrl: 'https://picsum.photos/seed/r8/700/500',
    prepTimeMinutes: 30,
    difficulty: Difficulty.moyen,
    rating: 4.7,
    ingredients: [
      '200 g de chocolat noir',
      '6 œufs',
      '1 pincée de sel',
    ],
    steps: [
      'Faire fondre le chocolat au bain-marie.',
      'Séparer les blancs des jaunes d\'œufs.',
      'Incorporer les jaunes au chocolat tiédi.',
      'Monter les blancs en neige avec le sel puis les incorporer délicatement.',
      'Réfrigérer au moins 4 heures avant de servir.',
    ],
  ),
  Recipe(
    id: 'r9',
    title: 'Granola maison aux fruits secs',
    category: 'Petit-déjeuner',
    description:
        'Un granola croustillant au miel, avoine et fruits secs, à '
        'conserver dans un bocal pour toute la semaine.',
    imageUrl: 'https://picsum.photos/seed/r9/700/500',
    prepTimeMinutes: 35,
    difficulty: Difficulty.facile,
    rating: 4.2,
    ingredients: [
      '300 g de flocons d\'avoine',
      '80 g de miel',
      '60 ml d\'huile de coco',
      '100 g de fruits secs mélangés',
      '50 g d\'amandes effilées',
    ],
    steps: [
      'Préchauffer le four à 160°C.',
      'Mélanger les flocons d\'avoine, le miel et l\'huile de coco.',
      'Étaler sur une plaque et enfourner 20 minutes en remuant à mi-cuisson.',
      'Ajouter les fruits secs et laisser refroidir avant de conserver au sec.',
    ],
  ),
  Recipe(
    id: 'r10',
    title: 'Buddha bowl quinoa et légumes rôtis',
    category: 'Végétarien',
    description:
        'Un bol coloré et équilibré à base de quinoa, légumes rôtis au '
        'four et sauce tahini citronnée.',
    imageUrl: 'https://picsum.photos/seed/r10/700/500',
    prepTimeMinutes: 35,
    difficulty: Difficulty.facile,
    rating: 4.4,
    ingredients: [
      '150 g de quinoa',
      '1 patate douce',
      '1 brocoli',
      '2 c. à soupe de tahini',
      '1 citron',
      'Graines de sésame',
    ],
    steps: [
      'Cuire le quinoa selon les instructions du paquet.',
      'Rôtir la patate douce et le brocoli au four 25 minutes.',
      'Préparer la sauce en mélangeant tahini, jus de citron et eau.',
      'Dresser le bol avec le quinoa, les légumes rôtis et la sauce.',
    ],
  ),
];
