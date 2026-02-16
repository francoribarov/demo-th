import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/core/resources/data_state.dart';
import 'package:mobile_table_hopping/data/datasource/catalog/catalog_data_source.dart';
import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/repository/catalog/catalog_repository.dart';

/// Implementation of [CatalogRepository] using remote data source.
///
/// This repository bridges the domain and data layers, handling:
/// - Conversion from DataState to Either
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
    final result = await _dataSource.getPublications(
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
    );

    return result.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toDomainModel()).toList()),
      failed: (error) => Left(error.toDomainException()),
    );
  }

  @override
  Future<Either<DomainException, PublicationListing>> getPublicationById(
    String id,
  ) async {
    final result = await _dataSource.getPublicationById(id);
    return toEither(
      result.when(
        success: (dto) => DataState.success(dto.toDomainModel()),
        failed: DataState.failed,
      ),
    );
  }

  @override
  Future<Either<DomainException, List<PublicationListing>>>
      getPublicationsAvailableToday({
    int limit = 10,
  }) async {
    final result =
        await _dataSource.getPublicationsAvailableToday(limit: limit);
    return result.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toDomainModel()).toList()),
      failed: (error) => Left(error.toDomainException()),
    );
  }

  @override
  Future<Either<DomainException, List<PublicationListing>>>
      getRecommendedPublications(String gameId) async {
    final result = await _dataSource.getRecommendedPublications(gameId);
    return result.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toDomainModel()).toList()),
      failed: (error) => Left(error.toDomainException()),
    );
  }

  @override
  Future<Either<DomainException, List<PublicationListing>>>
      getMyPublications() async {
    final result = await _dataSource.getMyPublications();
    return result.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toDomainModel()).toList()),
      failed: (error) => Left(error.toDomainException()),
    );
  }

  @override
  Future<Either<DomainException, List<GameCategory>>> getCategories() async {
    final result = await _dataSource.getCategories();
    return result.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toDomainModel()).toList()),
      failed: (error) => Left(error.toDomainException()),
    );
  }

  @override
  Future<Either<DomainException, List<FilterShortcut>>>
      getFilterShortcuts() async {
    final result = await _dataSource.getFilterShortcuts();
    return result.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toDomainModel()).toList()),
      failed: (error) => Left(error.toDomainException()),
    );
  }

  @override
  Future<Either<DomainException, List<PublicationListing>>>
      getPublicationListings({
    String? query,
  }) async {
    final result = await _dataSource.getPublicationListings(query: query);
    return result.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toDomainModel()).toList()),
      failed: (error) => Left(error.toDomainException()),
    );
  }

  @override
  Future<Either<DomainException, Game>> getGameById(String id) async {
    final result = await _dataSource.getGameById(id);
    return toEither(
      result.when(
        success: (dto) => DataState.success(dto.toDomainModel()),
        failed: DataState.failed,
      ),
    );
  }

  @override
  Future<Either<DomainException, List<Game>>> getGames() async {
    final result = await _dataSource.getGames();
    return result.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toDomainModel()).toList()),
      failed: (error) => Left(error.toDomainException()),
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
    // Map FiltersState to API parameters
    String? playersParam;
    final playersRange = filters?.playersRange;
    if (playersRange != null) {
      playersParam = switch (playersRange) {
        PlayersRangeOption.any => null,
        PlayersRangeOption.two => '2',
        PlayersRangeOption.threeToFour => '3-4',
        PlayersRangeOption.fiveToSix => '5-6',
        PlayersRangeOption.sevenPlus => '7+',
      };
    }

    String? durationParam;
    final durationRange = filters?.durationRange;
    if (durationRange != null) {
      durationParam = switch (durationRange) {
        DurationRangeOption.any => null,
        DurationRangeOption.lte30 => 'lte30',
        DurationRangeOption.thirtyToSixty => '30-60',
        DurationRangeOption.sixtyToNinety => '60-90',
        DurationRangeOption.ninetyPlus => '90+',
      };
    }

    String? difficultyParam;
    if (filters?.difficulty != null &&
        filters!.difficulty != DifficultyOption.any) {
      difficultyParam = filters.difficulty.label;
    }

    String? categoryParam;
    if (filters?.experienceTypes.isNotEmpty ?? false) {
      categoryParam = filters!.experienceTypes.first;
    }

    final sortByParam = switch (sortOption) {
      SortOption.availability => 'availability',
      SortOption.price => 'price',
      SortOption.rating => 'rating',
      SortOption.duration => 'duration',
    };

    final result = await _dataSource.searchGames(
      query: query,
      players: playersParam,
      duration: durationParam,
      difficulty: difficultyParam,
      category: categoryParam,
      startDate: startDate,
      endDate: endDate,
      sortBy: sortByParam,
    );

    return result.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toGameEntity()).toList()),
      failed: (error) => Left(error.toDomainException()),
    );
  }

  @override
  Future<Either<DomainException, List<Game>>> getRecommendedGames(
    String gameId,
  ) async {
    final result = await _dataSource.getRecommendedGames(gameId);
    return result.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toDomainModel()).toList()),
      failed: (error) => Left(error.toDomainException()),
    );
  }
}
