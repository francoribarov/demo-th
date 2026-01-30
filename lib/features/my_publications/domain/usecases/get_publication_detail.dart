import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/publication_detail.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/repositories/publication_detail_repository.dart';

/// Use case to get a publication's detailed information.
@injectable
class GetPublicationDetail {
  /// Creates the use case with the repository dependency.
  GetPublicationDetail(this._repository);

  final PublicationDetailRepository _repository;

  /// Executes the use case to fetch publication details by [id].
  Future<PublicationDetail> call(String id) =>
      _repository.getPublicationDetail(id);
}
