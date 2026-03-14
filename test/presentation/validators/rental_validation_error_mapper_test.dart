import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/validators/rental/rental_validator.dart';
import 'package:mobile_table_hopping/presentation/validators/rental_validation_error_mapper.dart';

void main() {
  group('RentalValidationErrorMapper', () {
    test('maps null to null', () {
      expect(RentalValidationErrorMapper.mapDateError(null), isNull);
    });

    test('maps each error to a non-empty message', () {
      for (final error in RentalDateError.values) {
        final message = RentalValidationErrorMapper.mapDateError(error);
        expect(message, isNotNull);
        expect(message, isNotEmpty);
      }
    });

    test('maps unavailablePublication', () {
      expect(
        RentalValidationErrorMapper.mapDateError(
          RentalDateError.unavailablePublication,
        ),
        'No se pudo cargar la información del juego.',
      );
    });

    test('maps belowMinimumDays', () {
      expect(
        RentalValidationErrorMapper.mapDateError(
          RentalDateError.belowMinimumDays,
        ),
        'El alquiler mínimo es de 3 días (ej: Lun a Jue).',
      );
    });

    test('maps aboveMaximumDays', () {
      expect(
        RentalValidationErrorMapper.mapDateError(
          RentalDateError.aboveMaximumDays,
        ),
        'El alquiler no puede superar los 30 días.',
      );
    });
  });
}
