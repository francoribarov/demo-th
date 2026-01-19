// Public members in this file are self-explanatory within the data layer.
//

import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/features/catalog/data/datasources/category_remote_datasource.dart';
import 'package:mobile_table_hopping/features/catalog/data/datasources/game_remote_datasource.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/game_model.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/publication_listing_model.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/domain/repositories/game_repository.dart';

/// Implementation of GameRepository using remote datasource
@LazySingleton(as: GameRepository)
class GameRepositoryImpl extends BaseRepository implements GameRepository {
  GameRepositoryImpl(this._gameDatasource, this._categoryDatasource);

  final GameRemoteDatasource _gameDatasource;
  final CategoryRemoteDatasource _categoryDatasource;

  @override
  Future<List<Game>> getGames() async {
    final response = await _gameDatasource.getAllGames();
    // ignore: avoid_print
    print('DEBUG: getGames fetched ${response.length} items from /api/games');
    return response.map((m) => m.toDomainModel()).toList();
  }

  @override
  Future<Game?> getGameById(String id) async {
    final response = await _gameDatasource.getGameById(id);
    return response.toDomainModel();
  }

  @override
  Future<List<Game>> searchGames({
    String? query,
    FiltersState? filters,
    String? startDate,
    String? endDate,
    SortOption sortOption = SortOption.availability,
  }) async {
    // Map filters to API parameters
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
      // Use first experience type as category filter
      categoryParam = filters!.experienceTypes.first;
    }

    final sortByParam = switch (sortOption) {
      SortOption.availability => 'availability',
      SortOption.price => 'price',
      SortOption.rating => 'rating',
      SortOption.duration => 'duration',
    };

    final response = await _gameDatasource.getPublications(
      query: query,
      category: categoryParam,
      players: playersParam,
      duration: durationParam,
      priceMin: filters?.priceMin,
      priceMax: filters?.priceMax,
      difficulty: difficultyParam,
      startDate: startDate,
      endDate: endDate,
      sortBy: sortByParam,
    );

    return response.map((m) => m.toGameEntity()).toList();
  }

  @override
  Future<List<Game>> getRecommendedGames(String gameId) async {
    final dtos = await _gameDatasource.getPublicationsRecommendations(gameId);
    return dtos.map((m) => m.toGameEntity()).toList();
  }

  @override
  Future<List<GameCategory>> getCategories() async {
    return executeDataSourceList<GameCategoryModel, GameCategory>(
      function: _categoryDatasource.getCategories,
    );
  }

  @override
  Future<List<FilterShortcut>> getFilterShortcuts() async {
    return executeDataSourceList<FilterShortcutModel, FilterShortcut>(
      function: _categoryDatasource.getFilterShortcuts,
    );
  }

  @override
  Future<List<PublicationListing>> getPublicationListings({
    String? query,
  }) async {
    final response = await _gameDatasource.getPublicationListings(query: query);
    return response.map((m) => m.toDomainModel()).toList();
  }
}
