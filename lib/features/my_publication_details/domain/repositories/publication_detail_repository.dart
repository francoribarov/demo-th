import 'package:mobile_table_hopping/features/my_publication_details/domain/entities/publication_detail.dart';

/// Repository contract for publication details operations.
abstract class PublicationDetailRepository {
  /// Gets the detailed publication by [id].
  Future<PublicationDetail> getPublicationDetail(String id);

  /// Updates an existing publication with the given [update] data.
  Future<PublicationDetail> updatePublication(
    String id,
    PublicationUpdate update,
  );

  /// Deletes the publication with the given [id].
  Future<void> deletePublication(String id);
}
