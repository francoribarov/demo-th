import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/data/dto/catalog/game_model.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_list_item.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart'
    hide PublicationImage;

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
sealed class GameImageModel
    with _$GameImageModel
    implements BaseDtoResponse<GameImage> {
  const factory GameImageModel({
    required String url,
    @Default('gallery') String type,
    int? width,
    int? height,
  }) = _GameImageModel;

  const GameImageModel._();

  factory GameImageModel.fromJson(Map<String, dynamic> json) =>
      _$GameImageModelFromJson(json);

  @override
  GameImage toDomainModel() => GameImage(
    url: url,
    type: type,
    width: width,
    height: height,
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
    required PublicationCondition condition,
    required int price,
    required GameModel game,
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
    required GameModel game,
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
