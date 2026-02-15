/// Domain layer exception representing business logic and data errors.
///
/// [DomainException] is used in the domain layer to represent errors in a
/// way that's independent of the data layer implementation. It provides
/// clean, user-friendly error information.
///
/// This exception is typically used in [Either<DomainException, T>] return
/// types from use cases and repositories.
///
/// Example:
/// ```dart
/// Future<Either<DomainException, User>> getUser(String id) async {
///   final result = await _dataSource.fetchUser(id);
///   return result.when(
///     success: (data) => Right(data),
///     failed: (error) => Left(error.toDomainException()),
///   );
/// }
/// ```
class DomainException implements Exception {
  /// Creates a domain exception with the given message and optional status code.
  const DomainException({
    required this.message,
    this.statusCode,
  });

  /// Creates a generic server error.
  factory DomainException.serverError() {
    return const DomainException(
      message: 'Server error occurred. Please try again later.',
      statusCode: 500,
    );
  }

  /// Creates a network connectivity error.
  factory DomainException.networkError() {
    return const DomainException(
      message: 'No internet connection. Please check your network.',
    );
  }

  /// Creates an unauthorized error (typically 401).
  factory DomainException.unauthorized() {
    return const DomainException(
      message: 'Your session has expired. Please log in again.',
      statusCode: 401,
    );
  }

  /// Creates a forbidden error (typically 403).
  factory DomainException.forbidden() {
    return const DomainException(
      message: 'You do not have permission to perform this action.',
      statusCode: 403,
    );
  }

  /// Creates a not found error (typically 404).
  factory DomainException.notFound() {
    return const DomainException(
      message: 'The requested resource was not found.',
      statusCode: 404,
    );
  }

  /// Human-readable error message suitable for display to users.
  final String message;

  /// HTTP status code (if applicable) for additional context.
  final int? statusCode;

  @override
  String toString() =>
      'DomainException(message: $message, statusCode: $statusCode)';
}
