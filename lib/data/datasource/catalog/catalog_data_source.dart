import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/data/dto/catalog/game_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_list_item_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_listing_model.dart';
import 'package:mobile_table_hopping/data/services/catalog/catalog_service.dart';

/// Remote datasource contract for catalog operations.
abstract class CatalogRemoteDataSource {
  /// Fetches publications with optional filters.
  Future<ApiResult<List<PublicationListingModel>>> getPublications({
    String? query,
    String? category,
    String? players,
    String? duration,
    int? priceMin,
    int? priceMax,
    String? startDate,
    String? endDate,
    String? sortBy,
    int page = 1,
    int limit = 100,
  });

  /// Fetches a single publication by ID.
  Future<ApiResult<PublicationListingModel>> getPublicationById(String id);

  /// Fetches publications available for rental today.
  Future<ApiResult<List<PublicationListingModel>>>
      getPublicationsAvailableToday({
    int limit = 10,
  });

  /// Fetches recommended publications based on a game ID.
  Future<ApiResult<List<PublicationListingModel>>> getRecommendedPublications(
    String gameId,
  );

  /// Fetches the current user's publications.
  Future<ApiResult<List<PublicationListingModel>>> getMyPublications();

  /// Fetches publication categories for filtering.
  Future<ApiResult<List<GameCategoryModel>>> getCategories();

  /// Fetches filter shortcuts for quick filtering.
  Future<ApiResult<List<FilterShortcutModel>>> getFilterShortcuts();

  /// Fetches publication listings with optional query filter.
  Future<ApiResult<List<PublicationListingModel>>> getPublicationListings({
    String? query,
  });

  /// Fetches a single game by ID.
  Future<ApiResult<GameModel>> getGameById(String id);

  /// Fetches all games from the catalog.
  Future<ApiResult<List<GameModel>>> getGames();

  /// Searches games with optional filters.
  Future<ApiResult<List<PublicationListItemModel>>> searchGames({
    String? query,
    String? players,
    String? duration,
    String? difficulty,
    String? category,
    String? startDate,
    String? endDate,
    String? sortBy,
  });

  /// Fetches recommended games for a specific game.
  Future<ApiResult<List<GameModel>>> getRecommendedGames(String gameId);
}

