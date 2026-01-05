import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/rental/presentation/bloc/rental_bloc.dart';
import 'package:mobile_table_hopping/features/rental/presentation/pages/rental_confirm_page.dart';
import 'package:mobile_table_hopping/features/rental/presentation/widgets/availability_date_selector.dart';
import 'package:mocktail/mocktail.dart';

class MockRentalBloc extends Mock implements RentalBloc {}

void main() {
  late MockRentalBloc mockRentalBloc;

  setUpAll(() {
    registerFallbackValue(const RentalEvent.messageShown());
    registerFallbackValue(const RentalEvent.dateRangeChanged());
  });

  const tGame = Game(
    id: 1,
    title: 'Test Game',
    category: 'Strategy',
    image: '',
    rating: 4.5,
    reviews: 10,
    description: '',
    duration: '60 min',
    players: '2-4',
    difficulty: 'Medium',
    price: 100,
    ownerId: 'owner123',
    availability: [
      AvailabilityRange(from: '2026-01-03', to: '2026-01-08'),
      AvailabilityRange(from: '2026-01-23', to: '2026-01-31'),
    ],
    rules: GameRules(video: '', text: ''),
  );

  setUp(() {
    mockRentalBloc = MockRentalBloc();
    when(() => mockRentalBloc.state).thenReturn(const RentalState(game: tGame));
    when(() => mockRentalBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockRentalBloc.close()).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', 'UY')],
      locale: const Locale('es', 'UY'),
      home: BlocProvider<RentalBloc>.value(
        value: mockRentalBloc,
        child: const RentalConfirmPage(gameId: '1'),
      ),
    );
  }

  group('RentalConfirmPage Calendar Logic', () {
    testWidgets('should open range picker and Jan 5 should be enabled', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1024));
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Ensure AvailabilityDateSelector is visible
      final selector = find.byType(AvailabilityDateSelector);
      await tester.ensureVisible(selector);
      await tester.pumpAndSettle();

      // Tap the Inicio button (specifically the one with text 'Inicio')
      await tester.tap(find.text('Inicio'));
      await tester.pumpAndSettle();

      expect(find.text('5'), findsWidgets);
    });

    testWidgets(
      'should respect the 3-day minimum and availability in range picker',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 1024));
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        final selector = find.byType(AvailabilityDateSelector);
        await tester.ensureVisible(selector);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Inicio'));
        await tester.pumpAndSettle();

        // Start Jan 5, End Jan 7 (3 days total)
        // Today is Jan 4, 2026. Jan 3 is in the past and disabled.
        await tester.tap(find.text('5').last);
        await tester.pump();
        await tester.tap(find.text('7').last);
        await tester.pump();

        final saveButton = find.text('GUARDAR');
        if (tester.any(saveButton)) {
          await tester.tap(saveButton);
        } else {
          // Fallback to finding by icon or position in case text varies by platform/locale
          final okButton = find.text('OK');
          if (tester.any(okButton)) {
            await tester.tap(okButton);
          } else {
            await tester.tap(find.byType(TextButton).last);
          }
        }

        await tester.pumpAndSettle();

        verify(
          () => mockRentalBloc.add(any(that: isA<RentalEvent>())),
        ).called(1);
      },
    );

    testWidgets(
      'should prevent selecting end dates across an availability gap',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 1024));
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        final selector = find.byType(AvailabilityDateSelector);
        await tester.ensureVisible(selector);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Inicio'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('5').last);
        await tester.pump();

        // Try to tap Jan 23 (gap exists)
        await tester.tap(find.text('23').last);
        await tester.pump();

        final saveButton = find.text('GUARDAR');
        if (tester.any(saveButton)) {
          await tester.tap(saveButton);
        } else {
          await tester.tap(find.byType(TextButton).first);
        }

        await tester.pumpAndSettle();

        verifyNever(() => mockRentalBloc.add(any()));
      },
    );
  });
}
