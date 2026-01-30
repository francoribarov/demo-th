import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/game_model.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/publication_listing_model.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_list_item.dart';

part 'publication_list_item_model.freezed.dart';
part 'publication_list_item_model.g.dart';

/// Data transfer object for publication images
@freezed
sealed class PublicationImageModel
    with _$PublicationImageModel
    implements BaseDtoResponse<PublicationImage> {
  const factory PublicationImageModel({
    required String url,
    @Default('gallery') String type,
    int? width,
    int? height,
  }) = _PublicationImageModel;

  const PublicationImageModel._();

  factory PublicationImageModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationImageModelFromJson(json);

  @override
  PublicationImage toDomainModel() => PublicationImage(
        url: url,
        type: type,
        width: width,
        height: height,
      );
}

/// Data transfer object for game images within publications
@freezed
sealed class GameImageModelV2
    with _$GameImageModelV2
    implements BaseDtoResponse<GameImage> {
  const factory GameImageModelV2({
    required String url,
    @Default('gallery') String type,
    int? width,
    int? height,
  }) = _GameImageModelV2;

  const GameImageModelV2._();

  factory GameImageModelV2.fromJson(Map<String, dynamic> json) =>
      _$GameImageModelV2FromJson(json);

  @override
  GameImage toDomainModel() => GameImage(
        url: url,
        type: type,
        width: width,
        height: height,
      );
}

/// Data transfer object for nested game within a publication
@freezed
sealed class GameInPublicationModel
    with _$GameInPublicationModel
    implements BaseDtoResponse<GameInPublication> {
  const factory GameInPublicationModel({
    required int id,
    required String title,
    @Default(0) int duration,
    @Default('Medio') String difficulty,
    @Default('2-4') String players,
    @Default([]) List<GameCategoryModel> categories,
    @Default([]) List<AvailabilityRangeModel> availability,
    @Default(GameRulesModel()) GameRulesModel rules,
  }) = _GameInPublicationModel;

  const GameInPublicationModel._();

  factory GameInPublicationModel.fromJson(Map<String, dynamic> json) =>
      _$GameInPublicationModelFromJson(json);

  @override
  GameInPublication toDomainModel() => GameInPublication(
        id: id,
        title: title,
        duration: duration,
        difficulty: difficulty,
        players: players,
        categories: categories.map((c) => c.toDomainModel()).toList(),
        availability: availability.map((a) => a.toDomainModel()).toList(),
        rules: rules.toDomainModel(),
      );
}

/// Data transfer object for publication list items
@freezed
sealed class PublicationListItemModel
    with _$PublicationListItemModel
    implements BaseDtoResponse<PublicationListItem> {
  const factory PublicationListItemModel({
    required String id,
    required String description,
    required String condition,
    required int price,
    required GameInPublicationModel game,
    @Default([]) List<PublicationImageModel> images,
  }) = _PublicationListItemModel;

  const PublicationListItemModel._();

  factory PublicationListItemModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationListItemModelFromJson(json);

  @override
  PublicationListItem toDomainModel() => PublicationListItem(
        id: id,
        description: description,
        condition: condition,
        price: price,
        images: images.map((i) => i.toDomainModel()).toList(),
        game: game.toDomainModel(),
      );

  /// Flatten publication + nested game into a Game entity for backwards compatibility
  Game toGameEntity() => Game(
        id: id, // We use publication ID as the flattened Game ID for legacy tracking
        title: game.title,
        categories: game.categories.map((c) => c.toDomainModel()).toList(),
        description: description,
        duration: game.duration,
        players: game.players,
        difficulty: game.difficulty,
        rules: game.rules.toDomainModel(),
      );
}

/// Data transfer object for publication details
@freezed
sealed class PublicationDetailModel
    with _$PublicationDetailModel
    implements BaseDtoResponse<Game> {
  const factory PublicationDetailModel({
    required String id,
    required String description,
    required String condition,
    required int price,
    required GameInPublicationModel game,
    required String ownerId,
    @Default([]) List<PublicationImageModel> images,
  }) = _PublicationDetailModel;

  const PublicationDetailModel._();

  factory PublicationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationDetailModelFromJson(json);

  @override
  Game toDomainModel() => toGameEntity();

  /// Flatten detailed publication into a Game entity
  Game toGameEntity() => Game(
        id: id,
        title: game.title,
        categories: game.categories.map((c) => c.toDomainModel()).toList(),
        description: description,
        duration: game.duration,
        players: game.players,
        difficulty: game.difficulty,
        rules: game.rules.toDomainModel(),
      );
}
