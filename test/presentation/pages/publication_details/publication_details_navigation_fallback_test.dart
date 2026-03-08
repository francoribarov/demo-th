import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/game_reviews_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/game_rules_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/publication_details/game_reviews_page.dart';
import 'package:mobile_table_hopping/presentation/pages/publication_details/game_rules_page.dart';
import 'package:mocktail/mocktail.dart';

class MockGameRulesBloc extends Mock implements GameRulesBloc {}

class MockGameReviewsBloc extends Mock implements GameReviewsBloc {}

void main() {
  late MockGameRulesBloc mockGameRulesBloc;
  late MockGameReviewsBloc mockGameReviewsBloc;

  const gameReview = GameReview(
    id: 'r-1',
    userId: 'u-1',
    rating: 4,
    comment: 'Great game',
  );

  const game = Game(
    id: 'g-1',
    title: 'Terraforming Mars',
    description: 'Desc',
    duration: 120,
    players: '1-5',
    reviews: [gameReview],
    reviewsCount: 1,
    rating: 4,
    difficulty: 'Medio',
  );

  setUp(() {
    mockGameRulesBloc = MockGameRulesBloc();
    when(
      () => mockGameRulesBloc.state,
    ).thenReturn(const GameRulesState(errorMessage: 'No encontrado'));
    when(
      () => mockGameRulesBloc.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockGameRulesBloc.close()).thenAnswer((_) async {});

    mockGameReviewsBloc = MockGameReviewsBloc();
    when(
      () => mockGameReviewsBloc.state,
    ).thenReturn(
      const GameReviewsState(game: game, filteredReviews: [gameReview]),
    );
    when(
      () => mockGameReviewsBloc.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockGameReviewsBloc.close()).thenAnswer((_) async {});
  });

  GoRouter buildRulesRouter({required String initialLocation}) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: '/start',
          builder: (context, state) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => context.push('/rules'),
                child: const Text('Open rules'),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/rules',
          builder: (context, state) => BlocProvider<GameRulesBloc>.value(
            value: mockGameRulesBloc,
            child: const GameRulesPage(gameId: 'pub-1'),
          ),
        ),
        GoRoute(
          path: '/publications/:id',
          builder: (context, state) =>
              Text('publication ${state.pathParameters['id']}'),
        ),
      ],
    );
  }

  GoRouter buildReviewsRouter({required String initialLocation}) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: '/start',
          builder: (context, state) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => context.push('/reviews'),
                child: const Text('Open reviews'),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/reviews',
          builder: (context, state) => BlocProvider<GameReviewsBloc>.value(
            value: mockGameReviewsBloc,
            child: const GameReviewsPage(gameId: 'pub-1'),
          ),
        ),
        GoRoute(
          path: '/publications/:id',
          builder: (context, state) =>
              Text('publication ${state.pathParameters['id']}'),
        ),
      ],
    );
  }

  testWidgets('GameRulesPage pops when there is back stack', (tester) async {
    final router = buildRulesRouter(initialLocation: '/start');

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.tap(find.text('Open rules'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Open rules'), findsOneWidget);
    expect(find.textContaining('publication'), findsNothing);
  });

  testWidgets('GameRulesPage falls back to publication route when cannot pop', (
    tester,
  ) async {
    final router = buildRulesRouter(initialLocation: '/rules');

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('publication pub-1'), findsOneWidget);
  });

  testWidgets('GameReviewsPage pops when there is back stack', (tester) async {
    final router = buildReviewsRouter(initialLocation: '/start');

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.tap(find.text('Open reviews'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Open reviews'), findsOneWidget);
    expect(find.textContaining('publication'), findsNothing);
  });

  testWidgets(
    'GameReviewsPage falls back to publication route when cannot pop',
    (tester) async {
      final router = buildReviewsRouter(initialLocation: '/reviews');

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('publication pub-1'), findsOneWidget);
    },
  );
}
