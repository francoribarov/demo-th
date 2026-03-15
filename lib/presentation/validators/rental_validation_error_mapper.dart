import 'package:mobile_table_hopping/domain/validators/rental/rental_validator.dart';

/// Maps typed rental validation errors into UI messages.
class RentalValidationErrorMapper {
  static String? mapDateError(RentalDateError? error) {
    return switch (error) {
      RentalDateError.unavailablePublication =>
        'No se pudo cargar la información del juego.',
      RentalDateError.invalidFormat => 'Formato de fecha inválido.',
      RentalDateError.belowMinimumDays =>
        'El alquiler mínimo es de 3 días (ej: Lun a Jue).',
      RentalDateError.aboveMaximumDays =>
        'El alquiler no puede superar los 30 días.',
      RentalDateError.unavailableDates =>
        'Las fechas seleccionadas no están disponibles en su totalidad.',
      null => null,
    };
  }
}
