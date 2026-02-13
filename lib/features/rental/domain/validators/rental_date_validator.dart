import 'package:mobile_table_hopping/core/l10n/app_strings.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';

/// Result of a rental date validation.
class RentalValidationResult {
  /// Creates a validation result.
  const RentalValidationResult({
    required this.isValid,
    this.message,
  });

  /// Whether the validation passed.
  final bool isValid;

  /// Error message if validation failed.
  final String? message;

  /// Success result.
  static const success = RentalValidationResult(isValid: true);
}

/// A pure Dart validator for game rental date ranges.
class RentalDateValidator {
  /// Minimum allowed rental duration in days.
  static const int minDays = 3;

  /// Maximum allowed rental duration in days.
  static const int maxDays = 30;

  /// Validates a rental date range against a publication's availability.
  static RentalValidationResult validate({
    required PublicationListing? publication,
    required String? startDate,
    required String? endDate,
  }) {
    if (publication == null) {
      return const RentalValidationResult(
        isValid: false,
        message: 'No se pudo cargar la información del juego.',
      );
    }

    if (startDate == null || endDate == null) {
      return RentalValidationResult.success;
    }

    final start = DateTime.tryParse(startDate);
    final end = DateTime.tryParse(endDate);

    if (start == null || end == null) {
      return const RentalValidationResult(
        isValid: false,
        message: 'Formato de fecha inválido.',
      );
    }

    // Check minimum duration (3 days)
    final durationInDays = end.difference(start).inDays + 1;
    if (durationInDays < minDays) {
      return const RentalValidationResult(
        isValid: false,
        message: AppStrings.rentalMinDays,
      );
    }

    // Check maximum duration (30 days)
    if (durationInDays > maxDays) {
      return const RentalValidationResult(
        isValid: false,
        message: AppStrings.rentalMaxDays,
      );
    }

    // Check availability
    if (!publication.isAvailableFor(startDate, endDate)) {
      return const RentalValidationResult(
        isValid: false,
        message: AppStrings.rentalUnavailableRange,
      );
    }

    return RentalValidationResult.success;
  }
}
