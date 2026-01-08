// Freezed entities are documented at a higher level; omit per-member docs.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';

/// Availability range for a game
@freezed
abstract class AvailabilityRange with _$AvailabilityRange {
  const factory AvailabilityRange({required String from, required String to}) = _AvailabilityRange;
}

/// Game rules information
@freezed
abstract class GameRules with _$GameRules {
  const factory GameRules({
    required String videoUrl,
    required String ruleCompleteUrl,
    required String summaryRules,
  }) = _GameRules;
}

/// A review from a user
@freezed
abstract class GameReview with _$GameReview {
  const factory GameReview({
    required String userId,
    required double rating,
    required String comment,
    String? name, // Keeping name for UI convenience if backend sends it
  }) = _GameReview;
}

/// Main Game entity
/// Matches the Game interface from the Vite.js prototype
@freezed
abstract class Game with _$Game {
  const factory Game({
    /// Unique game identifier (Publication ID)
    required String id,

    /// Game title
    required String title,
    required List<GameCategory> categories,
    required List<String> images,
    required double rating,
    required int reviewsCount,
    required String description,
    required int duration,
    required String players,
    required String difficulty,
    required int price,
    required GameRules rules,

    /// Internal game identifier from Catalog (Int)
    @Default(0) int catalogId,

    /// Condition of the publication (e.g., "Nuevo", "Usado")
    @Default('') String? condition,
    String? ownerId,
    int? deposit,
    List<AvailabilityRange>? availability,
    @Default([]) List<GameReview> reviewsList,
  }) = _Game;

  const Game._();

  /// Check if the game is available for the given date range
  bool isAvailableFor(String? startDate, String? endDate) {
    if (startDate == null || endDate == null) return true;

    final start = DateTime.tryParse(startDate);
    final end = DateTime.tryParse(endDate);

    if (start == null || end == null) return true;
    if (start.isAfter(end)) return false;

    final ranges = availability;
    if (ranges == null || ranges.isEmpty) return true;

    return ranges.any((range) {
      final from = DateTime.tryParse(range.from);
      final to = DateTime.tryParse(range.to);
      if (from == null || to == null) return false;
      return !from.isAfter(start) && !to.isBefore(end);
    });
  }

  /// Get a formatted availability label
  String getAvailabilityLabel({String? searchStart, String? searchEnd}) {
    final ranges = availability;
    if (ranges == null || ranges.isEmpty) return 'Calendario a coordinar';

    if (searchStart != null && searchEnd != null) {
      final start = DateTime.tryParse(searchStart);
      final end = DateTime.tryParse(searchEnd);

      if (start != null && end != null) {
        // Check if there's a covering range
        final covering = ranges.where((range) {
          final from = DateTime.tryParse(range.from);
          final to = DateTime.tryParse(range.to);
          if (from == null || to == null) return false;
          return !from.isAfter(start) && !to.isBefore(end);
        }).firstOrNull;

        if (covering != null) {
          return 'Ventana disponible: ${_formatRange(covering.from, covering.to)}';
        }

        // Find next upcoming
        final upcoming =
            ranges
                .map((range) {
                  final from = DateTime.tryParse(range.from);
                  return from != null ? (range, from) : null;
                })
                .whereType<(AvailabilityRange, DateTime)>()
                .where((entry) => !entry.$2.isBefore(start))
                .toList()
              ..sort((a, b) => a.$2.compareTo(b.$2));

        if (upcoming.isNotEmpty) {
          final next = upcoming.first.$1;
          return 'Próximo turno: ${_formatRange(next.from, next.to)}';
        }
      }
    }

    return 'Disponible del ${_formatRange(ranges[0].from, ranges[0].to)}';
  }

  String _formatRange(String from, String to) {
    try {
      final fromDate = DateTime.parse(from);
      final toDate = DateTime.parse(to);
      final months = [
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
        'dic',
      ];
      return '${fromDate.day} ${months[fromDate.month - 1]} al ${toDate.day} ${months[toDate.month - 1]}';
    } on FormatException {
      return '$from - $to';
    }
  }
}

/// Category for filtering
@freezed
abstract class GameCategory with _$GameCategory {
  const factory GameCategory({
    required int id,
    required String name,
    required String icon,
    String? query,
    String? description,
  }) = _GameCategory;
}

/// Filter shortcut
@freezed
abstract class FilterShortcut with _$FilterShortcut {
  const factory FilterShortcut({
    required int id,
    required String name,
    required String icon,
    required String type,
    String? query,
    String? value,
  }) = _FilterShortcut;
}
