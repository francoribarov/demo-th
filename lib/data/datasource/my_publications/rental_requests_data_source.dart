import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/data/dto/my_publications/rental_request_model.dart';
import 'package:mobile_table_hopping/data/services/my_publications/rental_requests_service.dart';

/// Remote datasource contract for rental requests operations.
///
/// Defines the interface for rental requests-related data operations
/// that interact with remote APIs.
abstract class RentalRequestsRemoteDataSource {
  /// Retrieves all rental requests for the current user's publications.
  ///
  /// Returns:
  /// - [ApiResult.success] with list of rental request models if successful
  /// - [ApiResult.failure] with error details if the operation failed
  Future<ApiResult<List<RentalRequestModel>>> getRentalRequests();

  /// Accepts a rental request.
  ///
  /// Parameters:
  /// - [id]: The rental request ID
  ///
  /// Returns:
  /// - [ApiResult.success] if the request was accepted successfully
  /// - [ApiResult.failure] with error details if the operation failed
  Future<ApiResult<void>> acceptRentalRequest(String id);

  /// Rejects a rental request.
  ///
  /// Parameters:
  /// - [id]: The rental request ID
  ///
  /// Returns:
  /// - [ApiResult.success] if the request was rejected successfully
  /// - [ApiResult.failure] with error details if the operation failed
  Future<ApiResult<void>> rejectRentalRequest(String id);
}

/// Implementation of [RentalRequestsRemoteDataSource] using Retrofit service.
///
/// This class extends [BaseDataSource] to leverage the standard
/// error handling and [ApiResult] wrapping pattern.
///
/// Example:
/// ```dart
/// final result = await dataSource.getRentalRequests();
/// result.when(
///   success: (requests) => print('Got ${requests.length} requests'),
///   failed: (error) => print('Error: ${error.message}'),
/// );
/// ```
@LazySingleton(as: RentalRequestsRemoteDataSource)
class RentalRequestsRemoteDataSourceImpl extends BaseDataSource
    implements RentalRequestsRemoteDataSource {
  /// Creates a data source with the provided Retrofit service.
  RentalRequestsRemoteDataSourceImpl(this._service);

  final RentalRequestsService _service;

  @override
  Future<ApiResult<List<RentalRequestModel>>> getRentalRequests() {
    return getStateOf<List<RentalRequestModel>>(
      request: _service.getRentalRequests,
    );
  }

  @override
  Future<ApiResult<void>> acceptRentalRequest(String id) {
    return getStateOf<void>(
      request: () => _service.acceptRentalRequest(id),
    );
  }

  @override
  Future<ApiResult<void>> rejectRentalRequest(String id) {
    return getStateOf<void>(
      request: () => _service.rejectRentalRequest(id),
    );
  }
}
