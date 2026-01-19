import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/auth_session.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/auth_tokens.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/user.dart';
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_publication.dart';
import 'package:mobile_table_hopping/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';

class MockCreatePublication extends Mock implements CreatePublication {}

class MockAuthBloc extends Mock implements AuthBloc {}

class MockGetGames extends Mock implements GetGames {}

void main() {
  late MockCreatePublication mockCreatePublication;
  late MockAuthBloc mockAuthBloc;
  late MockGetGames mockGetGames;
  late PublishBloc publishBloc;

  setUp(() {
    mockCreatePublication = MockCreatePublication();
    mockAuthBloc = MockAuthBloc();
    mockGetGames = MockGetGames();

    // Mock authenticated state
    when(() => mockAuthBloc.state).thenReturn(
      AuthState(
        status: AuthStatus.authenticated,
        session: AuthSession(
          tokens: const AuthTokens(accessToken: 'test', refreshToken: 'test'),
          user: const User(
              id: 'user-123', email: 'test@test.com', username: 'testuser'),
        ),
      ),
    );

    // Stub GetGames call since it might be called
    when(() => mockGetGames()).thenAnswer((_) async => []);

    publishBloc = PublishBloc(
      createPublication: mockCreatePublication,
      authBloc: mockAuthBloc,
      getGames: mockGetGames,
    );
  });

  tearDown(() async {
    await publishBloc.close();
  });

  group('PublishBloc', () {
    test('initial state should be PublishState', () {
      expect(publishBloc.state, const PublishState());
    });

    blocTest<PublishBloc, PublishState>(
      'updates gameId and canProceed status',
      build: () => publishBloc,
      act: (bloc) =>
          bloc.add(const PublishEvent.gameIdChanged('game-uuid-123')),
      expect: () => [
        const PublishState(gameId: 'game-uuid-123'),
      ],
      verify: (bloc) {
        expect(bloc.state.canProceed, false); // No description/price yet
      },
    );

    blocTest<PublishBloc, PublishState>(
      'canProceed is true when basics are valid',
      build: () => publishBloc,
      act: (bloc) {
        bloc
          ..add(const PublishEvent.gameIdChanged('game-uuid-123'))
          ..add(const PublishEvent.descriptionChanged(
              'A very long and descriptive text for the game.'))
          ..add(const PublishEvent.priceChanged(100));
      },
      skip: 2,
      expect: () => [
        const PublishState(
          gameId: 'game-uuid-123',
          description: 'A very long and descriptive text for the game.',
          price: 100,
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.canProceed, true);
      },
    );
  });
}
