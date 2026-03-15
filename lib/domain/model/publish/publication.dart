import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart'
    hide DeliveryMethod;
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';

export 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart'
    show PublicationCondition, PublicationImage;

part 'publication.freezed.dart';

/// Draft payload used to create a publication.
@freezed
abstract class PublicationDraft with _$PublicationDraft {
  /// Creates a draft for publishing.
  const factory PublicationDraft({
    required String gameId,
    required String description,
    required int price,
    required PublicationCondition condition,
    required List<PublicationImage> images,
    required List<DeliveryMethod> deliveryMethods,
  }) = _PublicationDraft;
}

/// Published publication details returned by the backend.
@freezed
abstract class Publication with _$Publication {
  /// Creates a publication model from backend data.
  const factory Publication({
    required String id,
    required String gameId,
    required String ownerId,
    required String description,
    required PublicationCondition condition,
    required int price,
    @Default([]) List<PublicationImage> images,
    @Default([]) List<DeliveryMethod> deliveryMethods,
  }) = _Publication;
}
