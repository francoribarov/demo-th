import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart'
    show PublicationCondition;

part 'publication_listing.freezed.dart';

/// Availability range for a publication.
@freezed
abstract class AvailabilityRange with _$AvailabilityRange {
  const factory AvailabilityRange({
    required String from,
    required String to,
  }) = _AvailabilityRange;
}

/// Game data nested within a publication listing.
/// Contains only the game catalog information returned by /api/publications.
/// Note: Backend only returns players, duration, and categories.
@freezed
abstract class PublicationGameData with _$PublicationGameData {
  const factory PublicationGameData({
    @Default('') String players,
    @Default(0) int duration,
    @Default([]) List<GameCategory> categories,
    @Default('') String description,
    @Default(0.0) double rating,
    @Default(0) int reviewsCount,
    @Default('') String difficulty,
  }) = _PublicationGameData;
}

/// A publication listing as returned by GET /api/publications.
/// Represents a user's listing of a game for rent.
@freezed
abstract class PublicationListing with _$PublicationListing {
  const factory PublicationListing({
    /// Unique publication ID.
    required String id,

    /// Owner user ID.
    required String ownerId,

    /// Reference to the game in the catalog (UUID).
    required String gameId,

    /// Publication title (may differ from game title).
    required String title,

    /// Condition of the game copy (e.g., "Nuevo", "Usado").
    required PublicationCondition condition,

    /// Rental price per day.
    required double price,
    required DateTime createdAt,

    /// When the publication was created.

    /// Nested game data from the catalog.
    required PublicationGameData game,

    /// Deposit amount required.
    @Default(0.0) double deposit,

    /// Publication images.
    @Default([]) List<String> images,

    /// Whether the publication is currently active/available.
    @Default(true) bool isActive,

    /// Date ranges when the publication is booked/unavailable.
    @Default([]) List<AvailabilityRange> bookedDates,
  }) = _PublicationListing;

  const PublicationListing._();

  /// First image URL or empty string.
  String get heroImage => images.isNotEmpty ? images.first : '';

  /// First category name or 'Varios'.
  String get categoryName =>
      game.categories.isNotEmpty ? game.categories.first.name : 'Varios';

  /// Check if available for the given date range.
  bool isAvailableFor(String? startDate, String? endDate) {
    if (startDate == null || endDate == null) return true;

    final start = DateTime.tryParse(startDate);
    final end = DateTime.tryParse(endDate);
    if (start == null || end == null) return true;

    // Check if the requested range overlaps with any booked range
    return !bookedDates.any((booked) {
      final bookedStart = DateTime.tryParse(booked.from);
      final bookedEnd = DateTime.tryParse(booked.to);

      if (bookedStart == null || bookedEnd == null) return false;

      // Overlap logic: (StartA <= EndB) and (EndA >= StartB)
      return start.isBefore(bookedEnd.add(const Duration(days: 1))) &&
          end.isAfter(bookedStart.subtract(const Duration(days: 1)));
    });
  }

  /// Formatted availability label for UI.
  String get availabilityLabel {
    return 'Disponible';
  }

  String get conditionLabel => condition.label;
}
