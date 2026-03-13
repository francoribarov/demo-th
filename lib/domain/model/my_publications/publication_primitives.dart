import 'package:freezed_annotation/freezed_annotation.dart';

part 'publication_primitives.freezed.dart';

/// Standard conditions for a publication.
@JsonEnum(fieldRename: FieldRename.snake)
enum PublicationCondition {
  @JsonValue('like_new')
  likeNew('Como nuevo', 'Excelente estado'),
  @JsonValue('good')
  good('Buen estado', 'Uso normal'),
  @JsonValue('fair')
  fair('Aceptable', 'Desgaste visible');

  const PublicationCondition(this.label, this.description);

  final String label;
  final String description;
}

enum DeliveryType {
  pickupInPerson,
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

@freezed
abstract class PublicationImage with _$PublicationImage {
  const factory PublicationImage({
    required String url,
    required String type,
    int? width,
    int? height,
  }) = _PublicationImage;
}

@freezed
abstract class DeliveryMethod with _$DeliveryMethod {
  const factory DeliveryMethod({
    required DeliveryType deliveryType,
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
}
