import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/repository/my_publications/rental_requests_repository.dart';

/// Use case for retrieving rental requests for user's publications.
///
/// This use case encapsulates the business logic for fetching all rental
/// requests on publications owned by the current user.
///
/// Example:
/// ```dart
/// final result = await getRentalRequestsUseCase();
/// result.fold(
///   (error) => print('Failed: ${error.message}'),
///   (requests) => print('Got ${requests.length} requests'),
/// );
/// ```
@injectable
class GetRentalRequestsUseCase {
  /// Creates the use case with the required repository.
  const GetRentalRequestsUseCase(this._repository);

  final RentalRequestsRepository _repository;

  /// Executes the rental requests retrieval.
  ///
  /// Returns:
  /// - [Right(List<RentalRequest>)] on success
  /// - [Left(DomainException)] if the operation fails
  Future<Either<DomainException, List<RentalRequest>>> call() {
    return _repository.getRentalRequests();
  }
}
