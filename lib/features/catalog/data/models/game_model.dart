// DTOs follow Freezed conventions; public docs are omitted for brevity.
// ignore_for_file: invalid_annotation_target, public_member_api_docs

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

part 'game_model.freezed.dart';
part 'game_model.g.dart';

/// Data transfer object for availability range
@freezed
class AvailabilityRangeModel with _$AvailabilityRangeModel {
  const factory AvailabilityRangeModel({required String from, required String to}) = _AvailabilityRangeModel;

  const AvailabilityRangeModel._();

  factory AvailabilityRangeModel.fromJson(Map<String, dynamic> json) => _$AvailabilityRangeModelFromJson(json);

  factory AvailabilityRangeModel.fromEntity(AvailabilityRange entity) =>
      AvailabilityRangeModel(from: entity.from, to: entity.to);

  AvailabilityRange toEntity() => AvailabilityRange(from: from, to: to);
}

/// Data transfer object for game rules
@freezed
class GameRulesModel with _$GameRulesModel {
  const factory GameRulesModel({required String video, required String text}) = _GameRulesModel;

  const GameRulesModel._();

  factory GameRulesModel.fromJson(Map<String, dynamic> json) => _$GameRulesModelFromJson(json);

  factory GameRulesModel.fromEntity(GameRules entity) => GameRulesModel(video: entity.video, text: entity.text);

  GameRules toEntity() => GameRules(video: video, text: text);
}

/// Data transfer object for game review
@freezed
class GameReviewModel with _$GameReviewModel {
  const factory GameReviewModel({
    required String name,
    required String role,
    required double rating,
    required String comment,
  }) = _GameReviewModel;

  const GameReviewModel._();

  factory GameReviewModel.fromJson(Map<String, dynamic> json) => _$GameReviewModelFromJson(json);

  factory GameReviewModel.fromEntity(GameReview entity) =>
      GameReviewModel(name: entity.name, role: entity.role, rating: entity.rating, comment: entity.comment);

  GameReview toEntity() => GameReview(name: name, role: role, rating: rating, comment: comment);
}

/// Data transfer object for Game entity
@freezed
class GameModel with _$GameModel {
  const factory GameModel({
    required int id,
    required String title,
    required String category,
    required String image,
    required double rating,
    required int reviews,
    required String description,
    required String duration,
    required String players,
    required String difficulty,
    required int price,
    List<AvailabilityRangeModel>? availability,

    /// `GET /api/games` returns a summary without `rules`.
    /// `GET /api/games/:id` includes `rules`.
    GameRulesModel? rules,
    @JsonKey(name: 'reviews_list') @Default([]) List<GameReviewModel> reviewsList,
  }) = _GameModel;

  const GameModel._();

  factory GameModel.fromJson(Map<String, dynamic> json) => _$GameModelFromJson(json);

  factory GameModel.fromEntity(Game entity) => GameModel(
    id: entity.id,
    title: entity.title,
    category: entity.category,
    image: entity.image,
    rating: entity.rating,
    reviews: entity.reviews,
    description: entity.description,
    duration: entity.duration,
    players: entity.players,
    difficulty: entity.difficulty,
    price: entity.price,
    availability: entity.availability?.map(AvailabilityRangeModel.fromEntity).toList(),
    rules: GameRulesModel.fromEntity(entity.rules),
    reviewsList: entity.reviewsList.map(GameReviewModel.fromEntity).toList(),
  );

  Game toEntity() => Game(
    id: id,
    title: title,
    category: category,
    image: image,
    rating: rating,
    reviews: reviews,
    description: description,
    duration: duration,
    players: players,
    difficulty: difficulty,
    price: price,
    availability: availability?.map((a) => a.toEntity()).toList(),
    rules: (rules ?? const GameRulesModel(video: '', text: '')).toEntity(),
    reviewsList: reviewsList.map((r) => r.toEntity()).toList(),
  );
}

/// Data transfer object for category
@freezed
class GameCategoryModel with _$GameCategoryModel {
  const factory GameCategoryModel({
    required int id,
    required String name,
    required String icon,
    String? query,
    String? description,
  }) = _GameCategoryModel;

  const GameCategoryModel._();

  factory GameCategoryModel.fromJson(Map<String, dynamic> json) => _$GameCategoryModelFromJson(json);

  GameCategory toEntity() => GameCategory(id: id, name: name, icon: icon, query: query, description: description);
}

/// Data transfer object for filter shortcut
@freezed
class FilterShortcutModel with _$FilterShortcutModel {
  const factory FilterShortcutModel({
    required int id,
    required String name,
    required String icon,
    required String type,
    String? query,
    String? value,
  }) = _FilterShortcutModel;

  const FilterShortcutModel._();

  factory FilterShortcutModel.fromJson(Map<String, dynamic> json) => _$FilterShortcutModelFromJson(json);

  FilterShortcut toEntity() => FilterShortcut(id: id, name: name, icon: icon, type: type, query: query, value: value);
}
