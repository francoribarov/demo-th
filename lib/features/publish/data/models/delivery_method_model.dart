import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';

part 'delivery_method_model.freezed.dart';
part 'delivery_method_model.g.dart';

@freezed
abstract class DeliveryMethodModel with _$DeliveryMethodModel {
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

  DeliveryMethod toEntity() => DeliveryMethod(
        id: id,
        deliveryType: deliveryType,
        price: price,
        initPickupTime: initPickupTime,
        finishPickupTime: finishPickupTime,
      );
}
