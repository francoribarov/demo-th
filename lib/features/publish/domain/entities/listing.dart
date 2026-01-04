import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing.freezed.dart';

@freezed
/// Image metadata used by listings.
abstract class ListingImage with _$ListingImage {
  /// Creates an image reference for a listing.
  const factory ListingImage({
    required String url,
    required String type,
    int? width,
    int? height,
  }) = _ListingImage;
}

@freezed
/// Draft payload used to create a listing.
abstract class ListingDraft with _$ListingDraft {
  /// Creates a draft for publishing a listing.
  const factory ListingDraft({
    required String title,
    required String category,
    required String description,
    required int pricePerDay,
    required String condition,
    required String visibility,
    required List<ListingImage> images,
    String? publisher,
    String? duration,
    String? players,
    String? difficulty,
    int? deposit,
  }) = _ListingDraft;
}

@freezed
/// Published listing details returned by the backend.
abstract class Listing with _$Listing {
  /// Creates a listing model from backend data.
  const factory Listing({
    required String id,
    required String title,
    required String category,
    required String description,
    required int pricePerDay,
    required String condition,
    required String visibility,
    required String ownerId,
    String? publisher,
    double? rating,
    int? reviews,
    String? duration,
    String? players,
    String? difficulty,
    int? deposit,
    @Default([]) List<ListingImage> images,
  }) = _Listing;
}
