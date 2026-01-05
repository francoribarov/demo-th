/// Result of a listing validation.
class ListingValidationResult {
  /// Creates a validation result.
  const ListingValidationResult({required this.isValid, this.message});

  /// Whether the listing data is valid.
  final bool isValid;

  /// Error message if the data is invalid.
  final String? message;
}

/// Centralized validator for the game publishing flow.
class ListingValidator {
  /// Validates the first step: title and description.
  static ListingValidationResult validateBasics({
    required String title,
    required String description,
  }) {
    if (title.trim().isEmpty) {
      return const ListingValidationResult(
        isValid: false,
        message: 'El título es obligatorio.',
      );
    }
    if (title.trim().length < 3) {
      return const ListingValidationResult(
        isValid: false,
        message: 'El título debe tener al menos 3 caracteres.',
      );
    }
    if (description.trim().isEmpty) {
      return const ListingValidationResult(
        isValid: false,
        message: 'La descripción es obligatoria.',
      );
    }
    if (description.trim().length < 10) {
      return const ListingValidationResult(
        isValid: false,
        message: 'La descripción debe ser más detallada (min 10 car.).',
      );
    }
    return const ListingValidationResult(isValid: true);
  }

  /// Validates the price and deposit step.
  static ListingValidationResult validatePricing({
    required int pricePerDay,
    required int deposit,
  }) {
    if (pricePerDay <= 0) {
      return const ListingValidationResult(
        isValid: false,
        message: 'El precio debe ser mayor a 0.',
      );
    }
    if (deposit < 0) {
      return const ListingValidationResult(
        isValid: false,
        message: 'La seña no puede ser negativa.',
      );
    }
    return const ListingValidationResult(isValid: true);
  }
}
