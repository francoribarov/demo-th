import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/search_games.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetGames extends Mock implements GetGames {}
class MockSearchGames extends Mock implements SearchGames {}

void main() {
  late MockGetGames mockGetGames;
  late MockSearchGames mockSearchGames;
  late CatalogBloc catalogBloc;

  setUp(() {
    mockGetGames = MockGetGames();
    mockSearchGames = MockSearchGames();
    catalogBloc = CatalogBloc(
      getGames: mockGetGames,
      searchGames: mockSearchGames,
    );
  });

  tearDown(() async {
    await catalogBloc.close();
  });

  const tGame = Game(
    id: 1,
    title: 'Test Game',
    category: 'Strategy',
    image: '',
    rating: 4.5,
    reviews: 10,
    description: 'Description',
    duration: '60 min',
    players: '2-4',
    difficulty: 'Medium',
    price: 100,
    rules: GameRules(video: '', text: ''),
  );

  group('CatalogBloc', () {
    test('initial state should be CatalogState', () {
      expect(catalogBloc.state, const CatalogState());
    });

    blocTest<CatalogBloc, CatalogState>(
      'emits [isLoading: true, allGames: [tGame]] when LoadGames is added',
      build: () {
        when(() => mockGetGames()).thenAnswer((_) async => [tGame]);
        when(() => mockGetGames.getAvailableToday()).thenAnswer((_) async => []);
        when(() => mockGetGames.getCategories()).thenAnswer((_) async => []);
        when(() => mockGetGames.getFilterShortcuts()).thenAnswer((_) async => []);
        return catalogBloc;
      },
      act: (bloc) => bloc.add(const CatalogEvent.loadGames()),
      expect: () => [
        const CatalogState(isLoading: true),
        const CatalogState(
          allGames: [tGame],
          filteredGames: [tGame],
        ),
      ],
    );
  });
}
