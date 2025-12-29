import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
abstract class Failure extends Equatable {
  /// Creates a [Failure] with a message and optional error code.
  const Failure({required this.message, this.code});

  /// Human-readable error message.
  final String message;

  /// Optional error code from backend or domain.
  final String? code;

  /// Properties used to compare failures with [Equatable].
  @override
  List<Object?> get props => [message, code];
}

/// Failure produced by server-related errors.
class ServerFailure extends Failure {
  /// Creates a [ServerFailure] with optional HTTP status code.
  const ServerFailure({required super.message, super.code, this.statusCode});

  /// HTTP status code returned by the server, if available.
  final int? statusCode;

  /// Properties used to compare failures with [Equatable].
  @override
  List<Object?> get props => [message, code, statusCode];
}

/// Failure produced by cache-related errors.
class CacheFailure extends Failure {
  /// Creates a [CacheFailure].
  const CacheFailure({required super.message, super.code});
}

/// Failure produced by network connectivity errors.
class NetworkFailure extends Failure {
  /// Creates a [NetworkFailure] with a default offline message.
  const NetworkFailure({super.message = 'No hay conexión a internet', super.code});
}

/// Failure produced by validation errors.
class ValidationFailure extends Failure {
  /// Creates a [ValidationFailure] with optional field errors.
  const ValidationFailure({required super.message, super.code, this.fieldErrors});

  /// Per-field validation errors when available.
  final Map<String, String>? fieldErrors;

  /// Properties used to compare failures with [Equatable].
  @override
  List<Object?> get props => [message, code, fieldErrors];
}

/// Failure produced when a resource is not found.
class NotFoundFailure extends Failure {
  /// Creates a [NotFoundFailure] with a default message.
  const NotFoundFailure({super.message = 'Recurso no encontrado', super.code});
}

/// Failure produced when authorization is missing or invalid.
class UnauthorizedFailure extends Failure {
  /// Creates an [UnauthorizedFailure] with a default message.
  const UnauthorizedFailure({super.message = 'No autorizado', super.code});
}
