import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';

part 'game_model.freezed.dart';
part 'game_model.g.dart';

/// Data transfer object for game rules
@freezed
sealed class GameRulesModel
    with _$GameRulesModel
    implements BaseDtoResponse<GameRules> {
  const factory GameRulesModel({
    @JsonKey(name: 'video') @Default('') String videoUrl,
    @JsonKey(name: 'complete_rules') @Default('') String ruleCompleteUrl,
    @JsonKey(name: 'summary_rules') @Default('') String summaryRules,
  }) = _GameRulesModel;

  const GameRulesModel._();

  factory GameRulesModel.fromJson(Map<String, dynamic> json) =>
      _$GameRulesModelFromJson(json);

  factory GameRulesModel.fromEntity(GameRules? entity) => GameRulesModel(
    videoUrl: entity?.videoUrl ?? '',
    ruleCompleteUrl: entity?.ruleCompleteUrl ?? '',
    summaryRules: entity?.summaryRules ?? '',
  );

  @override
  GameRules toDomainModel() => GameRules(
    videoUrl: videoUrl,
    ruleCompleteUrl: ruleCompleteUrl,
    summaryRules: summaryRules,
  );
}

/// Data transfer object for game review
@freezed
sealed class GameReviewModel with _$GameReviewModel {
  const factory GameReviewModel({
    required String id,
    required String username,
    required double rating,
    required String comment,
  }) = _GameReviewModel;

  const GameReviewModel._();

  factory GameReviewModel.fromJson(Map<String, dynamic> json) =>
      _$GameReviewModelFromJson(json);

  GameReview toDomainModel() => GameReview(
    id: id,
    userId: '', // Not provided in public details
    rating: rating,
    comment: comment,
    userName: username,
  );
}

/// Data transfer object for Game entity
@freezed
sealed class GameModel with _$GameModel implements BaseDtoResponse<Game> {
  const factory GameModel({
    /// Unique identifier for the game
    @JsonKey(name: 'id', fromJson: _toString) required String id,
    required String title,
    @Default(0.0) double rating,
    @Default([]) List<GameReviewModel> reviews,
    @Default('') String description,
    @Default('2-4') String players,
    @Default('Medio') String difficulty,
    @Default([]) List<GameCategoryModel> categories,
    @Default([]) List<GameImageModel> images,
    @Default(0) int duration,
    @Default(GameRulesModel()) GameRulesModel rules,
  }) = _GameModel;

  const GameModel._();

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  factory GameModel.fromEntity(Game game) => GameModel(
    id: game.id,
    title: game.title,
    rating: game.rating,
    reviews: [], // Not supported in reverse mapping yet
    description: game.description,
    players: game.players,
    difficulty: game.difficulty,
    categories: game.categories.map(GameCategoryModel.fromEntity).toList(),
    images: game.images.map((url) => GameImageModel(url: url)).toList(),
    duration: game.duration,
    rules: GameRulesModel.fromEntity(game.rules),
  );

  @override
  Game toDomainModel() => Game(
    id: id,
    title: title,
    categories: categories.map((c) => c.toDomainModel()).toList(),
    images: images.map((i) => i.url).toList(),
    rating: rating,
    reviewsCount: reviews.length,
    description: description,
    duration: duration,
    players: players,
    difficulty: difficulty,
    rules: rules.toDomainModel(),
    reviews: reviews.map((r) => r.toDomainModel()).toList(),
  );
}

/// Data transfer object for category
@freezed
sealed class GameCategoryModel
    with _$GameCategoryModel
    implements BaseDtoResponse<GameCategory> {
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

  @override
  GameCategory toDomainModel() => GameCategory(
    id: id,
    name: name,
    icon: icon,
    query: query,
    description: description,
  );
}

/// Data transfer object for filter shortcut
@freezed
sealed class FilterShortcutModel
    with _$FilterShortcutModel
    implements BaseDtoResponse<FilterShortcut> {
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

  @override
  FilterShortcut toDomainModel() => FilterShortcut(
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
