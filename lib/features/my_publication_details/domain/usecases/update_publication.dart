import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/my_publication_details/domain/entities/publication_detail.dart';
import 'package:mobile_table_hopping/features/my_publication_details/domain/repositories/publication_detail_repository.dart';

/// Use case to update an existing publication.
@injectable
class UpdatePublication {
  /// Creates the use case with the repository dependency.
  UpdatePublication(this._repository);

  final PublicationDetailRepository _repository;

  /// Executes the use case to update a publication.
  Future<PublicationDetail> call(String id, PublicationUpdate update) =>
      _repository.updatePublication(id, update);
}
