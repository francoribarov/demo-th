/// Result of validating a date range.
class DateRangeValidationResult {
  /// Creates a validation result.
  const DateRangeValidationResult({required this.isValid, this.message});

  /// Whether the range is valid.
  final bool isValid;

  /// Error message when invalid.
  final String? message;
}

/// Shared date range rules used across presentation flows.
class DateRangeValidator {
  DateRangeValidator._();

  /// Minimum rental duration (inclusive days).
  static const int minRentalDays = 3;

  /// Maximum rental duration (inclusive days).
  static const int maxRentalDays = 30;

  /// Date pickers allow selection up to this many days ahead.
  static const int bookingWindowDays = 365;

  /// Returns current day without time component.
  static DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Validates ISO `yyyy-MM-dd` start/end range.
  static DateRangeValidationResult validateIsoRange({
    required String startDate,
    required String endDate,
    int minDays = minRentalDays,
    int maxDays = maxRentalDays,
  }) {
    final start = DateTime.tryParse(startDate);
    final end = DateTime.tryParse(endDate);

    if (start == null || end == null) {
      return const DateRangeValidationResult(
        isValid: false,
        message: 'Formato de fecha inválido.',
      );
    }

    if (end.isBefore(start)) {
      return const DateRangeValidationResult(
        isValid: false,
        message: 'La fecha de fin tiene que ser posterior a la de inicio.',
      );
    }

    final durationInDays = end.difference(start).inDays + 1;
    if (durationInDays < minDays) {
      return DateRangeValidationResult(
        isValid: false,
        message: 'El alquiler mínimo es de $minDays días.',
      );
    }

    if (durationInDays > maxDays) {
      return DateRangeValidationResult(
        isValid: false,
        message: 'El alquiler máximo es de $maxDays días.',
      );
    }

    return const DateRangeValidationResult(isValid: true);
  }
}
