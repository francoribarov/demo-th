import 'package:dartz/dartz.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game_draft.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';

/// Unified repository interface for catalog operations.
///
/// Combines publication and game/category operations into a single contract.
/// All methods return [Either<DomainException, T>] for explicit error handling.
abstract class CatalogRepository {
  /// Fetches a list of publications with optional filters.
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
  });

  /// Fetches a single publication by ID.
  Future<Either<DomainException, PublicationListing>> getPublicationById(
    String id,
  );

  /// Fetches publications available for rental today.
  Future<Either<DomainException, List<PublicationListing>>>
  getPublicationsAvailableToday({
    int limit = 10,
  });

  /// Fetches recommended publications based on a game ID.
  Future<Either<DomainException, List<PublicationListing>>>
  getRecommendedPublications(String gameId);

  /// Fetches the current user's publications.
  Future<Either<DomainException, List<PublicationListing>>> getMyPublications();

  /// Fetches publication categories for filtering.
  Future<Either<DomainException, List<GameCategory>>> getCategories();

  /// Fetches filter shortcuts for quick filtering.
  Future<Either<DomainException, List<FilterShortcut>>> getFilterShortcuts();

  /// Fetches publication listings with optional query filter.
  Future<Either<DomainException, List<PublicationListing>>>
  getPublicationListings({
    String? query,
  });

  /// Fetches a single game by ID.
  Future<Either<DomainException, Game>> getGameById(String id);

  /// Fetches all games from the catalog.
  Future<Either<DomainException, List<Game>>> getGames();

  /// Searches games with optional filters.
  Future<Either<DomainException, List<Game>>> searchGames({
    String? query,
    FiltersState? filters,
    String? startDate,
    String? endDate,
    SortOption sortOption = SortOption.availability,
  });

  /// Fetches recommended games for a specific game.
  Future<Either<DomainException, List<Game>>> getRecommendedGames(
    String gameId,
  );

  /// Creates a new game in the catalog.
  Future<Either<DomainException, Game>> createGame(GameDraft draft);
}
