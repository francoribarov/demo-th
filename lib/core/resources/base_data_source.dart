import 'package:dio/dio.dart';
import 'package:mobile_table_hopping/core/errors/data/data_exception.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';

/// Abstract base class for all remote data sources.
///
/// [BaseDataSource] provides a common pattern for executing HTTP requests
/// and wrapping them in [ApiResult]. This ensures consistent error handling
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
///   Future<ApiResult<UserDto>> getUser(String id) {
///     return getStateOf<UserDto>(
///       request: () => _service.getUser(id),
///     );
///   }
/// }
/// ```
abstract class BaseDataSource {
  /// Executes a request and wraps the result in [ApiResult].
  ///
  /// This method:
  /// 1. Executes the provided request function
  /// 2. On success, wraps the result in [ApiResult.success]
  /// 3. On [DioException], converts it to [DataException] and wraps in [ApiResult.failure]
  ///
  /// Type parameters:
  /// - [T]: The expected return type of the request
  ///
  /// Parameters:
  /// - [request]: A function that returns a `Future<T>` representing the HTTP call
  ///
  /// Returns an [ApiResult<T>] containing either the successful data or an error.
  Future<ApiResult<T>> getStateOf<T>({
    required Future<T> Function() request,
  }) async {
    try {
      final response = await request();
      return ApiResult.success(data: response);
    } on DioException catch (e) {
      return ApiResult.failure(dataException: DataException.fromDioError(e));
    } on FormatException catch (e) {
      return ApiResult.failure(
        dataException: DataException(
          message: _normalizeExceptionMessage(
            e.message,
            fallback: 'Failed to parse server response.',
          ),
        ),
      );
    } on Exception catch (e) {
      return ApiResult.failure(
        dataException: DataException(
          message: _normalizeExceptionMessage(
            e.toString(),
            fallback: 'An unexpected error occurred while processing request.',
          ),
        ),
      );
    } on Object catch (e) {
      if (e is TypeError) {
        return ApiResult.failure(
          dataException: DataException(
            message: _normalizeExceptionMessage(
              e.toString(),
              fallback: 'Unexpected response type from server.',
            ),
          ),
        );
      }
      return ApiResult.failure(
        dataException: DataException(
          message: _normalizeExceptionMessage(
            e.toString(),
            fallback: 'An unexpected error occurred while processing request.',
          ),
        ),
      );
    }
  }

  String _normalizeExceptionMessage(
    String? rawMessage, {
    required String fallback,
  }) {
    final message = rawMessage?.trim();
    if (message == null || message.isEmpty) return fallback;
    return message;
  }
}
