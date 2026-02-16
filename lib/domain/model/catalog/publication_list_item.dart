// Freezed entities are documented at a higher level; omit per-member docs.
//

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart'
    show PublicationCondition;

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

/// Publication list item entity for catalog listing
/// Represents a publication with its nested game data
@freezed
abstract class PublicationListItem with _$PublicationListItem {
  const factory PublicationListItem({
    required String id,
    required String description,
    required PublicationCondition condition,
    required int price,
    required Game game,
    @Default([]) List<PublicationImage> images,
  }) = _PublicationListItem;
}
