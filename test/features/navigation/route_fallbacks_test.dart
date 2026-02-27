import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/pages/user_profile_page.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/game_reviews_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/game_rules_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/publication_details/game_reviews_page.dart';
import 'package:mobile_table_hopping/presentation/pages/publication_details/game_rules_page.dart';
import 'package:mocktail/mocktail.dart';

class MockGameRulesBloc extends MockBloc<GameRulesEvent, GameRulesState> implements GameRulesBloc {}

class MockGameReviewsBloc extends MockBloc<GameReviewsEvent, GameReviewsState> implements GameReviewsBloc {}

class MockUserProfileBloc extends MockBloc<UserProfileEvent, UserProfileState> implements UserProfileBloc {}

void main() {
  const gameId = '42';

  setUpAll(() {
    registerFallbackValue(const GameRulesEvent.started(gameId: gameId));
    registerFallbackValue(const GameRulesState());
    registerFallbackValue(const GameReviewsEvent.started(gameId: gameId));
    registerFallbackValue(const GameReviewsState());
    registerFallbackValue(const UserProfileEvent.started(gameId: gameId));
    registerFallbackValue(const UserProfileState());
  });

  testWidgets('GameRulesPage back fallback goes to /publications/:id', (
    tester,
  ) async {
    final bloc = MockGameRulesBloc();
    const state = GameRulesState(
      errorMessage: 'No se encontró',
    );
    when(() => bloc.state).thenReturn(state);
    whenListen(bloc, const Stream<GameRulesState>.empty(), initialState: state);

    final router = GoRouter(
      initialLocation: '/rules',
      routes: [
        GoRoute(
          path: '/rules',
          builder: (_, _) => BlocProvider<GameRulesBloc>.value(
            value: bloc,
            child: const GameRulesPage(gameId: gameId),
          ),
        ),
        GoRoute(
          path: '/publications/:id',
          builder: (_, state) => Scaffold(
            body: Text('publication:${state.pathParameters['id']}'),
          ),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('publication:42'), findsOneWidget);
  });

  testWidgets('GameReviewsPage back fallback goes to /publications/:id', (
    tester,
  ) async {
    final bloc = MockGameReviewsBloc();
    const state = GameReviewsState(
      errorMessage: 'No se encontró',
    );
    when(() => bloc.state).thenReturn(state);
    whenListen(
      bloc,
      const Stream<GameReviewsState>.empty(),
      initialState: state,
    );

    final router = GoRouter(
      initialLocation: '/reviews',
      routes: [
        GoRoute(
          path: '/reviews',
          builder: (_, _) => BlocProvider<GameReviewsBloc>.value(
            value: bloc,
            child: const GameReviewsPage(gameId: gameId),
          ),
        ),
        GoRoute(
          path: '/publications/:id',
          builder: (_, state) => Scaffold(
            body: Text('publication:${state.pathParameters['id']}'),
          ),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('publication:42'), findsOneWidget);
  });

  testWidgets('UserProfilePage back fallback goes to /publications/:id', (
    tester,
  ) async {
    final bloc = MockUserProfileBloc();
    const game = Game(
      id: gameId,
      title: 'Catan',
      description: 'Juego de estrategia',
      duration: 90,
      players: '3-4',
      difficulty: 'Medio',
      rules: GameRules(
        videoUrl: '',
        ruleCompleteUrl: '',
        summaryRules: 'Resumen',
      ),
    );
    const state = UserProfileState(
      game: game,
    );
    when(() => bloc.state).thenReturn(state);
    whenListen(
      bloc,
      const Stream<UserProfileState>.empty(),
      initialState: state,
    );

    final router = GoRouter(
      initialLocation: '/owner',
      routes: [
        GoRoute(
          path: '/owner',
          builder: (_, _) => BlocProvider<UserProfileBloc>.value(
            value: bloc,
            child: const UserProfilePage(gameId: gameId),
          ),
        ),
        GoRoute(
          path: '/publications/:id',
          builder: (_, state) => Scaffold(
            body: Text('publication:${state.pathParameters['id']}'),
          ),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('publication:42'), findsOneWidget);
  });
}
