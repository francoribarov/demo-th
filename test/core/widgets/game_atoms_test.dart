import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/core/widgets/atoms/atoms.dart';

void main() {
  testWidgets('GameRatingBadge renders rating and optional review count', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GameRatingBadge(
            rating: 4.5,
            reviewCount: 12,
          ),
        ),
      ),
    );

    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('(12)'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GameRatingBadge(rating: 3.8),
        ),
      ),
    );

    expect(find.text('3.8'), findsOneWidget);
    expect(find.text('(12)'), findsNothing);
  });

  testWidgets('GamePriceLabel renders defaults and custom copy', (
    tester,
  ) async {
    final defaultPrice = CurrencyFormatter.formatUYU(1200);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GamePriceLabel(price: 1200),
        ),
      ),
    );

    expect(find.text('Desde'), findsOneWidget);
    expect(find.text(defaultPrice), findsOneWidget);
    expect(find.text('/ día'), findsOneWidget);

    final customPrice = CurrencyFormatter.formatUYU(900);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GamePriceLabel(
            price: 900,
            leadingLabel: 'Precio',
            perUnit: '/ semana',
          ),
        ),
      ),
    );

    expect(find.text('Precio'), findsOneWidget);
    expect(find.text(customPrice), findsOneWidget);
    expect(find.text('/ semana'), findsOneWidget);
  });
}
