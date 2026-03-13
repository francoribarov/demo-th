/// Validator for optional date ranges where both dates must be provided
/// together and end date must be after start date.
class OptionalDateRangeValidator {
  static const String missingPairMessage = 'Ingresá una fecha de inicio y de fin para continuar.';
  static const String invalidOrderMessage = 'La fecha de fin tiene que ser posterior a la de inicio.';

  /// Returns null when valid, or an error message otherwise.
  static String? validate({
    required String? startDate,
    required String? endDate,
  }) {
    final hasStart = startDate != null && startDate.isNotEmpty;
    final hasEnd = endDate != null && endDate.isNotEmpty;

    if ((hasStart && !hasEnd) || (!hasStart && hasEnd)) {
      return missingPairMessage;
    }

    if (hasStart && hasEnd) {
      final parsedStart = DateTime.tryParse(startDate);
      final parsedEnd = DateTime.tryParse(endDate);
      if (parsedStart != null && parsedEnd != null && !parsedEnd.isAfter(parsedStart)) {
        return invalidOrderMessage;
      }
    }

    return null;
  }
}
