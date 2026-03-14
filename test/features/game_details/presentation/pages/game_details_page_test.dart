import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/publication_details_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/publication_details/publication_details_page.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class MockPublicationDetailsBloc extends Mock
    implements PublicationDetailsBloc {}

void main() {
  late MockPublicationDetailsBloc mockPublicationDetailsBloc;
  late MockAuthBloc mockAuthBloc;

  const game = Game(
    id: 'game-1',
    title: 'Terraforming Mars',
    description: 'Desc',
    duration: 120,
    players: '1-5',
    rating: 4.7,
    reviewsCount: 128,
    difficulty: 'Medio',
    reviews: [
      GameReview(
        id: 'review-1',
        userId: 'user-1',
        rating: 5,
        comment: 'Excelente',
      ),
    ],
  );

  final publication = PublicationListing(
    id: 'pub-1',
    ownerId: 'owner-1',
    gameId: 'game-1',
    title: 'Terraforming Mars Premium',
    condition: PublicationCondition.likeNew,
    price: 120,
    createdAt: DateTime(2026, 1, 2),
    game: const PublicationGameData(
      players: '1-5',
      duration: 120,
      categories: [
        GameCategory(id: 1, name: 'Estrategia', icon: 'strategy'),
      ],
      rating: 4.7,
      reviewsCount: 128,
      difficulty: 'Medio',
    ),
  );

  PublicationDetailsState detailsState() => PublicationDetailsState(
    publication: publication,
    gameDetail: game,
    checkStartDate: '2026-06-10',
    checkEndDate: '2026-06-13',
  );

  setUpAll(() {
    registerFallbackValue(
      const PublicationDetailsEvent.checkAvailabilityPressed(),
    );
  });

  setUp(() {
    mockPublicationDetailsBloc = MockPublicationDetailsBloc();
    mockAuthBloc = MockAuthBloc();
    when(
      () => mockPublicationDetailsBloc.state,
    ).thenReturn(detailsState());
    when(
      () => mockPublicationDetailsBloc.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockPublicationDetailsBloc.close()).thenAnswer((_) async {});
    when(() => mockPublicationDetailsBloc.add(any())).thenReturn(null);

    when(
      () => mockAuthBloc.state,
    ).thenReturn(const AuthState(status: AuthStatus.unauthenticated));
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockAuthBloc.close()).thenAnswer((_) async {});
  });

  Future<void> setLargeSurface(WidgetTester tester) async {
    tester.view
      ..physicalSize = const Size(1440, 2600)
      ..devicePixelRatio = 1;
    addTearDown(() {
      tester.view
        ..resetPhysicalSize()
        ..resetDevicePixelRatio();
    });
  }

  testWidgets(
    'dispatches checkAvailabilityPressed when availability button is tapped',
    (tester) async {
      await setLargeSurface(tester);
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>.value(value: mockAuthBloc),
              BlocProvider<PublicationDetailsBloc>.value(
                value: mockPublicationDetailsBloc,
              ),
            ],
            child: const PublicationDetailsPage(publicationId: 'pub-1'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final verifyButton = find.text('Verificar disponibilidad');
      await tester.ensureVisible(verifyButton);
      await tester.tap(verifyButton);
      await tester.pump();

      verify(
        () => mockPublicationDetailsBloc.add(
          const PublicationDetailsEvent.checkAvailabilityPressed(),
        ),
      ).called(1);
    },
  );

  testWidgets('navigates to rules route from details template callback', (
    tester,
  ) async {
    await setLargeSurface(tester);
    final router = GoRouter(
      initialLocation: '/publications/pub-1',
      routes: [
        GoRoute(
          path: '/publications/:id',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>.value(value: mockAuthBloc),
              BlocProvider<PublicationDetailsBloc>.value(
                value: mockPublicationDetailsBloc,
              ),
            ],
            child: PublicationDetailsPage(
              publicationId: state.pathParameters['id']!,
            ),
          ),
        ),
        GoRoute(
          path: '/publications/:id/rules',
          builder: (context, state) => const Text('rules-route'),
        ),
        GoRoute(
          path: '/publications/:id/reviews',
          builder: (context, state) => const Text('reviews-route'),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    final rulesButton = find.text('Ver reglas y tutorial');
    await tester.ensureVisible(rulesButton);
    await tester.tap(rulesButton);
    await tester.pumpAndSettle();

    expect(find.text('rules-route'), findsOneWidget);
  });

  testWidgets('navigates to reviews route from reviews template callback', (
    tester,
  ) async {
    await setLargeSurface(tester);
    final router = GoRouter(
      initialLocation: '/publications/pub-1',
      routes: [
        GoRoute(
          path: '/publications/:id',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>.value(value: mockAuthBloc),
              BlocProvider<PublicationDetailsBloc>.value(
                value: mockPublicationDetailsBloc,
              ),
            ],
            child: PublicationDetailsPage(
              publicationId: state.pathParameters['id']!,
            ),
          ),
        ),
        GoRoute(
          path: '/publications/:id/rules',
          builder: (context, state) => const Text('rules-route'),
        ),
        GoRoute(
          path: '/publications/:id/reviews',
          builder: (context, state) => const Text('reviews-route'),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    final tabLabel = find.text('Reseñas').first;
    await tester.ensureVisible(tabLabel);
    await tester.tap(tabLabel);
    await tester.pumpAndSettle();

    final reviewsButton = find.text('Ver todas las reseñas');
    await tester.ensureVisible(reviewsButton);
    await tester.tap(reviewsButton);
    await tester.pumpAndSettle();

    expect(find.text('reviews-route'), findsOneWidget);
  });
}
