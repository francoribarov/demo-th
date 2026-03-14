import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';

/// Parameters for filtering publications.
class FilterPublicationsParams {
  /// Creates filter parameters.
  FilterPublicationsParams({
    required this.publications,
    required this.query,
    required this.selectedCategory,
    required this.filters,
    required this.sortOption,
    required this.startDate,
    required this.endDate,
  });

  final List<PublicationListing> publications;
  final String query;
  final String? selectedCategory;
  final FiltersState filters;
  final SortOption sortOption;
  final String? startDate;
  final String? endDate;
}

@injectable
/// Use case for filtering and sorting publication listings.
///
/// Applies all filter dimensions:
/// 1. Text query (title + category names)
/// 2. Selected category
/// 3. Price range (min + max)
/// 4. Players range
/// 5. Duration range
/// 6. Difficulty
/// 7. Experience types
/// 8. Available in dates
/// 9. Min rating
/// 10. Sort by price/rating/duration/availability
class FilterPublicationsUseCase {
  /// Filters and sorts publications based on all filter dimensions.
  List<PublicationListing> call(FilterPublicationsParams params) {
    var filtered = params.publications;

    // 1. Text Query
    if (params.query.isNotEmpty) {
      final q = params.query.toLowerCase();
      filtered = filtered
          .where(
            (p) =>
                p.title.toLowerCase().contains(q) ||
                p.game.categories.any((c) => c.name.toLowerCase().contains(q)),
          )
          .toList();
    }

    // 2. Selected Category
    if (params.selectedCategory != null) {
      filtered = filtered
          .where(
            (p) =>
                p.game.categories.any((c) => c.name == params.selectedCategory),
          )
          .toList();
    }

    // 3. Price Range
    if (params.filters.priceMin != null) {
      filtered = filtered
          .where((p) => p.price >= params.filters.priceMin!)
          .toList();
    }
    if (params.filters.priceMax != null) {
      filtered = filtered
          .where((p) => p.price <= params.filters.priceMax!)
          .toList();
    }

    // 4. Players Range
    if (params.filters.playersRange != PlayersRangeOption.any) {
      final (min, max) = params.filters.playersRange.range;
      filtered = filtered.where((p) {
        final players = _parsePlayersRange(p.game.players);
        if (players == null) return false;

        final (pMin, pMax) = players;
        // Check if ranges overlap
        if (min != null && pMax != null && pMax < min) return false;
        if (max != null && pMin != null && pMin > max) return false;
        return true;
      }).toList();
    }

    // 5. Duration Range
    if (params.filters.durationRange != DurationRangeOption.any) {
      final (min, max) = params.filters.durationRange.range;
      filtered = filtered.where((p) {
        final duration = p.game.duration;
        if (min != null && duration < min) return false;
        if (max != null && duration > max) return false;
        return true;
      }).toList();
    }

    // 6. Difficulty
    if (params.filters.difficulty != DifficultyOption.any) {
      final targetDifficulty = params.filters.difficulty.label;
      filtered = filtered
          .where((p) => p.game.difficulty == targetDifficulty)
          .toList();
    }

    // 7. Experience Types
    if (params.filters.experienceTypes.isNotEmpty) {
      filtered = filtered.where((p) {
        return params.filters.experienceTypes.any(
          (expType) => p.game.categories.any((c) => c.name == expType),
        );
      }).toList();
    }

    // 8. Available in Dates
    if (params.filters.onlyAvailableInDates &&
        params.startDate != null &&
        params.endDate != null) {
      filtered = filtered
          .where((p) => p.isAvailableFor(params.startDate, params.endDate))
          .toList();
    }

    // 9. Min Rating
    if (params.filters.minRating != null) {
      filtered = filtered
          .where((p) => p.game.rating >= params.filters.minRating!)
          .toList();
    }

    // 10. Sorting
    return _sortPublications(filtered, params.sortOption);
  }

  /// Parses players range string to (min, max) tuple.
  /// Examples: "2" -> (2, 2), "3-4" -> (3, 4), "7+" -> (7, null)
  (int?, int?)? _parsePlayersRange(String players) {
    if (players.isEmpty) return null;

    // Handle "7+" format
    if (players.endsWith('+')) {
      final min = int.tryParse(players.substring(0, players.length - 1));
      return min != null ? (min, null) : null;
    }

    // Handle "3-4" format
    if (players.contains('-')) {
      final parts = players.split('-');
      if (parts.length != 2) return null;
      final min = int.tryParse(parts[0].trim());
      final max = int.tryParse(parts[1].trim());
      if (min == null || max == null) return null;
      return (min, max);
    }

    // Handle "2" format
    final num = int.tryParse(players);
    return num != null ? (num, num) : null;
  }

  /// Sorts publications based on the sort option.
  List<PublicationListing> _sortPublications(
    List<PublicationListing> publications,
    SortOption sortOption,
  ) {
    final sorted = List<PublicationListing>.from(publications);

    switch (sortOption) {
      case SortOption.price:
        sorted.sort((a, b) => a.price.compareTo(b.price));
      case SortOption.rating:
        sorted.sort((a, b) => b.game.rating.compareTo(a.game.rating));
      case SortOption.duration:
        sorted.sort((a, b) => a.game.duration.compareTo(b.game.duration));
      case SortOption.availability:
        // Sort by number of booked dates (fewer is better)
        sorted.sort(
          (a, b) => a.bookedDates.length.compareTo(b.bookedDates.length),
        );
    }

    return sorted;
  }
}
