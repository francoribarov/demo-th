import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/publication_detail.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';

part 'publication_detail_model.freezed.dart';
part 'publication_detail_model.g.dart';

/// Model for publication detail API response.
@freezed
sealed class PublicationDetailModel
    with _$PublicationDetailModel
    implements BaseDtoResponse<PublicationDetail> {
  const factory PublicationDetailModel({
    required String id,
    @JsonKey(name: 'game_id') required String gameId,
    @JsonKey(name: 'owner_id') required String ownerId,
    required String description,
    required PublicationCondition
        condition, // Changed type to PublicationCondition
    required int price,
    @Default([]) List<String> images,
    @JsonKey(name: 'delivery_methods')
    @Default([])
    List<DeliveryMethodDetailModel> deliveryMethods,
    @JsonKey(name: 'game_title') String? gameTitle,
    @JsonKey(name: 'game_image_url') String? gameImageUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _PublicationDetailModel;

  const PublicationDetailModel._();

  factory PublicationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationDetailModelFromJson(json);

  @override
  PublicationDetail toDomainModel() => PublicationDetail(
        id: id,
        gameId: gameId,
        ownerId: ownerId,
        description: description,
        condition: condition,
        price: price,
        images: images
            .map((url) => PublicationImage(url: url, type: 'gallery'))
            .toList(),
        deliveryMethods:
            deliveryMethods.map((dm) => dm.toDomainModel()).toList(),
        gameTitle: gameTitle,
        gameImageUrl: gameImageUrl,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

/// Model for delivery methods in publication detail.
@freezed
sealed class DeliveryMethodDetailModel
    with _$DeliveryMethodDetailModel
    implements BaseDtoResponse<DeliveryMethod> {
  const factory DeliveryMethodDetailModel({
    required String deliveryType,
    String? id,
    @Default(0) int price,
    String? address,
    @JsonKey(name: 'address_name') String? addressName,
    @JsonKey(name: 'address_number') String? addressNumber,
    @JsonKey(name: 'additional_notes') String? additionalNotes,
    @JsonKey(name: 'init_pickup_time') String? initPickupTime,
    @JsonKey(name: 'finish_pickup_time') String? finishPickupTime,
  }) = _DeliveryMethodDetailModel;

  const DeliveryMethodDetailModel._();

  factory DeliveryMethodDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryMethodDetailModelFromJson(json);

  @override
  DeliveryMethod toDomainModel() => DeliveryMethod(
        id: id,
        deliveryType: _parseDeliveryType(deliveryType),
        price: price,
        address: address,
        addressName: addressName,
        addressNumber: addressNumber,
        additionalNotes: additionalNotes,
        initPickupTime: initPickupTime,
        finishPickupTime: finishPickupTime,
      );

  static DeliveryType _parseDeliveryType(String value) {
    switch (value.toLowerCase()) {
      case 'delivery':
        return DeliveryType.delivery;
      case 'retiro en persona':
      case 'pickup_in_person':
      default:
        return DeliveryType.pickupInPerson;
    }
  }
}

/// Request model for updating a publication.
@freezed
sealed class PublicationUpdateRequestModel
    with _$PublicationUpdateRequestModel {
  const factory PublicationUpdateRequestModel({
    String? description,
    PublicationCondition? condition,
    int? price,
    List<String>? images,
    @JsonKey(name: 'delivery_method_ids') List<String>? deliveryMethodIds,
  }) = _PublicationUpdateRequestModel;

  const PublicationUpdateRequestModel._();

  factory PublicationUpdateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationUpdateRequestModelFromJson(json);

  factory PublicationUpdateRequestModel.fromEntity(PublicationUpdate update) =>
      PublicationUpdateRequestModel(
        description: update.description,
        condition: update.condition,
        price: update.price,
        images: update.images,
        deliveryMethodIds: update.deliveryMethodIds,
      );
}
