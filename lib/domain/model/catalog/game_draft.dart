import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';

part 'game_draft.freezed.dart';

/// Draft payload used to create a new game in the catalog.
@freezed
abstract class GameDraft with _$GameDraft {
  const factory GameDraft({
    required String title,
    required String description,
    required int duration,
    required String players,
    required String difficulty,
    @Default([]) List<GameCategory> categories,
    @Default([]) List<String> images,
  }) = _GameDraft;
}
