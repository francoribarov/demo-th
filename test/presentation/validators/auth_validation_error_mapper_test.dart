import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/validators/auth/auth_validator.dart';
import 'package:mobile_table_hopping/presentation/validators/auth_validation_error_mapper.dart';

void main() {
  group('AuthValidationErrorMapper', () {
    group('mapEmailError', () {
      test('returns message for required', () {
        expect(
          AuthValidationErrorMapper.mapEmailError(AuthEmailError.required),
          'Ingresá tu email.',
        );
      });

      test('returns message for invalidFormat', () {
        expect(
          AuthValidationErrorMapper.mapEmailError(
            AuthEmailError.invalidFormat,
          ),
          'Ingresá un email válido.',
        );
      });

      test('returns null when error is null', () {
        expect(
          AuthValidationErrorMapper.mapEmailError(null),
          isNull,
        );
      });
    });

    group('mapPasswordError', () {
      test('returns default empty message', () {
        expect(
          AuthValidationErrorMapper.mapPasswordError(
            AuthPasswordError.required,
          ),
          'Ingresá tu contraseña.',
        );
      });

      test('returns message for tooShort', () {
        expect(
          AuthValidationErrorMapper.mapPasswordError(
            AuthPasswordError.tooShort,
          ),
          contains('8 caracteres'),
        );
      });

      test('returns custom emptyMessage when provided', () {
        expect(
          AuthValidationErrorMapper.mapPasswordError(
            AuthPasswordError.required,
            emptyMessage: 'Custom empty',
          ),
          'Custom empty',
        );
      });

      test('returns null when error is null', () {
        expect(
          AuthValidationErrorMapper.mapPasswordError(null),
          isNull,
        );
      });
    });

    group('mapUsernameError', () {
      test('returns message for required', () {
        expect(
          AuthValidationErrorMapper.mapUsernameError(
            AuthUsernameError.required,
          ),
          'Ingresá tu nombre.',
        );
      });

      test('returns null when error is null', () {
        expect(
          AuthValidationErrorMapper.mapUsernameError(null),
          isNull,
        );
      });
    });

    group('mapPasswordConfirmationError', () {
      test('returns message for required', () {
        expect(
          AuthValidationErrorMapper.mapPasswordConfirmationError(
            AuthPasswordConfirmationError.required,
          ),
          'Repetí tu contraseña para continuar.',
        );
      });

      test('returns message for mismatch', () {
        expect(
          AuthValidationErrorMapper.mapPasswordConfirmationError(
            AuthPasswordConfirmationError.mismatch,
          ),
          'Las contraseñas no coinciden.',
        );
      });

      test('returns null when error is null', () {
        expect(
          AuthValidationErrorMapper.mapPasswordConfirmationError(null),
          isNull,
        );
      });
    });
  });
}
