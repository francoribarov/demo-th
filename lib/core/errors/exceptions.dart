/// Base exception class for app-specific errors.
abstract class AppException implements Exception {
  /// Creates an [AppException] with a message and optional error code.
  const AppException({required this.message, this.code});

  /// Human-readable error message.
  final String message;

  /// Optional error code from backend or domain.
  final String? code;

  /// Returns a debug-friendly representation of the exception.
  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Exception thrown for server-related errors.
class ServerException extends AppException {
  /// Creates a [ServerException] with optional HTTP status code.
  const ServerException({required super.message, super.code, this.statusCode});

  /// HTTP status code returned by the server, if available.
  final int? statusCode;

  /// Returns a debug-friendly representation of the exception.
  @override
  String toString() => 'ServerException: $message (statusCode: $statusCode, code: $code)';
}

/// Exception thrown for cache-related errors.
class CacheException extends AppException {
  /// Creates a [CacheException].
  const CacheException({required super.message, super.code});

  /// Returns a debug-friendly representation of the exception.
  @override
  String toString() => 'CacheException: $message (code: $code)';
}

/// Exception thrown for network connectivity errors.
class NetworkException extends AppException {
  /// Creates a [NetworkException] with a default offline message.
  const NetworkException({super.message = 'No hay conexión a internet', super.code});

  /// Returns a debug-friendly representation of the exception.
  @override
  String toString() => 'NetworkException: $message';
}

/// Exception thrown for validation errors.
class ValidationException extends AppException {
  /// Creates a [ValidationException] with optional field errors.
  const ValidationException({required super.message, super.code, this.fieldErrors});

  /// Per-field validation errors when available.
  final Map<String, String>? fieldErrors;

  /// Returns a debug-friendly representation of the exception.
  @override
  String toString() => 'ValidationException: $message (fieldErrors: $fieldErrors)';
}

/// Exception thrown when a resource is not found.
class NotFoundException extends AppException {
  /// Creates a [NotFoundException] with a default message.
  const NotFoundException({super.message = 'Recurso no encontrado', super.code});

  /// Returns a debug-friendly representation of the exception.
  @override
  String toString() => 'NotFoundException: $message';
}
