import 'package:dio/dio.dart';

/// Data layer exception that wraps HTTP/network errors.
///
/// [DataException] is used in the data layer to represent errors from
/// external sources (APIs, databases, etc.). It provides structured error
/// information that can be converted to domain-layer exceptions.
///
/// Example:
/// ```dart
/// try {
///   final response = await dio.get('/users');
/// } on DioException catch (e) {
///   throw DataException.fromDioError(e);
/// }
/// ```
class DataException implements Exception {
  /// Creates a data exception with the given message and optional details.
  DataException({
    required this.message,
    this.statusCode,
    this.data,
  });

  /// Creates a [DataException] from a Dio HTTP error.
  ///
  /// This factory maps different [DioExceptionType] values to appropriate
  /// error messages and extracts status codes and response data.
  factory DataException.fromDioError(DioException error) {
    String message;
    int? statusCode;
    dynamic data;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        statusCode = error.response?.statusCode;
        data = error.response?.data;

        // Try to extract error message from response
        if (data is Map) {
          message = data['message'] as String? ??
              data['error'] as String? ??
              'Server error occurred';
        } else {
          message = 'Server error occurred';
        }
      case DioExceptionType.cancel:
        message = 'Request was cancelled';
      case DioExceptionType.connectionError:
        message = 'No internet connection. Please check your network.';
      case DioExceptionType.badCertificate:
        message = 'Invalid SSL certificate';
      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          message = 'No internet connection';
        } else {
          message = 'An unexpected error occurred';
        }
    }

    return DataException(
      message: message,
      statusCode: statusCode,
      data: data,
    );
  }

  /// Human-readable error message.
  final String message;

  /// HTTP status code (if applicable).
  final int? statusCode;

  /// Additional error data from the server response.
  final dynamic data;

  @override
  String toString() =>
      'DataException(message: $message, statusCode: $statusCode)';
}
