import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_games_use_case.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/game_search_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetGamesUseCase extends Mock implements GetGamesUseCase {}

void main() {
  late GetGamesUseCase getGames;

  const game1 = Game(
    id: 'g1',
    title: 'Catan',
    description: 'Trade and build',
    duration: 90,
    players: '3-4',
  );
  const game2 = Game(
    id: 'g2',
    title: 'Terraforming Mars',
    description: 'Space strategy',
    duration: 120,
    players: '1-5',
  );
  const game3 = Game(
    id: 'g3',
    title: 'Carcassonne',
    description: 'Tile placement',
    duration: 45,
    players: '2-5',
  );
  const games = [game1, game2, game3];

  setUp(() {
    getGames = MockGetGamesUseCase();
  });

  GameSearchCubit buildCubit() => GameSearchCubit(getGames: getGames);

  group('GameSearchCubit', () {
    blocTest<GameSearchCubit, GameSearchState>(
      'load emits isLoading true then false with games on success',
      build: buildCubit,
      act: (cubit) async {
        when(() => getGames()).thenAnswer(
          (_) async => const Right<DomainException, List<Game>>(games),
        );
        await cubit.load();
      },
      expect: () => [
        isA<GameSearchState>().having((s) => s.isLoading, 'isLoading', true),
        isA<GameSearchState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.allGames, 'allGames', games)
            .having((s) => s.filteredGames, 'filteredGames', games),
      ],
    );

    blocTest<GameSearchCubit, GameSearchState>(
      'load emits isLoading true then false with same state on failure',
      build: buildCubit,
      act: (cubit) async {
        when(() => getGames()).thenAnswer(
          (_) async => const Left(DomainException(message: 'load failed')),
        );
        await cubit.load();
      },
      expect: () => [
        isA<GameSearchState>().having((s) => s.isLoading, 'isLoading', true),
        isA<GameSearchState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.allGames, 'allGames', isEmpty)
            .having((s) => s.filteredGames, 'filteredGames', isEmpty),
      ],
    );

    blocTest<GameSearchCubit, GameSearchState>(
      'search with empty query restores full list',
      build: buildCubit,
      seed: () => const GameSearchState(
        allGames: games,
        filteredGames: [game1],
      ),
      act: (cubit) => cubit.search(''),
      expect: () => [
        isA<GameSearchState>().having(
          (s) => s.filteredGames,
          'filteredGames',
          games,
        ),
      ],
    );

    blocTest<GameSearchCubit, GameSearchState>(
      'search filters games by query case insensitive',
      build: buildCubit,
      seed: () => const GameSearchState(
        allGames: games,
        filteredGames: games,
      ),
      act: (cubit) => cubit.search('CATAN'),
      expect: () => [
        isA<GameSearchState>().having(
          (s) => s.filteredGames,
          'filteredGames',
          [game1],
        ),
      ],
    );
  });
}
