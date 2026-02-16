import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/data/datasource/catalog/catalog_data_source.dart';
import 'package:mobile_table_hopping/data/dto/catalog/game_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_list_item_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_listing_model.dart';
import 'package:mobile_table_hopping/data/services/catalog/catalog_service.dart';
import 'package:mocktail/mocktail.dart';

class MockCatalogService extends Mock implements CatalogService {}

void main() {
  late MockCatalogService service;
  late CatalogRemoteDataSource dataSource;

  setUpAll(() {
    registerFallbackValue(<String, String>{});
  });

  setUp(() {
    service = MockCatalogService();
    dataSource = CatalogRemoteDataSourceImpl(service);
  });

  const publicationJson = {
    'id': 'pub-1',
    'owner_id': 'owner-1',
    'game_id': 'game-1',
    'title': 'Catan',
    'condition': 'new',
    'price': 1000.0,
    'created_at': '2026-01-01T00:00:00.000Z',
    'deposit': 200.0,
    'images': ['img-1'],
    'is_active': true,
    'booked_ranges': <Map<String, dynamic>>[],
    'game': {
      'players': '3-4',
      'duration': 90,
      'categories': <Map<String, dynamic>>[],
      'description': 'desc',
      'rating': 4.5,
      'reviews_count': 10,
      'difficulty': 'medium',
    },
  };
  const publicationListItemJson = {
    'id': 'pub-2',
    'description': 'Great game',
    'condition': 'new',
    'price': 1200,
    'images': [
      {'url': 'img-1', 'type': 'gallery'},
    ],
    'game': {
      'id': 'game-1',
      'title': 'Terraforming Mars',
      'rating': 4.7,
      'reviews': <Map<String, dynamic>>[],
      'description': 'Engine builder',
      'players': '1-5',
      'difficulty': 'Hard',
      'categories': <Map<String, dynamic>>[],
      'images': <Map<String, dynamic>>[],
      'duration': 120,
      'rules': {
        'video': '',
        'complete_rules': '',
        'summary_rules': '',
      },
    },
  };
  const categoryJson = {
    'id': 6,
    'name': 'Abstracto',
    'icon': '🧩',
    'query': 'Abstracto',
    'description': 'Minimalistas, elegantes y relajados.',
  };

  test('getPublications sends q param and parses map items response', () async {
    when(
      () => service.getPublications(any()),
    ).thenAnswer(
      (_) async => {
        'items': [publicationJson],
      },
    );

    final result = await dataSource.getPublications(query: 'catan');

    verify(
      () => service.getPublications(
        any(
          that: predicate<Map<String, String>>(
            (params) => params['q'] == 'catan',
            'contains q parameter',
          ),
        ),
      ),
    ).called(1);

    final data = expectSuccess<List<PublicationListingModel>>(result);
    expect(data, hasLength(1));
    expect(data.first.id, 'pub-1');
  });

  test('getPublicationsAvailableToday parses list response', () async {
    when(
      () => service.getPublicationsAvailableToday('10'),
    ).thenAnswer((_) async => [publicationJson]);

    final result = await dataSource.getPublicationsAvailableToday();

    final data = expectSuccess<List<PublicationListingModel>>(result);
    expect(data, hasLength(1));
  });

  test('getMyPublications parses paginated items response', () async {
    when(
      () => service.getMyPublications(),
    ).thenAnswer(
      (_) async => {
        'items': [publicationJson],
      },
    );

    final result = await dataSource.getMyPublications();

    final data = expectSuccess<List<PublicationListingModel>>(result);
    expect(data, hasLength(1));
  });

  test('getCategories parses categories envelope response', () async {
    when(
      () => service.getCategories(),
    ).thenAnswer(
      (_) async => {
        'categories': [categoryJson],
      },
    );

    final result = await dataSource.getCategories();
    final data = expectSuccess<List<GameCategoryModel>>(result);

    expect(data, hasLength(1));
    expect(data.first.name, 'Abstracto');
    expect(data.first.query, 'Abstracto');
  });

  test('getPublicationListings returns empty list on unexpected payload',
      () async {
    when(() => service.getPublicationListings(any())).thenAnswer(
      (_) async => 'unexpected',
    );

    final result = await dataSource.getPublicationListings(query: 'abc');

    final data = expectSuccess<List<PublicationListingModel>>(result);
    expect(data, isEmpty);
  });

  test('searchGames sends q param and parses list response', () async {
    when(
      () => service.searchGames(any()),
    ).thenAnswer((_) async => [publicationListItemJson]);

    final result = await dataSource.searchGames(query: 'terraforming');

    verify(
      () => service.searchGames(
        any(
          that: predicate<Map<String, String>>(
            (params) => params['q'] == 'terraforming',
            'contains q parameter',
          ),
        ),
      ),
    ).called(1);

    final data = expectSuccess<List<PublicationListItemModel>>(result);
    expect(data, hasLength(1));
    expect(data.first, isA<PublicationListItemModel>());
  });
}

T expectSuccess<T>(ApiResult<T> state) {
  return switch (state) {
    Success<T>(:final data) => data,
    Failure<T>(:final dataException) => fail(
        'Expected success, got error: ${dataException.message}',
      ),
  };
}
