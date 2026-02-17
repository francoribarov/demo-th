import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';

part 'publication_update_body.freezed.dart';
part 'publication_update_body.g.dart';

/// Request body for updating a publication.
///
/// This model represents the JSON payload sent to the API when updating
/// a publication. It's separate from the params object to handle API-specific
/// concerns like JSON serialization and field naming.
@freezed
sealed class PublicationUpdateBody with _$PublicationUpdateBody {
  const factory PublicationUpdateBody({
    /// Updated description (optional - only send if changed).
    String? description,

    /// Updated condition (optional - only send if changed).
    PublicationCondition? condition,

    /// Updated price (optional - only send if changed).
    int? price,

    /// Updated list of image URLs (optional - only send if changed).
    List<String>? images,

    /// Updated list of delivery method IDs (optional - only send if changed).
    @JsonKey(name: 'delivery_method_ids') List<String>? deliveryMethodIds,
  }) = _PublicationUpdateBody;

  const PublicationUpdateBody._();

  factory PublicationUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$PublicationUpdateBodyFromJson(json);
}
