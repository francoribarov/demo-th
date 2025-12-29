// Public members in this file are self-explanatory within the data layer.
// ignore_for_file: public_member_api_docs

import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/catalog/data/datasources/category_remote_datasource.dart';
import 'package:mobile_table_hopping/features/catalog/data/datasources/game_remote_datasource.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/repositories/game_repository.dart';

/// Implementation of GameRepository using remote datasource
@LazySingleton(as: GameRepository)
class GameRepositoryImpl implements GameRepository {
  GameRepositoryImpl(this._gameDatasource, this._categoryDatasource);

  final GameRemoteDatasource _gameDatasource;
  final CategoryRemoteDatasource _categoryDatasource;

  @override
  Future<List<Game>> getGames() async {
    final response = await _gameDatasource.getGames();
    return response.items.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Game?> getGameById(int id) async {
    try {
      final model = await _gameDatasource.getGameById(id);
      return model.toEntity();
    } on Exception {
      return null;
    }
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
    if (filters?.difficulty != null && filters!.difficulty != DifficultyOption.any) {
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

    final response = await _gameDatasource.getGames(
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

    return response.items.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Game>> getGamesAvailableToday() async {
    final models = await _gameDatasource.getGamesAvailableToday();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Game>> getRecommendedGames(int gameId) async {
    final models = await _gameDatasource.getGameRecommendations(gameId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<GameCategory>> getCategories() async {
    final models = await _categoryDatasource.getCategories();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<FilterShortcut>> getFilterShortcuts() async {
    final models = await _categoryDatasource.getFilterShortcuts();
    return models.map((m) => m.toEntity()).toList();
  }
}
