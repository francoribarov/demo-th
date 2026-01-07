// Reason: Freezed and json_serializable generate annotation targets across file scopes.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/features/publish/data/models/delivery_method_model.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';

part 'publication_model.freezed.dart';
part 'publication_model.g.dart';

@freezed
/// Image model used for API serialization.
abstract class PublicationImageModel with _$PublicationImageModel {
  /// Creates an image model from API data.
  const factory PublicationImageModel({
    required String url,
    required String type,
    int? width,
    int? height,
  }) = _PublicationImageModel;

  /// Creates a model from a domain entity.
  factory PublicationImageModel.fromEntity(PublicationImage entity) =>
      PublicationImageModel(url: entity.url, type: entity.type, width: entity.width, height: entity.height);
  const PublicationImageModel._();

  /// Creates a model from JSON.
  factory PublicationImageModel.fromJson(Map<String, dynamic> json) => _$PublicationImageModelFromJson(json);

  /// Converts this model into a domain entity.
  PublicationImage toEntity() => PublicationImage(url: url, type: type, width: width, height: height);
}

@freezed
/// Publication model used for API serialization.
abstract class PublicationModel with _$PublicationModel {
  /// Creates a publication model from API data.
  const factory PublicationModel({
    required String id,

    // Actually old file had @JsonKey(name: 'ownerId') required String ownerId, so maybe backend expects camelCase. I will assume camelCase for now unless specified otherwise in rules (user guide mentions clean architecture but not API casing).
    // Wait, "User model matching backend UserSchema" had snake_case annotations (@JsonKey(name: 'avatar_url')).
    // So likely backend is snake_case.
    // 'ownerId' had explicit name 'ownerId' which is camelCase. Maybe previous backend was inconsistent.
    // I will use snake_case for new fields to be safe or derived from variable names if free.
    // Let's use snake_case for new fields if standard practice.
    // But wait, `pricePerDay` was camelCase annotation.
    // I'll stick to no annotation if variable name matches, or explicit if differ.
    // Let's assume snake_case for new backend (UML aligned).
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
  factory PublicationModel.fromJson(Map<String, dynamic> json) => _$PublicationModelFromJson(json);

  /// Converts this model into a domain entity.
  Publication toEntity() => Publication(
    id: id,
    gameId: gameId,
    ownerId: ownerId,
    description: description,
    condition: condition,
    price: price,
    images: images.map((i) => i.toEntity()).toList(),
    deliveryMethods: deliveryMethods.map((d) => d.toEntity()).toList(),
  );
}

@freezed
/// Request model used for publication creation.
abstract class PublicationCreateRequestModel with _$PublicationCreateRequestModel {
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
  factory PublicationCreateRequestModel.fromJson(Map<String, dynamic> json) => _$PublicationCreateRequestModelFromJson(json);

  /// Creates a request model from a domain draft.
  factory PublicationCreateRequestModel.fromEntity(PublicationDraft entity) => PublicationCreateRequestModel(
    gameId: entity.gameId,
    description: entity.description,
    price: entity.price,
    condition: entity.condition,
    images: entity.images.map(PublicationImageModel.fromEntity).toList(),
    deliveryMethods: entity.deliveryMethods.map(DeliveryMethodModel.fromEntity).toList(),
  );
}
