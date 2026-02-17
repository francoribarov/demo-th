import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/repository/my_publications/rental_requests_repository.dart';

/// Use case for rejecting a rental request.
///
/// This use case encapsulates the business logic for denying a rental
/// request on the user's publication. It delegates to the repository.
///
/// Example:
/// ```dart
/// final result = await rejectRentalRequestUseCase('request-id');
/// result.fold(
///   (error) => print('Failed: ${error.message}'),
///   (_) => print('Rejected successfully'),
/// );
/// ```
@injectable
class RejectRentalRequestUseCase {
  /// Creates the use case with the required repository.
  const RejectRentalRequestUseCase(this._repository);

  final RentalRequestsRepository _repository;

  /// Executes the rental request rejection.
  ///
  /// Parameters:
  /// - [id]: The rental request ID to reject
  ///
  /// Returns:
  /// - [Right(void)] on successful rejection
  /// - [Left(DomainException)] if the operation fails
  Future<Either<DomainException, void>> call(String id) {
    return _repository.rejectRentalRequest(id);
  }
}
