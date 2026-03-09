import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';

part 'publication.freezed.dart';

/// Standard conditions for a publication.
/// Values: like_new, good, fair.
@JsonEnum(fieldRename: FieldRename.snake)
enum PublicationCondition {
  /// Like new, perfect condition.
  @JsonValue('like_new')
  likeNew('Como nuevo', 'Excelente estado, sin marcas'),

  /// Good condition, normal wear.
  @JsonValue('good')
  good('Buen estado', 'Uso normal, todo completo'),

  /// Fair condition, visible wear but playable.
  @JsonValue('fair')
  fair('Aceptable', 'Desgaste visible pero funcional');

  const PublicationCondition(this.label, this.description);

  /// Display label (e.g., "Nuevo").
  final String label;

  /// detailed description.
  final String description;
}

/// Image metadata used by publications.
@freezed
abstract class PublicationImage with _$PublicationImage {
  /// Creates an image reference for a publication.
  const factory PublicationImage({
    required String url,
    required String type,
    int? width,
    int? height,
  }) = _PublicationImage;
}

/// Draft payload used to create a publication.
@freezed
abstract class PublicationDraft with _$PublicationDraft {
  /// Creates a draft for publishing.
  const factory PublicationDraft({
    required String gameId,
    required String description,
    required int price,
    required PublicationCondition condition,
    required List<PublicationImage> images,
    required List<DeliveryMethod> deliveryMethods,
  }) = _PublicationDraft;
}

/// Published publication details returned by the backend.
@freezed
abstract class Publication with _$Publication {
  /// Creates a publication model from backend data.
  const factory Publication({
    required String id,
    required String gameId,
    required String ownerId,
    required String description,
    required PublicationCondition condition,
    required int price,
    @Default([]) List<PublicationImage> images,
    @Default([]) List<DeliveryMethod> deliveryMethods,
  }) = _Publication;
}
