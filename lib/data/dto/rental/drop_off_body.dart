import 'package:freezed_annotation/freezed_annotation.dart';

part 'drop_off_body.freezed.dart';
part 'drop_off_body.g.dart';

/// Request body for dropping off a rental.
///
/// This DTO (Data Transfer Object) represents the structure sent to the
/// rental drop-off API endpoint. It uses JSON serialization for HTTP requests.
///
/// Example JSON:
/// ```json
/// {
///   "dropOffDate": "2026-03-08",
///   "images": ["url1"]
/// }
/// ```
@freezed
abstract class DropOffBody with _$DropOffBody {
  /// Creates a drop-off request body.
  const factory DropOffBody({
    /// Date of the drop-off in YYYY-MM-DD format.
    required String dropOffDate,

    /// List of image URLs providing proof of the drop-off.
    required List<String> images,
  }) = _DropOffBody;

  /// Creates a [DropOffBody] from JSON.
  factory DropOffBody.fromJson(Map<String, dynamic> json) =>
      _$DropOffBodyFromJson(json);
}
