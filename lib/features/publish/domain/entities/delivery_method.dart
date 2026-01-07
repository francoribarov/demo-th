import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_method.freezed.dart';

@freezed
abstract class DeliveryMethod with _$DeliveryMethod {
  const factory DeliveryMethod({
    required int id,
    required String deliveryType, // "Retiro en persona" | "Delivery"
    required int price,
    String? initPickupTime,
    String? finishPickupTime,
  }) = _DeliveryMethod;
}
