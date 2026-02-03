import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';

part 'publication_detail.freezed.dart';

/// Represents a detailed publication that can be edited.
/// Extends the base Publication with additional edit-related fields.
@freezed
abstract class PublicationDetail with _$PublicationDetail {
  const factory PublicationDetail({
    required String id,
    required String gameId,
    required String ownerId,
    required String description,
    required PublicationCondition condition,
    required int price,
    @Default([]) List<PublicationImage> images,
    @Default([]) List<DeliveryMethod> deliveryMethods,
    String? gameTitle,
    String? gameImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PublicationDetail;

  const PublicationDetail._();

  /// Creates a draft from this publication for editing
  PublicationDraft toDraft() => PublicationDraft(
        gameId: gameId,
        description: description,
        price: price,
        condition: condition,
        images: images,
        deliveryMethods: deliveryMethods,
      );
}

/// Update payload for editing an existing publication.
@freezed
abstract class PublicationUpdate with _$PublicationUpdate {
  const factory PublicationUpdate({
    String? description,
    PublicationCondition? condition,
    int? price,
    List<String>? images,
    List<String>? deliveryMethodIds,
  }) = _PublicationUpdate;
}
