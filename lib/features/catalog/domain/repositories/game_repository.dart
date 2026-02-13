import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';

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

  /// Get recommended games for a specific game (Publication ID)
  Future<List<Game>> getRecommendedGames(String gameId);

  /// Get all categories
  Future<List<GameCategory>> getCategories();

  /// Get filter shortcuts
  Future<List<FilterShortcut>> getFilterShortcuts();

  /// Get publication listings
  Future<List<PublicationListing>> getPublicationListings({String? query});
}
