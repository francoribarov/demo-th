// DTOs follow Freezed conventions; public docs are omitted for brevity.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile_table_hopping/features/catalog/data/models/game_model.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_list_item.dart';

part 'publication_list_item_model.freezed.dart';
part 'publication_list_item_model.g.dart';

/// Data transfer object for publication images
@freezed
abstract class PublicationImageModel with _$PublicationImageModel {
  const factory PublicationImageModel({
    required String url,
    @Default('gallery') String type,
    int? width,
    int? height,
  }) = _PublicationImageModel;

  const PublicationImageModel._();

  factory PublicationImageModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationImageModelFromJson(json);

  PublicationImage toEntity() => PublicationImage(
    url: url,
    type: type,
    width: width,
    height: height,
  );
}

/// Data transfer object for game images within publications
@freezed
abstract class GameImageModelV2 with _$GameImageModelV2 {
  const factory GameImageModelV2({
    required String url,
    @Default('gallery') String type,
    int? width,
    int? height,
  }) = _GameImageModelV2;

  const GameImageModelV2._();

  factory GameImageModelV2.fromJson(Map<String, dynamic> json) =>
      _$GameImageModelV2FromJson(json);

  GameImage toEntity() => GameImage(
    url: url,
    type: type,
    width: width,
    height: height,
  );
}

/// Data transfer object for nested game within a publication
@freezed
abstract class GameInPublicationModel with _$GameInPublicationModel {
  const factory GameInPublicationModel({
    required int id,
    required String title,
    @Default(0) int duration,
    @Default('Medio') String difficulty,
    @Default('2-4') String players,
    @Default(0.0) double rating,
    @Default(0) int reviews,
    @Default([]) List<GameCategoryModel> categories,
    @Default([]) List<GameImageModelV2> images,
    @Default([]) List<AvailabilityRangeModel> availability,
    GameRulesModel? rules, // Added rules for details
  }) = _GameInPublicationModel;

  const GameInPublicationModel._();

  factory GameInPublicationModel.fromJson(Map<String, dynamic> json) =>
      _$GameInPublicationModelFromJson(json);

  GameInPublication toEntity() => GameInPublication(
    id: id,
    title: title,
    duration: duration,
    difficulty: difficulty,
    players: players,
    rating: rating,
    reviews: reviews,
    categories: categories.map((c) => c.toEntity()).toList(),
    images: images.map((i) => i.toEntity()).toList(),
    availability: availability.map((a) => a.toEntity()).toList(),
    // rules mapping skipped as Domain GameInPublication doesn't have rules (yet)
    // but PublicationDetailModel will use it to map to Game entity
  );
}

/// Data transfer object for publication list items
@freezed
abstract class PublicationListItemModel with _$PublicationListItemModel {
  const factory PublicationListItemModel({
    required String id,
    required String description,
    required String condition,
    required int price,
    @Default([]) List<PublicationImageModel> images,
    required GameInPublicationModel game,
  }) = _PublicationListItemModel;

  const PublicationListItemModel._();

  factory PublicationListItemModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationListItemModelFromJson(json);

  PublicationListItem toEntity() => PublicationListItem(
    id: id,
    description: description,
    condition: condition,
    price: price,
    images: images.map((i) => i.toEntity()).toList(),
    game: game.toEntity(),
  );

  /// Flatten publication + nested game into a Game entity for backwards compatibility
  Game toGameEntity() => Game(
    id: id,
    catalogId: game.id,
    title: game.title,
    condition: condition,
    categories: game.categories.map((c) => c.toEntity()).toList(),
    images: game.images.map((i) => i.url).toList(),
    rating: game.rating,
    reviewsCount: game.reviews,
    description: description,
    duration: game.duration,
    players: game.players,
    difficulty: game.difficulty,
    price: price,
    rules: const GameRules(videoUrl: '', ruleCompleteUrl: '', summaryRules: ''),
    availability: game.availability.map((a) => a.toEntity()).toList(),
    reviewsList: const [], // List views don't usually show full reviews
  );
}

/// Data transfer object for publication details (adds extras used in getById)
@freezed
abstract class PublicationDetailModel with _$PublicationDetailModel {
  const factory PublicationDetailModel({
    required String id,
    required String description,
    required String condition,
    required int price,
    @Default([]) List<PublicationImageModel> images,
    required GameInPublicationModel game,
    required String ownerId,
    int? deposit,
  }) = _PublicationDetailModel;

  const PublicationDetailModel._();

  factory PublicationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationDetailModelFromJson(json);

  /// Flatten detailed publication into a Game entity
  Game toGameEntity() => Game(
    id: id,
    catalogId: game.id,
    title: game.title,
    condition: condition,
    categories: game.categories.map((c) => c.toEntity()).toList(),
    images: game.images.map((i) => i.url).toList(),
    rating: game.rating,
    reviewsCount: game.reviews,
    description: description,
    duration: game.duration,
    players: game.players,
    difficulty: game.difficulty,
    price: price,
    ownerId: ownerId,
    deposit: deposit,
    rules:
        game.rules?.toEntity() ??
        const GameRules(videoUrl: '', ruleCompleteUrl: '', summaryRules: ''),
    availability: game.availability.map((a) => a.toEntity()).toList(),
    reviewsList:
        const [], // Details typically load reviews separately via getGameReviews?
  );
}