/// Implementation of [CatalogRemoteDataSource] using Retrofit service.
///
/// Extends [BaseDataSource] to leverage the standard error handling
/// and [ApiResult] wrapping pattern.
@LazySingleton(as: CatalogRemoteDataSource)
class CatalogRemoteDataSourceImpl extends BaseDataSource
    implements CatalogRemoteDataSource {
  CatalogRemoteDataSourceImpl(this._service);

  final CatalogService _service;

  @override
  Future<ApiResult<List<PublicationListingModel>>> getPublications({
    String? query,
    String? category,
    String? players,
    String? duration,
    int? priceMin,
    int? priceMax,
    String? startDate,
    String? endDate,
    String? sortBy,
    int page = 1,
    int limit = 100,
  }) {
    return getStateOf<List<PublicationListingModel>>(
      request: () async {
        final queryParams = <String, String>{
          'q': ?query,
          'category': ?category,
          'players': ?players,
          'duration': ?duration,
          if (priceMin != null) 'price_min': priceMin.toString(),
          if (priceMax != null) 'price_max': priceMax.toString(),
          'start_date': ?startDate,
          'end_date': ?endDate,
          'sort_by': ?sortBy,
          'page': page.toString(),
          'limit': limit.toString(),
        };
        final response = await _service.getPublications(queryParams);
        return _parsePublicationListingList(response);
      },
    );
  }

  @override
  Future<ApiResult<PublicationListingModel>> getPublicationById(String id) {
    return getStateOf<PublicationListingModel>(
      request: () async {
        final response = await _service.getPublicationById(id);
        return PublicationListingModel.fromJson(
          response as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  Future<ApiResult<List<PublicationListingModel>>>
      getPublicationsAvailableToday({
    int limit = 10,
  }) {
    return getStateOf<List<PublicationListingModel>>(
      request: () async {
        final response = await _service.getPublicationsAvailableToday(
          limit.toString(),
        );
        return _parsePublicationListingList(response);
      },
    );
  }

  @override
  Future<ApiResult<List<PublicationListingModel>>> getRecommendedPublications(
    String gameId,
  ) {
    return getStateOf<List<PublicationListingModel>>(
      request: () async {
        final response = await _service.getRecommendedPublications({
          'game_id': gameId,
          'limit': '10',
        });
        return _parsePublicationListingList(response);
      },
    );
  }

  @override
  Future<ApiResult<List<PublicationListingModel>>> getMyPublications() {
    return getStateOf<List<PublicationListingModel>>(
      request: () async {
        final response = await _service.getMyPublications();
        return _parsePublicationListingList(response);
      },
    );
  }

  @override
  Future<ApiResult<List<GameCategoryModel>>> getCategories() {
    return getStateOf<List<GameCategoryModel>>(
      request: () async {
        final response = await _service.getCategories();
        return _extractList(response)
            .map(
              (json) =>
                  GameCategoryModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }

  @override
  Future<ApiResult<List<FilterShortcutModel>>> getFilterShortcuts() {
    return getStateOf<List<FilterShortcutModel>>(
      request: () async {
        final response = await _service.getFilterShortcuts();
        return _extractList(response)
            .map(
              (json) =>
                  FilterShortcutModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }

  @override
  Future<ApiResult<List<PublicationListingModel>>> getPublicationListings({
    String? query,
  }) {
    return getStateOf<List<PublicationListingModel>>(
      request: () async {
        final queryParams = <String, String>{
          'q': ?query,
        };
        final response = await _service.getPublicationListings(queryParams);
        return _parsePublicationListingList(response);
      },
    );
  }

  @override
  Future<ApiResult<GameModel>> getGameById(String id) {
    return getStateOf<GameModel>(
      request: () async {
        final response = await _service.getGameById(id);
        return GameModel.fromJson(response as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<ApiResult<List<GameModel>>> getGames() {
    return getStateOf<List<GameModel>>(
      request: () async {
        final response = await _service.getGames();
        return _extractList(response)
            .map((json) => GameModel.fromJson(json as Map<String, dynamic>))
            .toList();
      },
    );
  }

  @override
  Future<ApiResult<List<PublicationListItemModel>>> searchGames({
    String? query,
    String? players,
    String? duration,
    String? difficulty,
    String? category,
    String? startDate,
    String? endDate,
    String? sortBy,
  }) {
    return getStateOf<List<PublicationListItemModel>>(
      request: () async {
        final queryParams = <String, String>{
          'q': ?query,
          'players': ?players,
          'duration': ?duration,
          'difficulty': ?difficulty,
          'category': ?category,
          'start_date': ?startDate,
          'end_date': ?endDate,
          'sort_by': ?sortBy,
        };
        final response = await _service.searchGames(queryParams);
        return _extractList(response)
            .map(
              (json) => PublicationListItemModel.fromJson(
                json as Map<String, dynamic>,
              ),
            )
            .toList();
      },
    );
  }

  @override
  Future<ApiResult<List<GameModel>>> getRecommendedGames(String gameId) {
    return getStateOf<List<GameModel>>(
      request: () async {
        final response = await _service.getRecommendedGames(gameId);
        return _extractList(response)
            .map((json) => GameModel.fromJson(json as Map<String, dynamic>))
            .toList();
      },
    );
  }

  List<PublicationListingModel> _parsePublicationListingList(dynamic data) {
    return _extractList(data)
        .map(
          (json) =>
              PublicationListingModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  List<dynamic> _extractList(dynamic data) {
    if (data is List) {
      return data;
    }
    if (data is Map<String, dynamic>) {
      const candidateKeys = [
        'items',
        'data',
        'results',
        'categories',
        'filter_shortcuts',
        'shortcuts',
      ];
      for (final key in candidateKeys) {
        final value = data[key];
        if (value is List) {
          return value;
        }
      }
    }
    return const [];
  }
}
