import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

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
    required String condition,

    /// Rental price per day.
    required double price,

    /// Deposit amount required.
    @Default(0.0) double deposit,

    /// Publication images.
    @Default([]) List<String> images,

    /// Whether the publication is currently active/available.
    @Default(true) bool isActive,

    /// Date ranges when the publication is available for rent.
    @Default([]) List<AvailabilityRange> availability,

    /// When the publication was created.
    required DateTime createdAt,

    /// Nested game data from the catalog.
    required PublicationGameData game,
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
    if (availability.isEmpty) return true;

    final start = DateTime.tryParse(startDate);
    final end = DateTime.tryParse(endDate);
    if (start == null || end == null) return true;

    return availability.any((range) {
      final from = DateTime.tryParse(range.from);
      final to = DateTime.tryParse(range.to);
      if (from == null || to == null) return false;
      return !from.isAfter(start) && !to.isBefore(end);
    });
  }

  /// Formatted availability label for UI.
  String get availabilityLabel {
    if (availability.isEmpty) return 'Calendario a coordinar';
    final first = availability.first;
    return 'Disponible: ${_formatDate(first.from)} - ${_formatDate(first.to)}';
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      const months = [
        'ene',
        'feb',
        'mar',
        'abr',
        'may',
        'jun',
        'jul',
        'ago',
        'sep',
        'oct',
        'nov',
        'dic'
      ];
      return '${date.day} ${months[date.month - 1]}';
    } catch (_) {
      return dateStr;
    }
  }
}
