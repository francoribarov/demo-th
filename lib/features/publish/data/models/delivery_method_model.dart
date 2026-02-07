import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';

part 'delivery_method_model.freezed.dart';
part 'delivery_method_model.g.dart';

@freezed
sealed class DeliveryMethodModel
    with _$DeliveryMethodModel
    implements BaseDtoResponse<DeliveryMethod> {
  const factory DeliveryMethodModel({
    @JsonKey(name: 'delivery_type') required DeliveryType deliveryType,
    String? id,
    @Default(0) int price,
    String? address,
    @JsonKey(name: 'address_name') String? addressName,
    @JsonKey(name: 'address_number') String? addressNumber,
    @JsonKey(name: 'additional_notes') String? additionalNotes,
    @JsonKey(name: 'init_pickup_time') String? initPickupTime,
    @JsonKey(name: 'finish_pickup_time') String? finishPickupTime,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _DeliveryMethodModel;

  const DeliveryMethodModel._();

  factory DeliveryMethodModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryMethodModelFromJson(json);

  factory DeliveryMethodModel.fromEntity(DeliveryMethod entity) =>
      DeliveryMethodModel(
        id: entity.id,
        deliveryType: entity.deliveryType,
        price: entity.price,
        address: entity.address,
        addressName: entity.addressName,
        addressNumber: entity.addressNumber,
        additionalNotes: entity.additionalNotes,
        initPickupTime: entity.initPickupTime,
        finishPickupTime: entity.finishPickupTime,
        createdAt: entity.createdAt?.toIso8601String(),
        updatedAt: entity.updatedAt?.toIso8601String(),
      );

  @override
  DeliveryMethod toDomainModel() => DeliveryMethod(
        id: id,
        deliveryType: deliveryType,
        price: price,
        initPickupTime: initPickupTime,
        finishPickupTime: finishPickupTime,
        createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
        updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
      );
}
