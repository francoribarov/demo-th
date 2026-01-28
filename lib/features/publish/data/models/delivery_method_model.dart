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
    required DeliveryType deliveryType,
    String? id,
    @Default(0) int price,
    String? address,
    String? addressName,
    String? addressNumber,
    String? additionalNotes,
    String? initPickupTime,
    String? finishPickupTime,
    String? createdAt,
    String? updatedAt,
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
        initPickupTime: entity.initPickupTime?.toIso8601String(),
        finishPickupTime: entity.finishPickupTime?.toIso8601String(),
        createdAt: entity.createdAt?.toIso8601String(),
        updatedAt: entity.updatedAt?.toIso8601String(),
      );

  @override
  DeliveryMethod toDomainModel() => DeliveryMethod(
        id: id,
        deliveryType: deliveryType,
        price: price,
        initPickupTime:
            initPickupTime != null ? DateTime.tryParse(initPickupTime!) : null,
        finishPickupTime: finishPickupTime != null
            ? DateTime.tryParse(finishPickupTime!)
            : null,
        createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
        updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
      );
}
