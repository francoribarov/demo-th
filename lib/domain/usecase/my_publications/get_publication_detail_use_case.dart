import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_detail.dart';
import 'package:mobile_table_hopping/domain/repository/my_publications/publication_detail_repository.dart';

/// Use case for retrieving a publication's detailed information.
///
/// This use case encapsulates the business logic for fetching a single
/// publication's details. It delegates to the repository for data retrieval.
///
/// Example:
/// ```dart
/// final result = await getPublicationDetailUseCase('publication-id');
/// result.fold(
///   (error) => print('Failed: ${error.message}'),
///   (detail) => print('Got publication: ${detail.description}'),
/// );
/// ```
@injectable
class GetPublicationDetailUseCase {
  /// Creates the use case with the required repository.
  const GetPublicationDetailUseCase(this._repository);

  final PublicationDetailRepository _repository;

  /// Executes the publication detail retrieval.
  ///
  /// Parameters:
  /// - [id]: The publication ID
  ///
  /// Returns:
  /// - [Right(PublicationDetail)] on success
  /// - [Left(DomainException)] if the operation fails
  Future<Either<DomainException, PublicationDetail>> call(String id) {
    return _repository.getPublicationDetail(id);
  }
}
