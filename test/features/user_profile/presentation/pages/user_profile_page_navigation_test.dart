import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/pages/user_profile_page.dart';
import 'package:mocktail/mocktail.dart';

class MockUserProfileBloc extends MockBloc<UserProfileEvent, UserProfileState>
    implements UserProfileBloc {}

void main() {
  late MockUserProfileBloc userProfileBloc;

  setUpAll(() {
    registerFallbackValue(const UserProfileState());
    registerFallbackValue(const UserProfileEvent.started(gameId: 'fallback'));
  });

  setUp(() {
    userProfileBloc = MockUserProfileBloc();
  });

  testWidgets('back button falls back to /publications/:id route', (
    tester,
  ) async {
    const gameId = 'game-1';
    const loadedState = UserProfileState(
      game: Game(
        id: gameId,
        title: 'Catan',
        description: 'desc',
        duration: 60,
        players: '2-4',
      ),
    );

    whenListen(
      userProfileBloc,
      const Stream<UserProfileState>.empty(),
      initialState: loadedState,
    );
    when(() => userProfileBloc.state).thenReturn(loadedState);

    final router = GoRouter(
      initialLocation: '/owner',
      routes: [
        GoRoute(
          path: '/owner',
          builder: (context, state) => BlocProvider<UserProfileBloc>.value(
            value: userProfileBloc,
            child: const UserProfilePage(gameId: gameId),
          ),
        ),
        GoRoute(
          path: '/publications/:id',
          builder: (context, state) =>
              Text('publication-page:${state.pathParameters['id']}'),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('publication-page:game-1'), findsOneWidget);
  });
}
