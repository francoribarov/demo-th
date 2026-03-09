import 'package:mobile_table_hopping/domain/validators/publication/publication_validator.dart';

/// Maps typed publication validation errors into existing UI messages.
class PublicationValidationErrorMapper {
  static String? mapDescriptionError(PublicationDescriptionError? error) {
    return switch (error) {
      PublicationDescriptionError.required => 'La descripción es obligatoria.',
      PublicationDescriptionError.tooShort => 'La descripción debe ser más detallada (min 10 caracteres).',
      null => null,
    };
  }

  static String? mapConditionError(PublicationConditionError? error) {
    return switch (error) {
      PublicationConditionError.required => 'Debes seleccionar el estado del juego',
      null => null,
    };
  }

  static String? mapPriceError(PublicationPriceError? error) {
    return switch (error) {
      PublicationPriceError.mustBePositive => 'El precio debe ser mayor a 0.',
      null => null,
    };
  }
}
