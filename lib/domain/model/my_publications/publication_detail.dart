import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';

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
}
