// Freezed entities are documented at a higher level; omit per-member docs.
//

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';

part 'publication_list_item.freezed.dart';

/// Image entity for publications
@freezed
abstract class PublicationImage with _$PublicationImage {
  const factory PublicationImage({
    required String url,
    @Default('gallery') String type,
    int? width,
    int? height,
  }) = _PublicationImage;
}

/// Image entity for games within publications
@freezed
abstract class GameImage with _$GameImage {
  const factory GameImage({
    required String url,
    @Default('gallery') String type,
    int? width,
    int? height,
  }) = _GameImage;
}

/// Nested game data within a publication listing
@freezed
abstract class GameInPublication with _$GameInPublication {
  const factory GameInPublication({
    required int id,
    required String title,
    required GameRules rules,
    @Default(0) int duration,
    @Default('Medio') String difficulty,
    @Default('2-4') String players,
    @Default([]) List<GameCategory> categories,
    @Default([]) List<AvailabilityRange> availability,
  }) = _GameInPublication;
}

/// Publication list item entity for catalog listing
/// Represents a publication with its nested game data
@freezed
abstract class PublicationListItem with _$PublicationListItem {
  const factory PublicationListItem({
    required String id,
    required String description,
    required String condition,
    required int price,
    required GameInPublication game,
    @Default([]) List<PublicationImage> images,
  }) = _PublicationListItem;
}
