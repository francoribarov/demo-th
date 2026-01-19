/// Result of a publication validation.
class PublicationValidationResult {
  /// Creates a validation result.
  const PublicationValidationResult({required this.isValid, this.message});

  /// Whether the publication data is valid.
  final bool isValid;

  /// Error message if the data is invalid.
  final String? message;
}

/// Centralized validator for the game publishing flow.
class PublicationValidator {
  /// Validates the description step.
  static PublicationValidationResult validateDescription(String description) {
    if (description.trim().isEmpty) {
      return const PublicationValidationResult(
        isValid: false,
        message: 'La descripción es obligatoria.',
      );
    }
    if (description.trim().length < 10) {
      return const PublicationValidationResult(
        isValid: false,
        message: 'La descripción debe ser más detallada (min 10 car.).',
      );
    }
    return const PublicationValidationResult(isValid: true);
  }

  /// Validates the price.
  static PublicationValidationResult validatePricing(int price) {
    if (price <= 0) {
      return const PublicationValidationResult(
        isValid: false,
        message: 'El precio debe ser mayor a 0.',
      );
    }
    return const PublicationValidationResult(isValid: true);
  }
}
