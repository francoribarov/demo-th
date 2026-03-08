import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/data/dto/catalog/catalog_params.dart';
import 'package:mobile_table_hopping/data/dto/catalog/catalog_responses.dart';
import 'package:mobile_table_hopping/data/dto/catalog/game_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_list_item_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_listing_model.dart';
import 'package:mobile_table_hopping/data/services/catalog/catalog_service.dart';

/// Remote datasource contract for catalog operations.
abstract class CatalogRemoteDataSource {
  /// Fetches publications with optional filters.
  Future<ApiResult<List<PublicationListingModel>>> getPublications(
    PublicationsQueryParams params,
  );

  /// Fetches a single publication by ID.
  Future<ApiResult<PublicationListingModel>> getPublicationById(String id);

  /// Fetches publications available for rental today.
  Future<ApiResult<List<PublicationListingModel>>>
  getPublicationsAvailableToday(AvailableTodayQueryParams params);

  /// Fetches recommended publications based on a game ID.
  Future<ApiResult<List<PublicationListingModel>>> getRecommendedPublications(
    RecommendedPublicationsQueryParams params,
  );

  /// Fetches the current user's publications.
  Future<ApiResult<List<PublicationListingModel>>> getMyPublications();

  /// Fetches publication categories for filtering.
  Future<ApiResult<List<GameCategoryModel>>> getCategories();

  /// Fetches filter shortcuts for quick filtering.
  Future<ApiResult<List<FilterShortcutModel>>> getFilterShortcuts();

  /// Fetches publication listings with optional query filter.
  Future<ApiResult<List<PublicationListingModel>>> getPublicationListings(
    PublicationListingsQueryParams params,
  );

  /// Fetches a single game by ID.
  Future<ApiResult<GameModel>> getGameById(String id);

  /// Fetches all games from the catalog.
  Future<ApiResult<List<GameModel>>> getGames();

  /// Searches games with optional filters.
  Future<ApiResult<List<PublicationListItemModel>>> searchGames(
    SearchGamesQueryParams params,
  );

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
  Future<ApiResult<List<PublicationListingModel>>> getPublications(
    PublicationsQueryParams params,
  ) {
    return getStateOf<List<PublicationListingModel>>(
      request: () async {
        final response = await _service.getPublications(params.toQueryMap());
        return PublicationListingCollectionResponse.fromDynamic(response).items;
      },
    );
  }

  @override
  Future<ApiResult<PublicationListingModel>> getPublicationById(String id) {
    return getStateOf<PublicationListingModel>(
      request: () => _service.getPublicationById(id),
    );
  }

  @override
  Future<ApiResult<List<PublicationListingModel>>>
  getPublicationsAvailableToday(AvailableTodayQueryParams params) {
    return getStateOf<List<PublicationListingModel>>(
      request: () async {
        final response = await _service.getPublicationsAvailableToday(
          params.limit.toString(),
        );
        return PublicationListingCollectionResponse.fromDynamic(response).items;
      },
    );
  }

  @override
  Future<ApiResult<List<PublicationListingModel>>> getRecommendedPublications(
    RecommendedPublicationsQueryParams params,
  ) {
    return getStateOf<List<PublicationListingModel>>(
      request: () async {
        final response = await _service.getRecommendedPublications(
          params.toQueryMap(),
        );
        return PublicationListingCollectionResponse.fromDynamic(response).items;
      },
    );
  }

  @override
  Future<ApiResult<List<PublicationListingModel>>> getMyPublications() {
    return getStateOf<List<PublicationListingModel>>(
      request: () async {
        final response = await _service.getMyPublications();
        return PublicationListingCollectionResponse.fromDynamic(response).items;
      },
    );
  }

  @override
  Future<ApiResult<List<GameCategoryModel>>> getCategories() {
    return getStateOf<List<GameCategoryModel>>(
      request: () async {
        final response = await _service.getCategories();
        return GameCategoryCollectionResponse.fromDynamic(response).items;
      },
    );
  }

  @override
  Future<ApiResult<List<FilterShortcutModel>>> getFilterShortcuts() {
    return getStateOf<List<FilterShortcutModel>>(
      request: () async {
        final response = await _service.getFilterShortcuts();
        return FilterShortcutCollectionResponse.fromDynamic(response).items;
      },
    );
  }

  @override
  Future<ApiResult<List<PublicationListingModel>>> getPublicationListings(
    PublicationListingsQueryParams params,
  ) {
    return getStateOf<List<PublicationListingModel>>(
      request: () async {
        final response = await _service.getPublicationListings(
          params.toQueryMap(),
        );
        return PublicationListingCollectionResponse.fromDynamic(response).items;
      },
    );
  }

  @override
  Future<ApiResult<GameModel>> getGameById(String id) {
    return getStateOf<GameModel>(
      request: () => _service.getGameById(id),
    );
  }

  @override
  Future<ApiResult<List<GameModel>>> getGames() {
    return getStateOf<List<GameModel>>(
      request: () async {
        final response = await _service.getGames();
        return GameCollectionResponse.fromDynamic(response).items;
      },
    );
  }

  @override
  Future<ApiResult<List<PublicationListItemModel>>> searchGames(
    SearchGamesQueryParams params,
  ) {
    return getStateOf<List<PublicationListItemModel>>(
      request: () async {
        final response = await _service.searchGames(params.toQueryMap());
        return PublicationListItemCollectionResponse.fromDynamic(
          response,
        ).items;
      },
    );
  }

  @override
  Future<ApiResult<List<GameModel>>> getRecommendedGames(String gameId) {
    return getStateOf<List<GameModel>>(
      request: () => _service.getRecommendedGames(gameId),
    );
  }
}
