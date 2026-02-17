import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/params/rental/confirm_rental_params.dart';
import 'package:mobile_table_hopping/domain/repository/rental/rental_repository.dart';

/// Use case for confirming a rental request.
///
/// This use case encapsulates the business logic for creating a new rental.
/// It validates the input parameters and delegates to the repository.
///
/// Example:
/// ```dart
/// final result = await confirmRentalUseCase(params);
/// result.fold(
///   (error) => print('Failed: ${error.message}'),
///   (_) => print('Success!'),
/// );
/// ```
@injectable
class ConfirmRentalUseCase {
  /// Creates the use case with the required repository.
  const ConfirmRentalUseCase(this._repository);

  final RentalRepository _repository;

  /// Executes the rental confirmation.
  ///
  /// Parameters:
  /// - [params]: The rental confirmation details
  ///
  /// Returns:
  /// - [Right(void)] on successful rental creation
  /// - [Left(DomainException)] if the operation fails
  Future<Either<DomainException, void>> call(ConfirmRentalParams params) {
    return _repository.confirmRental(params);
  }
}
