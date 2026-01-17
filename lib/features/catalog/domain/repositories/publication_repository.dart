import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';

/// Repository interface for publication operations.
/// Defines the contract for accessing publication data.
abstract class PublicationRepository {
  /// Fetches a list of publications with optional filters.
  Future<List<PublicationListing>> getPublications({
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
    int limit = 20,
  });

  /// Fetches a single publication by ID.
  Future<PublicationListing?> getPublicationById(String id);

  /// Fetches publications available for rental today.
  Future<List<PublicationListing>> getPublicationsAvailableToday({
    int limit = 10,
  });

  /// Fetches recommended publications based on a game ID.
  Future<List<PublicationListing>> getRecommendedPublications(String gameId);

  /// Fetches publication categories for filtering.
  Future<List<GameCategory>> getCategories();

  /// Fetches filter shortcuts for quick filtering.
  Future<List<FilterShortcut>> getFilterShortcuts();
}
