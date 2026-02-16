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
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return DataException(
          message: 'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.badResponse:
        return _fromBadResponse(error);
      case DioExceptionType.connectionError:
        return DataException(
          message: 'No internet connection. Please check your network.',
        );
      case DioExceptionType.cancel:
        return DataException(message: 'Request was cancelled');
      case DioExceptionType.badCertificate:
        return DataException(message: 'Invalid SSL certificate');
      case DioExceptionType.unknown:
        return _fromUnknown(error);
    }
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

DataException _fromBadResponse(DioException error) {
  final statusCode = error.response?.statusCode;
  final data = error.response?.data;
  final extractedMessage = _extractErrorMessage(data);

  if (statusCode == 401 || statusCode == 403) {
    return DataException(
      message: extractedMessage ?? 'Unauthorized access',
      statusCode: statusCode,
      data: data,
    );
  }

  if (statusCode == 422) {
    return DataException(
      message: extractedMessage ?? 'Validation error',
      statusCode: statusCode,
      data: data,
    );
  }

  if (statusCode != null && statusCode >= 500) {
    return DataException(
      message: extractedMessage ?? 'Server error occurred',
      statusCode: statusCode,
      data: data,
    );
  }

  return DataException(
    message: extractedMessage ?? 'Request failed',
    statusCode: statusCode,
    data: data,
  );
}

DataException _fromUnknown(DioException error) {
  if (error.error is Exception && error.error.toString().contains('SocketException')) {
    return DataException(message: 'No internet connection');
  }

  if (error.message?.contains('SocketException') ?? false) {
    return DataException(message: 'No internet connection');
  }

  final data = error.response?.data;
  return DataException(
    message: _extractErrorMessage(data) ?? 'An unexpected error occurred',
    statusCode: error.response?.statusCode,
    data: data,
  );
}

String? _extractErrorMessage(dynamic data) {
  if (data is! Map) return null;

  final message = data['message']?.toString();
  if (message != null && message.trim().isNotEmpty) {
    return message;
  }

  final error = data['error']?.toString();
  if (error != null && error.trim().isNotEmpty) {
    return error;
  }

  final fault = data['fault'];
  if (fault is Map) {
    final faultString = fault['faultstring']?.toString();
    if (faultString != null && faultString.trim().isNotEmpty) {
      return faultString;
    }
  }

  return null;
}
