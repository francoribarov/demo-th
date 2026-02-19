import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/datasource/catalog/catalog_data_source.dart';
import 'package:mobile_table_hopping/data/dto/catalog/catalog_params.dart';
import 'package:mobile_table_hopping/data/dto/catalog/game_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_list_item_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_listing_model.dart';
import 'package:mobile_table_hopping/data/mapper/catalog/catalog_filter_mapper.dart';
import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/repository/catalog/catalog_repository.dart';

/// Implementation of [CatalogRepository] using remote data source.
///
/// This repository bridges the domain and data layers, handling:
/// - Conversion from ApiResult to Either
/// - DTO to domain model mapping
/// - Error handling and transformation
@LazySingleton(as: CatalogRepository)
class CatalogRepositoryImpl extends BaseRepository
    implements CatalogRepository {
  CatalogRepositoryImpl(this._dataSource);

  final CatalogRemoteDataSource _dataSource;

  @override
  Future<Either<DomainException, List<PublicationListing>>> getPublications({
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
  }) async {
    return executeDataSourceList<PublicationListingModel, PublicationListing>(
      function: () => _dataSource.getPublications(
        PublicationsQueryParams(
        query: query,
        category: category,
        players: players,
        duration: duration,
        priceMin: priceMin,
        priceMax: priceMax,
        startDate: startDate,
        endDate: endDate,
        sortBy: sortBy,
        page: page,
        limit: limit,
        ),
      ),
    );
  }

  @override
  Future<Either<DomainException, PublicationListing>> getPublicationById(
    String id,
  ) async {
    return executeDataSource<PublicationListingModel, PublicationListing>(
      function: () => _dataSource.getPublicationById(id),
    );
  }

  @override
  Future<Either<DomainException, List<PublicationListing>>>
      getPublicationsAvailableToday({
    int limit = 10,
  }) async {
    return executeDataSourceList<PublicationListingModel, PublicationListing>(
      function: () => _dataSource.getPublicationsAvailableToday(
        AvailableTodayQueryParams(limit: limit),
      ),
    );
  }

  @override
  Future<Either<DomainException, List<PublicationListing>>>
      getRecommendedPublications(String gameId) async {
    return executeDataSourceList<PublicationListingModel, PublicationListing>(
      function: () => _dataSource.getRecommendedPublications(
        RecommendedPublicationsQueryParams(gameId: gameId),
      ),
    );
  }

  @override
  Future<Either<DomainException, List<PublicationListing>>>
      getMyPublications() async {
    return executeDataSourceList<PublicationListingModel, PublicationListing>(
      function: _dataSource.getMyPublications,
    );
  }

  @override
  Future<Either<DomainException, List<GameCategory>>> getCategories() async {
    return executeDataSourceList<GameCategoryModel, GameCategory>(
      function: _dataSource.getCategories,
    );
  }

  @override
  Future<Either<DomainException, List<FilterShortcut>>>
      getFilterShortcuts() async {
    return executeDataSourceList<FilterShortcutModel, FilterShortcut>(
      function: _dataSource.getFilterShortcuts,
    );
  }

  @override
  Future<Either<DomainException, List<PublicationListing>>>
      getPublicationListings({
    String? query,
  }) async {
    return executeDataSourceList<PublicationListingModel, PublicationListing>(
      function: () => _dataSource.getPublicationListings(
        PublicationListingsQueryParams(query: query),
      ),
    );
  }

  @override
  Future<Either<DomainException, Game>> getGameById(String id) async {
    return executeDataSource<GameModel, Game>(
      function: () => _dataSource.getGameById(id),
    );
  }

  @override
  Future<Either<DomainException, List<Game>>> getGames() async {
    return executeDataSourceList<GameModel, Game>(
      function: _dataSource.getGames,
    );
  }

  @override
  Future<Either<DomainException, List<Game>>> searchGames({
    String? query,
    FiltersState? filters,
    String? startDate,
    String? endDate,
    SortOption sortOption = SortOption.availability,
  }) async {
    // Map FiltersState to API parameters using mappers
    final playersParam = filters?.playersRange.toApiParam();
    final durationParam = filters?.durationRange.toApiParam();
    final difficultyParam = filters?.difficulty.toApiParam();
    final categoryParam = filters?.categoryApiParam;
    final sortByParam = sortOption.toApiParam();

    return executeDataSourceListMapped<PublicationListItemModel, Game>(
      function: () => _dataSource.searchGames(
        SearchGamesQueryParams(
          query: query,
          players: playersParam,
          duration: durationParam,
          difficulty: difficultyParam,
          category: categoryParam,
          startDate: startDate,
          endDate: endDate,
          sortBy: sortByParam,
        ),
      ),
      mapper: (dto) => dto.toGameEntity(),
    );
  }

  @override
  Future<Either<DomainException, List<Game>>> getRecommendedGames(
    String gameId,
  ) async {
    return executeDataSourceList<GameModel, Game>(
      function: () => _dataSource.getRecommendedGames(gameId),
    );
  }
}
