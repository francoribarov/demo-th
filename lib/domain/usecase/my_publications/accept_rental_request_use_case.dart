import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/repository/my_publications/rental_requests_repository.dart';

/// Use case for accepting a rental request.
///
/// This use case encapsulates the business logic for approving a rental
/// request on the user's publication. It delegates to the repository.
///
/// Example:
/// ```dart
/// final result = await acceptRentalRequestUseCase('request-id');
/// result.fold(
///   (error) => print('Failed: ${error.message}'),
///   (_) => print('Accepted successfully'),
/// );
/// ```
@injectable
class AcceptRentalRequestUseCase {
  /// Creates the use case with the required repository.
  const AcceptRentalRequestUseCase(this._repository);

  final RentalRequestsRepository _repository;

  /// Executes the rental request acceptance.
  ///
  /// Parameters:
  /// - [id]: The rental request ID to accept
  ///
  /// Returns:
  /// - [Right(void)] on successful acceptance
  /// - [Left(DomainException)] if the operation fails
  Future<Either<DomainException, void>> call(String id) {
    return _repository.acceptRentalRequest(id);
  }
}
