import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aroma_app/app.dart';
import 'package:aroma_app/components/aroma/aroma_components.dart';
import 'package:aroma_app/data/shop.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
    Shop.cartCount.value = 0;
    Shop.favourites.value = {};
  });

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const App());
  }

  testWidgets('Category chips filter the grid', (tester) async {
    await pumpApp(tester);

    expect(find.text('Velvet Dreams'), findsOneWidget);
    await tester.tap(find.text("Men's"));
    await tester.pumpAndSettle();
    expect(find.text('Velvet Dreams'), findsNothing);
    expect(find.text('Ocean Breeze'), findsWidgets);
  });

  testWidgets('Search filters by name', (tester) async {
    await pumpApp(tester);

    await tester.enterText(find.byType(TextField), 'velvet');
    await tester.pump();
    expect(find.byType(ProductCard), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(ProductCard),
        matching: find.text('Velvet Dreams'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Plus button adds to the cart', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.bySemanticsLabel('Add Velvet Dreams to cart'));
    await tester.pump();
    expect(Shop.cartCount.value, 1);
    expect(find.text('Velvet Dreams added to cart'), findsOneWidget);
  });

  testWidgets('Card opens details, size changes price, buy adds quantity', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.text('Aromatic Allure').first);
    await tester.pumpAndSettle();
    expect(find.text('Details'), findsOneWidget);
    expect(find.text('\$328'), findsOneWidget);

    await tester.tap(find.text('150 ml'));
    await tester.pump();
    expect(find.text('\$443'), findsOneWidget);

    await tester.tap(find.byTooltip('More'));
    await tester.tap(find.text('Buy Product'));
    await tester.pump();
    expect(Shop.cartCount.value, 2);

    await tester.tap(find.byTooltip('Favourite'));
    await tester.pump();
    expect(Shop.isFavourite('aromatic-allure'), isTrue);
  });
}
