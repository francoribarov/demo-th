import 'package:dartz/dartz.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';

/// Repository interface for rental request operations.
///
/// Defines the contract for managing rental requests on user's publications.
/// Implementations of this interface handle the actual data fetching and
/// request processing logic.
///
/// Returns [Either<DomainException, T>] to provide explicit error handling:
/// - [Left] contains [DomainException] on failure
/// - [Right] contains the success value
abstract class RentalRequestsRepository {
  /// Retrieves all rental requests for the current user's publications.
  ///
  /// Returns:
  /// - [Right(List<RentalRequest>)] on success
  /// - [Left(DomainException)] if the operation fails
  ///
  /// Possible failures:
  /// - Network errors
  /// - Unauthorized access
  /// - Server errors
  Future<Either<DomainException, List<RentalRequest>>> getRentalRequests();

  /// Accepts a rental request.
  ///
  /// Parameters:
  /// - [id]: The rental request ID to accept
  ///
  /// Returns:
  /// - [Right(void)] on successful acceptance
  /// - [Left(DomainException)] if the operation fails
  ///
  /// Possible failures:
  /// - Network errors
  /// - Request not found
  /// - Unauthorized access (user doesn't own publication)
  /// - Request already processed
  /// - Server errors
  Future<Either<DomainException, void>> acceptRentalRequest(String id);

  /// Rejects a rental request.
  ///
  /// Parameters:
  /// - [id]: The rental request ID to reject
  ///
  /// Returns:
  /// - [Right(void)] on successful rejection
  /// - [Left(DomainException)] if the operation fails
  ///
  /// Possible failures:
  /// - Network errors
  /// - Request not found
  /// - Unauthorized access (user doesn't own publication)
  /// - Request already processed
  /// - Server errors
  Future<Either<DomainException, void>> rejectRentalRequest(String id);
}
