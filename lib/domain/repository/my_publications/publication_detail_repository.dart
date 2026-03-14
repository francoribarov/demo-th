import 'package:dartz/dartz.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_detail.dart';
import 'package:mobile_table_hopping/domain/params/my_publications/update_publication_params.dart';

/// Repository interface for publication detail operations.
///
/// Defines the contract for managing individual publication details.
/// Implementations of this interface handle the actual data fetching,
/// update, and deletion logic.
///
/// Returns [Either<DomainException, T>] to provide explicit error handling:
/// - [Left] contains [DomainException] on failure
/// - [Right] contains the success value
abstract class PublicationDetailRepository {
  /// Retrieves detailed information about a specific publication.
  ///
  /// Parameters:
  /// - [id]: The publication ID
  ///
  /// Returns:
  /// - [Right(PublicationDetail)] on success
  /// - [Left(DomainException)] if the operation fails
  ///
  /// Possible failures:
  /// - Network errors
  /// - Publication not found
  /// - Unauthorized access
  /// - Server errors
  Future<Either<DomainException, PublicationDetail>> getPublicationDetail(
    String id,
  );

  /// Updates an existing publication.
  ///
  /// Parameters:
  /// - [params]: The update parameters (includes publication ID and fields to update)
  ///
  /// Returns:
  /// - [Right(PublicationDetail)] with updated publication on success
  /// - [Left(DomainException)] if the operation fails
  ///
  /// Possible failures:
  /// - Network errors
  /// - Validation errors
  /// - Publication not found
  /// - Unauthorized access (user doesn't own publication)
  /// - Server errors
  Future<Either<DomainException, PublicationDetail>> updatePublication(
    UpdatePublicationParams params,
  );

  /// Deletes a publication.
  ///
  /// Parameters:
  /// - [id]: The publication ID to delete
  ///
  /// Returns:
  /// - [Right(void)] on successful deletion
  /// - [Left(DomainException)] if the operation fails
  ///
  /// Possible failures:
  /// - Network errors
  /// - Publication not found
  /// - Unauthorized access (user doesn't own publication)
  /// - Server errors
  Future<Either<DomainException, void>> deletePublication(String id);
}
