import 'package:flutter_test/flutter_test.dart';
import 'package:recettes_app/providers/favorites_provider.dart';

void main() {
  group('FavoritesProvider', () {
    test('aucun favori au démarrage', () {
      final provider = FavoritesProvider();
      expect(provider.favoriteIds, isEmpty);
      expect(provider.isFavorite('r1'), isFalse);
    });

    test('toggleFavorite ajoute puis retire un favori', () {
      final provider = FavoritesProvider();

      provider.toggleFavorite('r1');
      expect(provider.isFavorite('r1'), isTrue);
      expect(provider.favoriteIds, contains('r1'));

      provider.toggleFavorite('r1');
      expect(provider.isFavorite('r1'), isFalse);
      expect(provider.favoriteIds, isNot(contains('r1')));
    });

    test('toggleFavorite notifie les auditeurs à chaque changement', () {
      final provider = FavoritesProvider();
      var notifications = 0;
      provider.addListener(() => notifications++);

      provider.toggleFavorite('r1');
      provider.toggleFavorite('r2');
      provider.toggleFavorite('r1');

      expect(notifications, 3);
    });

    test('plusieurs favoris peuvent coexister', () {
      final provider = FavoritesProvider();
      provider.toggleFavorite('r1');
      provider.toggleFavorite('r2');

      expect(provider.favoriteIds, {'r1', 'r2'});
    });
  });
}
