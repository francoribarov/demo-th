import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_detail.dart';
import 'package:mobile_table_hopping/domain/params/my_publications/update_publication_params.dart';
import 'package:mobile_table_hopping/domain/repository/my_publications/publication_detail_repository.dart';

/// Use case for updating an existing publication.
///
/// This use case encapsulates the business logic for modifying a publication.
/// It validates the input parameters and delegates to the repository.
///
/// Example:
/// ```dart
/// final result = await updatePublicationUseCase(params);
/// result.fold(
///   (error) => print('Failed: ${error.message}'),
///   (updated) => print('Updated: ${updated.description}'),
/// );
/// ```
@injectable
class UpdatePublicationUseCase {
  /// Creates the use case with the required repository.
  const UpdatePublicationUseCase(this._repository);

  final PublicationDetailRepository _repository;

  /// Executes the publication update.
  ///
  /// Parameters:
  /// - [params]: The update parameters
  ///
  /// Returns:
  /// - [Right(PublicationDetail)] with updated publication on success
  /// - [Left(DomainException)] if the operation fails
  Future<Either<DomainException, PublicationDetail>> call(
    UpdatePublicationParams params,
  ) {
    return _repository.updatePublication(params);
  }
}
