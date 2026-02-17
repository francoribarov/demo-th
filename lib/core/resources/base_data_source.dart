import 'package:dio/dio.dart';
import 'package:mobile_table_hopping/core/errors/data/data_exception.dart';
import 'package:mobile_table_hopping/core/resources/data_state.dart';

/// Abstract base class for all remote data sources.
///
/// [BaseDataSource] provides a common pattern for executing HTTP requests
/// and wrapping them in [DataState]. This ensures consistent error handling
/// across all data sources.
///
/// Extend this class in your data source implementations:
///
/// Example:
/// ```dart
/// @injectable
/// class UserRemoteDataSourceImpl extends BaseDataSource
///     implements UserRemoteDataSource {
///   UserRemoteDataSourceImpl(this._service);
///
///   final UserService _service;
///
///   @override
///   Future<DataState<UserDto>> getUser(String id) {
///     return getStateOf<UserDto>(
///       request: () => _service.getUser(id),
///     );
///   }
/// }
/// ```
abstract class BaseDataSource {
  /// Executes a request and wraps the result in [DataState].
  ///
  /// This method:
  /// 1. Executes the provided request function
  /// 2. On success, wraps the result in [DataState.success]
  /// 3. On [DioException], converts it to [DataException] and wraps in [DataState.failed]
  ///
  /// Type parameters:
  /// - [T]: The expected return type of the request
  ///
  /// Parameters:
  /// - [request]: A function that returns a `Future<T>` representing the HTTP call
  ///
  /// Returns a [DataState<T>] containing either the successful data or an error.
  Future<DataState<T>> getStateOf<T>({
    required Future<T> Function() request,
  }) async {
    try {
      final response = await request();
      return DataState.success(response);
    } on DioException catch (e) {
      return DataState.failed(DataException.fromDioError(e));
    }
  }
}
