import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_tokens.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_games_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/publish/create_publication_use_case.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/publish_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCreatePublication extends Mock implements CreatePublicationUseCase {}

class MockAuthBloc extends Mock implements AuthBloc {}

class MockGetGames extends Mock implements GetGamesUseCase {}

class FakePublicationDraft extends Fake implements PublicationDraft {}

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
      const AuthState(
        status: AuthStatus.authenticated,
        session: AuthSession(
          tokens: AuthTokens(accessToken: 'test', refreshToken: 'test'),
          user: User(
            id: 'user-123',
            email: 'test@test.com',
            username: 'testuser',
          ),
        ),
      ),
    );

    // Stub GetGamesUseCase call since it might be called
    when(
      () => mockGetGames(),
    ).thenAnswer((_) async => const Right<DomainException, List<Game>>([]));

    publishBloc = PublishBloc(
      createPublication: mockCreatePublication,
      authBloc: mockAuthBloc,
      getGames: mockGetGames,
    );
  });

  setUpAll(() {
    registerFallbackValue(FakePublicationDraft());
  });

  tearDown(() async {
    await publishBloc.close();
  });

  group('PublishBloc', () {
    test('initial state should be PublishState', () {
      expect(publishBloc.state, const PublishState());
    });

    blocTest<PublishBloc, PublishState>(
      'updates gameId and isStepValid status',
      build: () => publishBloc,
      act: (bloc) => bloc.add(const PublishEvent.gameIdChanged('game-uuid-123')),
      expect: () => [
        const PublishState(gameId: 'game-uuid-123'),
      ],
    );

    blocTest<PublishBloc, PublishState>(
      'sets isStepValid when all basic info is valid',
      build: () => publishBloc,
      act: (bloc) {
        bloc
          ..add(const PublishEvent.gameIdChanged('game-uuid-123'))
          ..add(
            const PublishEvent.descriptionChanged(
              'A great game in perfect condition.',
            ),
          )
          ..add(
            const PublishEvent.conditionChanged(PublicationCondition.likeNew),
          );
      },
      skip: 2, // Skip first two intermediate states
      expect: () => [
        const PublishState(
          gameId: 'game-uuid-123',
          description: 'A great game in perfect condition.',
          condition: PublicationCondition.likeNew,
          isStepValid: true,
        ),
      ],
      verify: (_) {
        expect(publishBloc.state.isStepValid, isTrue);
      },
    );

    blocTest<PublishBloc, PublishState>(
      'updates price correctly',
      build: () => publishBloc,
      act: (bloc) => bloc.add(const PublishEvent.priceChanged(1500)),
      expect: () => [
        const PublishState(price: 1500),
      ],
    );

    blocTest<PublishBloc, PublishState>(
      'navigates to next step when valid',
      build: () => publishBloc,
      seed: () => const PublishState(
        gameId: 'game-123',
        description: 'Valid description for the game',
        condition: PublicationCondition.likeNew,
        isStepValid: true,
      ),
      act: (bloc) => bloc.add(const PublishEvent.nextStep()),
      expect: () => [
        const PublishState(
          gameId: 'game-123',
          description: 'Valid description for the game',
          condition: PublicationCondition.likeNew,
          currentStep: 1,
          isStepValid: true,
        ),
      ],
    );

    blocTest<PublishBloc, PublishState>(
      'emits fallback error when createPublication throws unexpectedly',
      build: () {
        when(
          () => mockCreatePublication(any(), ownerId: any(named: 'ownerId')),
        ).thenThrow(Exception('unexpected'));
        return publishBloc;
      },
      seed: () => const PublishState(
        gameId: 'game-123',
        description: 'Valid description for the game',
        condition: PublicationCondition.likeNew,
        price: 1500,
        currentStep: 3,
        isStepValid: true,
      ),
      act: (bloc) => bloc.add(const PublishEvent.submit()),
      expect: () => [
        const PublishState(
          gameId: 'game-123',
          description: 'Valid description for the game',
          condition: PublicationCondition.likeNew,
          price: 1500,
          currentStep: 3,
          isStepValid: true,
          isSubmitting: true,
        ),
        const PublishState(
          gameId: 'game-123',
          description: 'Valid description for the game',
          condition: PublicationCondition.likeNew,
          price: 1500,
          currentStep: 3,
          isStepValid: true,
          errorMessage: 'Ocurrio un error inesperado al publicar.',
        ),
      ],
    );
  });
}
