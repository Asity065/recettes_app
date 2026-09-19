import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recettes_app/widgets/empty_state.dart';
import 'package:recettes_app/widgets/rating_stars.dart';

void main() {
  group('RatingStars (widget)', () {
    testWidgets('affiche 5 icônes pour une note pleine', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: RatingStars(rating: 5))),
      );

      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.byIcon(Icons.star_border), findsNothing);
    });

    testWidgets('affiche une demi-étoile pour une note comme 3.5', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: RatingStars(rating: 3.5))),
      );

      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_half), findsOneWidget);
      expect(find.byIcon(Icons.star_border), findsOneWidget);
    });

    testWidgets('affiche des étoiles vides pour une note de 0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: RatingStars(rating: 0))),
      );

      expect(find.byIcon(Icons.star_border), findsNWidgets(5));
    });
  });

  group('EmptyState (widget)', () {
    testWidgets('affiche l\'icône, le titre et le message fournis', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.search_off,
              title: 'Titre de test',
              message: 'Message de test',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search_off), findsOneWidget);
      expect(find.text('Titre de test'), findsOneWidget);
      expect(find.text('Message de test'), findsOneWidget);
    });
  });
}
