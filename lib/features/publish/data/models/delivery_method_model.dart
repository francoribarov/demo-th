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
    required int id,
    required String deliveryType,
    required int price,
    String? initPickupTime,
    String? finishPickupTime,
  }) = _DeliveryMethodModel;

  const DeliveryMethodModel._();

  factory DeliveryMethodModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryMethodModelFromJson(json);

  factory DeliveryMethodModel.fromEntity(DeliveryMethod entity) =>
      DeliveryMethodModel(
        id: entity.id,
        deliveryType: entity.deliveryType,
        price: entity.price,
        initPickupTime: entity.initPickupTime,
        finishPickupTime: entity.finishPickupTime,
      );

  @override
  DeliveryMethod toDomainModel() => DeliveryMethod(
        id: id,
        deliveryType: deliveryType,
        price: price,
        initPickupTime: initPickupTime,
        finishPickupTime: finishPickupTime,
      );
}
