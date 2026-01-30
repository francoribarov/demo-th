import 'package:mobile_table_hopping/features/my_publications/domain/entities/publication_detail.dart';

abstract class PublicationDetailRepository {
  Future<PublicationDetail> getPublicationDetail(String id);

  Future<PublicationDetail> updatePublication(
    String id,
    PublicationUpdate update,
  );

  Future<void> deletePublication(String id);
}
