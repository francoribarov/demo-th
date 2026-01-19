import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

/// Repository interface for game operations
abstract class GameRepository {
  /// Get all games
  Future<List<Game>> getGames();

  /// Get a single game by ID (Publication ID)
  Future<Game?> getGameById(String id);

  /// Search games by query with optional filters
  Future<List<Game>> searchGames({
    String? query,
    FiltersState? filters,
    String? startDate,
    String? endDate,
    SortOption sortOption = SortOption.availability,
  });

  /// Get games available today
  Future<List<Game>> getGamesAvailableToday();

  /// Get recommended games for a specific game (Publication ID)
  Future<List<Game>> getRecommendedGames(String gameId);

  /// Get all categories
  Future<List<GameCategory>> getCategories();

  /// Get filter shortcuts
  Future<List<FilterShortcut>> getFilterShortcuts();
}
