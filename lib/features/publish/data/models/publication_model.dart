import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/features/publish/data/models/delivery_method_model.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';

part 'publication_model.freezed.dart';
part 'publication_model.g.dart';

@freezed
/// Image model used for API serialization.
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

  /// Creates a model from a domain entity.
  factory PublicationImageModel.fromEntity(PublicationImage entity) =>
      PublicationImageModel(
        url: entity.url,
        type: entity.type,
        width: entity.width,
        height: entity.height,
      );
  const PublicationImageModel._();

  /// Creates a model from JSON.
  factory PublicationImageModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationImageModelFromJson(json);

  @override
  PublicationImage toDomainModel() =>
      PublicationImage(url: url, type: type, width: width, height: height);
}

@freezed
/// Publication model used for API serialization.
sealed class PublicationModel
    with _$PublicationModel
    implements BaseDtoResponse<Publication> {
  /// Creates a publication model from API data.
  const factory PublicationModel({
    required String id,
    required int gameId,
    required String ownerId,
    required String description,
    required String condition,
    required int price,
    @Default([]) List<PublicationImageModel> images,
    @Default([]) List<DeliveryMethodModel> deliveryMethods,
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
    images: images.map((i) => i.toDomainModel()).toList(),
    deliveryMethods: deliveryMethods.map((d) => d.toDomainModel()).toList(),
  );
}

@freezed
/// Request model used for publication creation.
sealed class PublicationCreateRequestModel
    with _$PublicationCreateRequestModel {
  /// Creates a publication creation request model.
  const factory PublicationCreateRequestModel({
    required int gameId,
    required String description,
    required int price,
    required String condition,
    required List<PublicationImageModel> images,
    required List<DeliveryMethodModel> deliveryMethods,
  }) = _PublicationCreateRequestModel;
  const PublicationCreateRequestModel._();

  /// Creates a model from JSON.
  factory PublicationCreateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PublicationCreateRequestModelFromJson(json);

  /// Creates a request model from a domain draft.
  factory PublicationCreateRequestModel.fromEntity(PublicationDraft entity) =>
      PublicationCreateRequestModel(
        gameId: entity.gameId,
        description: entity.description,
        price: entity.price,
        condition: entity.condition,
        images: entity.images.map(PublicationImageModel.fromEntity).toList(),
        deliveryMethods: entity.deliveryMethods
            .map(DeliveryMethodModel.fromEntity)
            .toList(),
      );
}
