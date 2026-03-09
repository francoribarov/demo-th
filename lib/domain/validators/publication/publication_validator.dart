/// Typed validation errors for publication description.
enum PublicationDescriptionError { required, tooShort }

/// Typed validation errors for publication condition.
enum PublicationConditionError { required }

/// Typed validation errors for publication price.
enum PublicationPriceError { mustBePositive }

/// Centralized validator for publication data.
class PublicationValidator {
  /// Validates description and returns a typed error when invalid.
  static PublicationDescriptionError? validateDescription(String description) {
    if (description.trim().isEmpty) {
      return PublicationDescriptionError.required;
    }
    if (description.trim().length < 10) {
      return PublicationDescriptionError.tooShort;
    }
    return null;
  }

  /// Validates condition selection and returns a typed error when invalid.
  static PublicationConditionError? validateCondition<T extends Enum>(
    T? condition,
  ) {
    if (condition == null) {
      return PublicationConditionError.required;
    }
    return null;
  }

  /// Validates price and returns a typed error when invalid.
  static PublicationPriceError? validatePricing(int price) {
    if (price <= 0) {
      return PublicationPriceError.mustBePositive;
    }
    return null;
  }
}
