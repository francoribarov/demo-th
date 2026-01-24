import 'package:meta/meta.dart';

/// Base class for all failures in the application.
@immutable
abstract class Failure {
  /// Creates a [Failure] with a message and optional error code.
  const Failure({required this.message, this.code});

  /// Human-readable error message.
  final String message;

  /// Optional error code from backend or domain.
  final String? code;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure &&
        runtimeType == other.runtimeType &&
        other.message == message &&
        other.code == code;
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);
}

/// Failure produced by server-related errors.
@immutable
class ServerFailure extends Failure {
  /// Creates a [ServerFailure] with optional HTTP status code.
  const ServerFailure({required super.message, super.code, this.statusCode});

  /// HTTP status code returned by the server, if available.
  final int? statusCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServerFailure &&
        super == other &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, statusCode);
}

/// Failure produced by cache-related errors.
class CacheFailure extends Failure {
  /// Creates a [CacheFailure].
  const CacheFailure({required super.message, super.code});
}

/// Failure produced by network connectivity errors.
class NetworkFailure extends Failure {
  /// Creates a [NetworkFailure] with a default offline message.
  const NetworkFailure({
    super.message = 'No hay conexión a internet',
    super.code,
  });
}

/// Failure produced by validation errors.
@immutable
class ValidationFailure extends Failure {
  /// Creates a [ValidationFailure] with optional field errors.
  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
  });

  /// Per-field validation errors when available.
  final Map<String, String>? fieldErrors;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValidationFailure &&
        super == other &&
        _mapEquals(fieldErrors, other.fieldErrors);
  }

  @override
  int get hashCode => Object.hash(super.hashCode, _mapHash(fieldErrors));
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

bool _mapEquals(Map<String, String>? a, Map<String, String>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  for (final entry in a.entries) {
    if (b[entry.key] != entry.value) return false;
  }
  return true;
}

int _mapHash(Map<String, String>? map) {
  if (map == null) return 0;
  final sortedEntries = map.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  return Object.hashAll(
    sortedEntries.map((entry) => Object.hash(entry.key, entry.value)),
  );
}
