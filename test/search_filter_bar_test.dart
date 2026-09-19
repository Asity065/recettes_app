import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recettes_app/widgets/search_filter_bar.dart';

void main() {
  group('SearchFilterBar (widget)', () {
    testWidgets('saisir du texte déclenche onQueryChanged', (tester) async {
      String? received;
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchFilterBar(
              controller: controller,
              categories: const ['Toutes', 'Dessert'],
              selectedCategory: 'Toutes',
              onCategorySelected: (_) {},
              onQueryChanged: (value) => received = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'chocolat');
      expect(received, 'chocolat');
    });

    testWidgets('taper sur un chip déclenche onCategorySelected', (tester) async {
      String? selected;
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchFilterBar(
              controller: controller,
              categories: const ['Toutes', 'Dessert'],
              selectedCategory: 'Toutes',
              onCategorySelected: (value) => selected = value,
              onQueryChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.text('Dessert'));
      await tester.pump();

      expect(selected, 'Dessert');
    });
  });
}
