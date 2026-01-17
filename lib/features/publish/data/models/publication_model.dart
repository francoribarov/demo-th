import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';

part 'publication_model.freezed.dart';
part 'publication_model.g.dart';

/// Image model used for API serialization.
@freezed
sealed class PublicationImageModel
    with _$PublicationImageModel
    implements BaseDtoResponse<PublicationImage> {
  /// Creates an image model from API data.
  const factory PublicationImageModel({
    required String url,
    required String type,
    int? width,
    int? height,
  }) = _PublicationImageModel;

  const PublicationImageModel._();

  /// Creates a model from a domain entity.
  factory PublicationImageModel.fromEntity(PublicationImage entity) =>
      PublicationImageModel(
        url: entity.url,
        type: entity.type,
        width: entity.width,
        height: entity.height,
      );

  /// Creates a model from JSON.
  factory PublicationImageModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationImageModelFromJson(json);

  @override
  PublicationImage toDomainModel() =>
      PublicationImage(url: url, type: type, width: width, height: height);
}

/// Publication model used for API serialization.
/// Matches backend response for GET /api/publications/{id}
@freezed
sealed class PublicationModel
    with _$PublicationModel
    implements BaseDtoResponse<Publication> {
  /// Creates a publication model from API data.
  const factory PublicationModel({
    required String id,
    @JsonKey(name: 'game_id') required String gameId,
    @JsonKey(name: 'owner_id') required String ownerId,
    required String description,
    required String condition,
    required int price,
    @Default([]) List<String> images,
  }) = _PublicationModel;

  const PublicationModel._();

  /// Creates a model from JSON.
  factory PublicationModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationModelFromJson(json);

  @override
  Publication toDomainModel() => Publication(
        id: id,
        gameId: gameId,
        ownerId: ownerId,
        description: description,
        condition: condition,
        price: price,
        images: images
            .map((url) => PublicationImage(url: url, type: 'gallery'))
            .toList(),
      );
}

/// Request model used for publication creation.
/// Matches backend POST /api/publications schema.
@freezed
sealed class PublicationCreateRequestModel
    with _$PublicationCreateRequestModel {
  /// Creates a publication creation request model.
  const factory PublicationCreateRequestModel({
    /// Owner ID (user creating the publication)
    @JsonKey(name: 'owner_id') required String ownerId,

    /// Game ID from the catalog
    @JsonKey(name: 'game_id') required String gameId,

    /// Description of the publication
    required String description,

    /// Condition: "new", "like_new", "good", "fair", "worn"
    required String condition,

    /// Price in UYU
    required int price,

    /// Image URLs as simple strings
    required List<String> images,

    /// Delivery methods
    required List<String> deliveryMethods,
  }) = _PublicationCreateRequestModel;

  const PublicationCreateRequestModel._();

  /// Creates a model from JSON.
  factory PublicationCreateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationCreateRequestModelFromJson(json);

  /// Creates a request model from a domain draft.
  factory PublicationCreateRequestModel.fromEntity(
    PublicationDraft entity, {
    required String ownerId,
  }) =>
      PublicationCreateRequestModel(
        ownerId: ownerId,
        gameId: entity.gameId,
        description: entity.description,
        price: entity.price,
        condition: entity.condition,
        images: entity.images.map((img) => img.url).toList(),
        deliveryMethods: entity.deliveryMethods,
      );
}
