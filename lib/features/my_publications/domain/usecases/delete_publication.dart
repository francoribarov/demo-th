import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/repositories/publication_detail_repository.dart';

/// Use case to delete an existing publication.
@injectable
class DeletePublication {
  /// Creates the use case with the repository dependency.
  DeletePublication(this._repository);

  final PublicationDetailRepository _repository;

  /// Executes the use case to delete a publication by [id].
  Future<void> call(String id) => _repository.deletePublication(id);
}
