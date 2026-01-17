import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';

/// Game rules information (video, PDF, summary).
@freezed
abstract class GameRules with _$GameRules {
  const factory GameRules({
    required String videoUrl,
    required String ruleCompleteUrl,
    required String summaryRules,
  }) = _GameRules;
}

/// A review from a user.
@freezed
abstract class GameReview with _$GameReview {
  const factory GameReview({
    required String id,
    required String userId,
    required double rating,
    required String comment,
    String? userName,
    DateTime? createdAt,
  }) = _GameReview;

  const GameReview._();

  String get name => userName ?? 'Anónimo';
}

/// Main Game entity - represents a game in the catalog.
/// This is catalog/reference data, not a rental listing.
@freezed
abstract class Game with _$Game {
  const factory Game({
    /// Unique game identifier in the catalog.
    required String id,

    /// Game title.
    required String title,

    /// Game description.
    required String description,

    /// Categories this game belongs to.
    @Default([]) List<GameCategory> categories,

    /// Game images.
    @Default([]) List<String> images,

    /// Average rating (0-5).
    @Default(0.0) double rating,

    /// Number of reviews.
    @Default(0) int reviewsCount,

    /// Duration in minutes.
    required int duration,

    /// Player count range (e.g., "2-4").
    required String players,

    /// Difficulty level (e.g., "Fácil", "Medio", "Difícil").
    @Default('') String difficulty,

    /// Game rules information.
    GameRules? rules,

    /// List of reviews.
    @Default([]) List<GameReview> reviews,
  }) = _Game;
}

/// Category for filtering games.
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

/// Filter shortcut for quick category/filter chips.
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
