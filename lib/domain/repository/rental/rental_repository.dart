import 'package:dartz/dartz.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/params/rental/confirm_rental_params.dart';

/// Repository interface for rental operations.
///
/// Defines the contract for rental-related data operations. Implementations
/// of this interface handle the actual data fetching and persistence logic.
///
/// Returns [Either<DomainException, T>] to provide explicit error handling:
/// - [Left] contains [DomainException] on failure
/// - [Right] contains the success value
abstract class RentalRepository {
  /// Confirms a rental request.
  ///
  /// Attempts to create a new rental with the provided parameters.
  ///
  /// Parameters:
  /// - [params]: The rental confirmation details
  ///
  /// Returns:
  /// - [Right(void)] on successful rental creation
  /// - [Left(DomainException)] if the operation fails
  ///
  /// Possible failures:
  /// - Network errors
  /// - Validation errors
  /// - Unauthorized access
  /// - Server errors
  Future<Either<DomainException, void>> confirmRental(
    ConfirmRentalParams params,
  );
}
