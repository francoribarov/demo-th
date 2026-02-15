import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/repository/my_publications/publication_detail_repository.dart';

/// Use case for deleting a publication.
///
/// This use case encapsulates the business logic for removing a publication.
/// It delegates to the repository for the deletion operation.
///
/// Example:
/// ```dart
/// final result = await deletePublicationUseCase('publication-id');
/// result.fold(
///   (error) => print('Failed: ${error.message}'),
///   (_) => print('Deleted successfully'),
/// );
/// ```
@injectable
class DeletePublicationUseCase {
  /// Creates the use case with the required repository.
  const DeletePublicationUseCase(this._repository);

  final PublicationDetailRepository _repository;

  /// Executes the publication deletion.
  ///
  /// Parameters:
  /// - [id]: The publication ID to delete
  ///
  /// Returns:
  /// - [Right(void)] on successful deletion
  /// - [Left(DomainException)] if the operation fails
  Future<Either<DomainException, void>> call(String id) {
    return _repository.deletePublication(id);
  }
}
