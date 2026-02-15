import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/core/resources/data_state.dart';
import 'package:mobile_table_hopping/data/dto/rental/confirm_rental_body.dart';
import 'package:mobile_table_hopping/data/services/rental/rental_service.dart';

/// Remote datasource contract for rental operations.
///
/// Defines the interface for rental-related data operations that interact
/// with remote APIs.
abstract class RentalRemoteDataSource {
  /// Creates a new rental request on the server.
  ///
  /// Parameters:
  /// - [body]: The rental confirmation request data
  ///
  /// Returns:
  /// - [DataState.success] if the rental was created successfully
  /// - [DataState.failed] with error details if the operation failed
  Future<DataState<void>> createRental(ConfirmRentalBody body);
}

/// Implementation of [RentalRemoteDataSource] using Retrofit service.
///
/// This class extends [BaseDataSource] to leverage the standard
/// error handling and [DataState] wrapping pattern.
///
/// Example:
/// ```dart
/// final result = await dataSource.createRental(body);
/// result.when(
///   success: (_) => print('Rental created'),
///   failed: (error) => print('Error: ${error.message}'),
/// );
/// ```
@LazySingleton(as: RentalRemoteDataSource)
class RentalRemoteDataSourceImpl extends BaseDataSource
    implements RentalRemoteDataSource {
  /// Creates a data source with the provided Retrofit service.
  RentalRemoteDataSourceImpl(this._service);

  final RentalService _service;

  @override
  Future<DataState<void>> createRental(ConfirmRentalBody body) {
    return getStateOf<void>(
      request: () => _service.createRental(body),
    );
  }
}
