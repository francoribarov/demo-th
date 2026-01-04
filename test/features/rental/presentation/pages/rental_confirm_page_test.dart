import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/rental/presentation/bloc/rental_bloc.dart';
import 'package:mobile_table_hopping/features/rental/presentation/pages/rental_confirm_page.dart';
import 'package:mocktail/mocktail.dart';

class MockRentalBloc extends Mock implements RentalBloc {}

class FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _FakeHttpClient();
}

class _FakeHttpClient extends Mock implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _FakeHttpClientRequest();

  @override
  bool get autoUncompress => true;

  @override
  set autoUncompress(bool value) {}
}

class _FakeHttpClientRequest extends Mock implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse();
}

class _MockHttpClientResponse extends Mock implements HttpClientResponse {
  @override
  int get statusCode => 200;
  @override
  int get contentLength => 0;
  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;
  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

void main() {
  late MockRentalBloc mockRentalBloc;

  setUpAll(() {
    HttpOverrides.global = FakeHttpOverrides();
    registerFallbackValue(const RentalEvent.messageShown());
  });

  const tGame = Game(
    id: 1,
    title: 'Test Game',
    category: 'Strategy',
    image: 'https://example.com/pixel.png',
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
      supportedLocales: const [Locale('es', 'UY'), Locale('en', 'US')],
      locale: const Locale('es', 'UY'),
      home: BlocProvider<RentalBloc>.value(
        value: mockRentalBloc,
        child: const RentalConfirmPage(gameId: '1'),
      ),
    );
  }

  group('RentalConfirmPage Calendar Logic', () {
    testWidgets('should open range picker and Jan 3 should be enabled', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(1200, 1000));
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Inicio'));
      await tester.pumpAndSettle();

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets(
      'should respect the 3-day minimum and availability in range picker',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 1000));
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.tap(find.text('Inicio'));
        await tester.pumpAndSettle();

        // Start Jan 3, End Jan 5
        await tester.tap(find.text('3'));
        await tester.pump();
        await tester.tap(find.text('5'));
        await tester.pump();

        // Find save button by text in Spanish or English
        final saveButton = find.text('GUARDAR');
        final saveButtonEn = find.text('SAVE');

        if (tester.any(saveButton)) {
          await tester.tap(saveButton);
        } else if (tester.any(saveButtonEn)) {
          await tester.tap(saveButtonEn);
        } else {
          // Fallback to the text button in the top right of the picker
          await tester.tap(find.byType(TextButton).at(0));
        }

        await tester.pumpAndSettle();

        verify(() => mockRentalBloc.add(any())).called(1);
      },
    );

    testWidgets(
      'should prevent selecting end dates across an availability gap',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 1000));
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.tap(find.text('Inicio'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('3'));
        await tester.pump();

        // Try to tap Jan 23 (gap exists)
        await tester.tap(find.text('23'));
        await tester.pump();

        final saveButton = find.text('GUARDAR');
        final saveButtonEn = find.text('SAVE');

        if (tester.any(saveButton)) {
          await tester.tap(saveButton);
        } else if (tester.any(saveButtonEn)) {
          await tester.tap(saveButtonEn);
        } else {
          await tester.tap(find.byType(TextButton).at(0));
        }

        await tester.pumpAndSettle();

        // Verify that NO event was triggered with Jan 23
        final captured = verify(
          () => mockRentalBloc.add(captureAny()),
        ).captured;
        for (final event in captured) {
          if (event is RentalEvent) {
            event.mapOrNull(
              dateRangeChanged: (e) {
                if (e.end == '2026-01-23') fail('Selected date across gap');
              },
            );
          }
        }
      },
    );
  });
}
