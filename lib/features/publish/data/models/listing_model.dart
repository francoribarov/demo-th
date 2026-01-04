// Reason: Freezed and json_serializable generate annotation targets across file scopes.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/listing.dart';

part 'listing_model.freezed.dart';
part 'listing_model.g.dart';

@freezed
/// Image model used for API serialization.
abstract class ListingImageModel with _$ListingImageModel {
  /// Creates an image model from API data.
  const factory ListingImageModel({
    required String url,
    required String type,
    int? width,
    int? height,
  }) = _ListingImageModel;

  /// Creates a model from a domain entity.
  factory ListingImageModel.fromEntity(ListingImage entity) =>
      ListingImageModel(url: entity.url, type: entity.type, width: entity.width, height: entity.height);
  const ListingImageModel._();

  /// Creates a model from JSON.
  factory ListingImageModel.fromJson(Map<String, dynamic> json) => _$ListingImageModelFromJson(json);

  /// Converts this model into a domain entity.
  ListingImage toEntity() => ListingImage(url: url, type: type, width: width, height: height);
}

@freezed
/// Listing model used for API serialization.
abstract class ListingModel with _$ListingModel {
  /// Creates a listing model from API data.
  const factory ListingModel({
    required String id,
    required String title,
    required String category,
    required String description,
    @JsonKey(name: 'pricePerDay') required int pricePerDay,
    required String condition,
    required String visibility,
    @JsonKey(name: 'ownerId') required String ownerId,
    String? publisher,
    double? rating,
    int? reviews,
    String? duration,
    String? players,
    String? difficulty,
    int? deposit,
    @Default([]) List<ListingImageModel> images,
  }) = _ListingModel;
  const ListingModel._();

  /// Creates a model from JSON.
  factory ListingModel.fromJson(Map<String, dynamic> json) => _$ListingModelFromJson(json);

  /// Converts this model into a domain entity.
  Listing toEntity() => Listing(
    id: id,
    title: title,
    publisher: publisher,
    category: category,
    description: description,
    rating: rating,
    reviews: reviews,
    duration: duration,
    players: players,
    difficulty: difficulty,
    pricePerDay: pricePerDay,
    deposit: deposit,
    condition: condition,
    visibility: visibility,
    ownerId: ownerId,
    images: images.map((i) => i.toEntity()).toList(),
  );
}

@freezed
/// Request model used for listing creation.
abstract class ListingCreateRequestModel with _$ListingCreateRequestModel {
  /// Creates a listing creation request model.
  const factory ListingCreateRequestModel({
    required String title,
    required String category,
    required String description,
    @JsonKey(name: 'pricePerDay') required int pricePerDay,
    required String condition,
    required String visibility,
    required List<ListingImageModel> images,
    String? publisher,
    String? duration,
    String? players,
    String? difficulty,
    int? deposit,
  }) = _ListingCreateRequestModel;
  const ListingCreateRequestModel._();

  /// Creates a model from JSON.
  factory ListingCreateRequestModel.fromJson(Map<String, dynamic> json) => _$ListingCreateRequestModelFromJson(json);

  /// Creates a request model from a domain draft.
  factory ListingCreateRequestModel.fromEntity(ListingDraft entity) => ListingCreateRequestModel(
    title: entity.title,
    publisher: entity.publisher,
    category: entity.category,
    description: entity.description,
    duration: entity.duration,
    players: entity.players,
    difficulty: entity.difficulty,
    pricePerDay: entity.pricePerDay,
    deposit: entity.deposit,
    condition: entity.condition,
    visibility: entity.visibility,
    images: entity.images.map(ListingImageModel.fromEntity).toList(),
  );
}
