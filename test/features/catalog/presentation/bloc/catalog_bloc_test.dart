import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/filter_publications_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_categories_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_filter_shortcuts_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_publications_use_case.dart';
import 'package:mobile_table_hopping/presentation/blocs/catalog/catalog_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCategories extends Mock implements GetCategoriesUseCase {}

class MockGetFilterShortcuts extends Mock implements GetFilterShortcutsUseCase {}

class MockGetPublications extends Mock implements GetPublicationsUseCase {}

class MockFilterPublications extends Mock implements FilterPublicationsUseCase {}

void main() {
  late MockGetCategories mockGetCategories;
  late MockGetFilterShortcuts mockGetFilterShortcuts;
  late MockGetPublications mockGetPublications;
  late MockFilterPublications mockFilterPublications;
  late CatalogBloc catalogBloc;

  setUp(() {
    mockGetCategories = MockGetCategories();
    mockGetFilterShortcuts = MockGetFilterShortcuts();
    mockGetPublications = MockGetPublications();
    mockFilterPublications = MockFilterPublications();
    catalogBloc = CatalogBloc(
      getPublications: mockGetPublications,
      getCategories: mockGetCategories,
      getFilterShortcuts: mockGetFilterShortcuts,
      filterPublications: mockFilterPublications,
    );
  });

  final tPublication = PublicationListing(
    id: '1',
    ownerId: 'owner1',
    gameId: 'g1',
    title: 'Test Publication',
    condition: PublicationCondition.newCondition,
    price: 100,
    images: ['image.jpg'],
    createdAt: DateTime(2023),
    game: const PublicationGameData(
      players: '2-4',
      duration: 60,
      categories: [GameCategory(id: 1, name: 'Strategy', icon: 'icon')],
    ),
  );

  group('CatalogBloc', () {
    test('initial state should be CatalogState', () {
      expect(catalogBloc.state, const CatalogState());
    });

    blocTest<CatalogBloc, CatalogState>(
      'emits loading and then catalog data when LoadGames is added',
      build: () {
        when(() => mockGetPublications()).thenAnswer(
          (_) async => Right<DomainException, List<PublicationListing>>([
            tPublication,
          ]),
        );
        when(() => mockGetCategories()).thenAnswer(
          (_) async => const Right<DomainException, List<GameCategory>>([]),
        );
        when(() => mockGetFilterShortcuts()).thenAnswer(
          (_) async => const Right<DomainException, List<FilterShortcut>>([]),
        );
        return catalogBloc;
      },
      act: (bloc) => bloc.add(const CatalogEvent.loadGames()),
      expect: () => [
        const CatalogState(isLoading: true),
        CatalogState(
          allPublications: [tPublication],
          filteredPublications: [tPublication],
          availableTodayPublications: [tPublication],
        ),
      ],
    );
  });
}
