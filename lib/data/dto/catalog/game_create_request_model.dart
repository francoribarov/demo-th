import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/data/dto/catalog/game_model.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game_draft.dart';

part 'game_create_request_model.freezed.dart';
part 'game_create_request_model.g.dart';

/// Request model for creating a new game in the catalog.
@freezed
sealed class GameCreateRequestModel with _$GameCreateRequestModel {
  const factory GameCreateRequestModel({
    required String title,
    required String description,
    required int duration,
    required String players,
    required String difficulty,
    @Default([]) List<GameCategoryModel> categories,
    @Default([]) List<GameImageModel> images,
  }) = _GameCreateRequestModel;

  const GameCreateRequestModel._();

  factory GameCreateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GameCreateRequestModelFromJson(json);

  factory GameCreateRequestModel.fromDraft(GameDraft draft) =>
      GameCreateRequestModel(
        title: draft.title,
        description: draft.description,
        duration: draft.duration,
        players: draft.players,
        difficulty: draft.difficulty,
        categories:
            draft.categories.map(GameCategoryModel.fromEntity).toList(),
        images: draft.images.map((url) => GameImageModel(url: url)).toList(),
      );
}
