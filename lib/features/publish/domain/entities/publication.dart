import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';

part 'publication.freezed.dart';

/// Image metadata used by publications.
@freezed
abstract class PublicationImage with _$PublicationImage {
  /// Creates an image reference for a publication.
  const factory PublicationImage({
    required String url,
    required String type,
    int? width,
    int? height,
  }) = _PublicationImage;
}

/// Draft payload used to create a publication.
@freezed
abstract class PublicationDraft with _$PublicationDraft {
  /// Creates a draft for publishing.
  const factory PublicationDraft({
    required String gameId,
    required String description,
    required int price,
    required String condition, // "new"|"like_new"|"good"|"fair"|"worn"
    required List<PublicationImage> images,
    required List<String> deliveryMethods,
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
    required String condition,
    required int price,
    @Default([]) List<PublicationImage> images,
    @Default([]) List<DeliveryMethod> deliveryMethods,
  }) = _Publication;
}
