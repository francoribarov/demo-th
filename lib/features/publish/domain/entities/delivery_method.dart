import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_method.freezed.dart';
part 'delivery_method.g.dart';

/// Delivery type options.
enum DeliveryType {
  @JsonValue('Retiro en persona')
  pickupInPerson,
  @JsonValue('Delivery')
  delivery;

  String get displayName {
    switch (this) {
      case DeliveryType.pickupInPerson:
        return 'Retiro en persona';
      case DeliveryType.delivery:
        return 'Delivery';
    }
  }

  String get icon {
    switch (this) {
      case DeliveryType.pickupInPerson:
        return '📍';
      case DeliveryType.delivery:
        return '🚚';
    }
  }
}

/// Delivery method configured for a publication.
@freezed
abstract class DeliveryMethod with _$DeliveryMethod {
  const factory DeliveryMethod({
    @JsonKey(name: 'delivery_type') required DeliveryType deliveryType,
    String? id,
    @Default(0) int price,
    String? address,
    String? addressName,
    String? addressNumber,
    String? additionalNotes,
    String? initPickupTime,
    String? finishPickupTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DeliveryMethod;

  factory DeliveryMethod.fromJson(Map<String, dynamic> json) =>
      _$DeliveryMethodFromJson(json);
}
