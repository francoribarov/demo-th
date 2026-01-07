// DTOs follow Freezed conventions; public docs are omitted for brevity.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

part 'game_model.freezed.dart';
part 'game_model.g.dart';

/// Data transfer object for availability range
@freezed
abstract class AvailabilityRangeModel with _$AvailabilityRangeModel {
  const factory AvailabilityRangeModel({
    required String from,
    required String to,
  }) = _AvailabilityRangeModel;

  const AvailabilityRangeModel._();

  factory AvailabilityRangeModel.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityRangeModelFromJson(json);

  factory AvailabilityRangeModel.fromEntity(AvailabilityRange entity) =>
      AvailabilityRangeModel(from: entity.from, to: entity.to);

  AvailabilityRange toEntity() => AvailabilityRange(from: from, to: to);
}

/// Data transfer object for game rules
@freezed
abstract class GameRulesModel with _$GameRulesModel {
  const factory GameRulesModel({
    @Default('') String videoUrl,
    @Default('') String ruleCompleteUrl,
    @Default('') String summaryRules,
  }) = _GameRulesModel;

  const GameRulesModel._();

  factory GameRulesModel.fromJson(Map<String, dynamic> json) =>
      _$GameRulesModelFromJson(json);

  factory GameRulesModel.fromEntity(GameRules entity) => GameRulesModel(
    videoUrl: entity.videoUrl,
    ruleCompleteUrl: entity.ruleCompleteUrl,
    summaryRules: entity.summaryRules,
  );

  GameRules toEntity() => GameRules(
    videoUrl: videoUrl,
    ruleCompleteUrl: ruleCompleteUrl,
    summaryRules: summaryRules,
  );
}

/// Data transfer object for game review
@freezed
abstract class GameReviewModel with _$GameReviewModel {
  const factory GameReviewModel({
    @Default('') String userId,
    @Default(0.0) double rating,
    @Default('') String comment,
    String? name,
  }) = _GameReviewModel;

  const GameReviewModel._();

  factory GameReviewModel.fromJson(Map<String, dynamic> json) =>
      _$GameReviewModelFromJson(json);

  factory GameReviewModel.fromEntity(GameReview entity) => GameReviewModel(
    userId: entity.userId,
    rating: entity.rating,
    comment: entity.comment,
    name: entity.name,
  );

  GameReview toEntity() => GameReview(
    userId: userId,
    rating: rating,
    comment: comment,
    name: name,
  );
}

/// Data transfer object for Game entity
@freezed
abstract class GameModel with _$GameModel {
  const factory GameModel({
    /// Unique identifier for the game
    @JsonKey(name: 'id', fromJson: _toString) required String id,
    required String title,
    @Default('') String? condition,
    @Default(0.0) double rating,
    @JsonKey(name: 'reviews') @Default(0) int reviewsCount,
    @Default('') String description,
    @Default('2-4') String players,
    @Default('Medio') String difficulty,
    @Default([]) List<GameCategoryModel> categories,
    @Default([]) List<GameImageModel> images,
    @Default(0) int duration,
    @Default(0) int price,
    @JsonKey(name: 'owner_id') String? ownerId,
    int? deposit,
    List<AvailabilityRangeModel>? availability,

    /// `GET /api/games` returns a summary without `rules`.
    /// `GET /api/games/:id` includes `rules`.
    GameRulesModel? rules,
    @JsonKey(name: 'reviews_list')
    @Default([])
    List<GameReviewModel> reviewsList,
  }) = _GameModel;

  const GameModel._();

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  factory GameModel.fromEntity(Game game) => GameModel(
    id: game.id,
    title: game.title,
    condition: game.condition,
    rating: game.rating,
    reviewsCount: game.reviewsCount,
    description: game.description,
    players: game.players,
    difficulty: game.difficulty,
    categories: game.categories.map(GameCategoryModel.fromEntity).toList(),
    images: game.images.map((url) => GameImageModel(url: url)).toList(),
    duration: game.duration,
    price: game.price,
    ownerId: game.ownerId,
    deposit: game.deposit,
    availability: game.availability
        ?.map(AvailabilityRangeModel.fromEntity)
        .toList(),
    rules: game.rules != null ? GameRulesModel.fromEntity(game.rules!) : null,
    reviewsList: game.reviewsList.map(GameReviewModel.fromEntity).toList(),
  );

  Game toEntity() => Game(
    id: id,
    catalogId: int.tryParse(id) ?? 0,
    title: title,
    condition: condition,
    categories: categories.map((c) => c.toEntity()).toList(),
    images: images.map((i) => i.url).toList(),
    rating: rating,
    reviewsCount: reviewsCount,
    description: description,
    duration: duration,
    players: players,
    difficulty: difficulty,
    price: price,
    ownerId: ownerId,
    deposit: deposit,
    availability: availability?.map((a) => a.toEntity()).toList(),
    rules: (rules ?? const GameRulesModel()).toEntity(),
    reviewsList: reviewsList.map((r) => r.toEntity()).toList(),
  );
}

/// Data transfer object for category
@freezed
abstract class GameCategoryModel with _$GameCategoryModel {
  const factory GameCategoryModel({
    required int id,
    required String name,
    required String icon,
    String? query,
    String? description,
  }) = _GameCategoryModel;

  const GameCategoryModel._();

  factory GameCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$GameCategoryModelFromJson(json);

  factory GameCategoryModel.fromEntity(GameCategory entity) =>
      GameCategoryModel(
        id: entity.id,
        name: entity.name,
        icon: entity.icon,
        query: entity.query,
        description: entity.description,
      );

  GameCategory toEntity() => GameCategory(
    id: id,
    name: name,
    icon: icon,
    query: query,
    description: description,
  );
}

/// Data transfer object for filter shortcut
@freezed
abstract class FilterShortcutModel with _$FilterShortcutModel {
  const factory FilterShortcutModel({
    required int id,
    required String name,
    required String icon,
    required String type,
    String? query,
    String? value,
  }) = _FilterShortcutModel;

  const FilterShortcutModel._();

  factory FilterShortcutModel.fromJson(Map<String, dynamic> json) =>
      _$FilterShortcutModelFromJson(json);

  FilterShortcut toEntity() => FilterShortcut(
    id: id,
    name: name,
    icon: icon,
    type: type,
    query: query,
    value: value,
  );
}

/// Data transfer object for game images
@freezed
abstract class GameImageModel with _$GameImageModel {
  const factory GameImageModel({
    required String url,
  }) = _GameImageModel;

  factory GameImageModel.fromJson(Map<String, dynamic> json) =>
      _$GameImageModelFromJson(json);
}

String _toString(dynamic value) => value.toString();
