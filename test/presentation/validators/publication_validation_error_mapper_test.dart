import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/validators/publication/publication_validator.dart';
import 'package:mobile_table_hopping/presentation/validators/publication_validation_error_mapper.dart';

void main() {
  group('PublicationValidationErrorMapper', () {
    test('maps each description error to a non-empty message', () {
      for (final error in PublicationDescriptionError.values) {
        final message = PublicationValidationErrorMapper.mapDescriptionError(
          error,
        );
        expect(message, isNotNull);
        expect(message, isNotEmpty);
      }
    });

    test('maps each condition error to a non-empty message', () {
      for (final error in PublicationConditionError.values) {
        final message = PublicationValidationErrorMapper.mapConditionError(
          error,
        );
        expect(message, isNotNull);
        expect(message, isNotEmpty);
      }
    });

    test('maps each price error to a non-empty message', () {
      for (final error in PublicationPriceError.values) {
        final message = PublicationValidationErrorMapper.mapPriceError(error);
        expect(message, isNotNull);
        expect(message, isNotEmpty);
      }
    });

    group('mapDescriptionError', () {
      test('returns message for required', () {
        expect(
          PublicationValidationErrorMapper.mapDescriptionError(
            PublicationDescriptionError.required,
          ),
          'La descripción es obligatoria.',
        );
      });

      test('returns message for tooShort', () {
        expect(
          PublicationValidationErrorMapper.mapDescriptionError(
            PublicationDescriptionError.tooShort,
          ),
          'La descripción debe ser más detallada (min 10 caracteres).',
        );
      });

      test('returns null when error is null', () {
        expect(
          PublicationValidationErrorMapper.mapDescriptionError(null),
          isNull,
        );
      });
    });

    group('mapConditionError', () {
      test('returns message for required', () {
        expect(
          PublicationValidationErrorMapper.mapConditionError(
            PublicationConditionError.required,
          ),
          'Debes seleccionar el estado del juego',
        );
      });

      test('returns null when error is null', () {
        expect(
          PublicationValidationErrorMapper.mapConditionError(null),
          isNull,
        );
      });
    });

    group('mapPriceError', () {
      test('returns message for mustBePositive', () {
        expect(
          PublicationValidationErrorMapper.mapPriceError(
            PublicationPriceError.mustBePositive,
          ),
          'El precio debe ser mayor a 0.',
        );
      });

      test('returns null when error is null', () {
        expect(
          PublicationValidationErrorMapper.mapPriceError(null),
          isNull,
        );
      });
    });
  });
}
