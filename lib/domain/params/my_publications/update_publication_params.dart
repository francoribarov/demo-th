import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';

part 'update_publication_params.freezed.dart';

/// Input parameters for updating an existing publication.
///
/// This class represents the data needed to update a publication.
/// It's passed from the presentation layer through the use case to the repository.
///
/// Example:
/// ```dart
/// final params = UpdatePublicationParams(
///   id: '123',
///   description: 'Updated description',
///   condition: PublicationCondition.likeNew,
///   price: 5000,
///   images: ['image1.jpg', 'image2.jpg'],
///   deliveryMethodIds: ['method1', 'method2'],
/// );
/// ```
@freezed
abstract class UpdatePublicationParams with _$UpdatePublicationParams {
  /// Creates publication update parameters.
  const factory UpdatePublicationParams({
    /// ID of the publication to update.
    required String id,

    /// Updated description (optional - only send if changed).
    String? description,

    /// Updated condition (optional - only send if changed).
    PublicationCondition? condition,

    /// Updated price (optional - only send if changed).
    int? price,

    /// Updated list of image URLs (optional - only send if changed).
    List<String>? images,

    /// Updated list of delivery method IDs (optional - only send if changed).
    List<String>? deliveryMethodIds,
  }) = _UpdatePublicationParams;
}
