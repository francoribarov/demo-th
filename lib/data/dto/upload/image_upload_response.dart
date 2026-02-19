import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';

part 'image_upload_response.freezed.dart';
part 'image_upload_response.g.dart';

/// Response DTO for image upload.
@freezed
abstract class ImageUploadResponse
    with _$ImageUploadResponse
    implements BaseDtoResponse<String> {
  /// Creates an [ImageUploadResponse].
  const factory ImageUploadResponse({
    required String url,
  }) = _ImageUploadResponse;

  const ImageUploadResponse._();

  /// Creates an [ImageUploadResponse] from JSON.
  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageUploadResponseFromJson(json);

  @override
  String toDomainModel() => url;
}
