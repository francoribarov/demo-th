import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_validators.dart';

void main() {
  group('Auth validators', () {
    group('validateEmail', () {
      test('returns error when empty', () {
        expect(validateEmail(''), 'Ingresá tu email.');
        expect(validateEmail('   '), 'Ingresá tu email.');
      });

      test('returns error when invalid format', () {
        expect(validateEmail('correo-invalido'), 'Ingresá un email válido.');
        expect(validateEmail('sinarroba.com'), 'Ingresá un email válido.');
      });

      test('returns null when valid', () {
        expect(validateEmail('user@example.com'), isNull);
        expect(validateEmail('  user@example.com  '), isNull);
      });
    });

    group('validatePasswordMin8', () {
      test('returns error when empty', () {
        expect(validatePasswordMin8(''), 'Ingresá tu contraseña.');
      });

      test('returns error when too short', () {
        expect(validatePasswordMin8('1234567'), contains('8 caracteres'));
      });

      test('returns null when valid', () {
        expect(validatePasswordMin8('password123'), isNull);
      });
    });

    group('validateUsernameRequired', () {
      test('returns error when empty', () {
        expect(validateUsernameRequired(''), 'Ingresá tu nombre.');
        expect(validateUsernameRequired('   '), 'Ingresá tu nombre.');
      });

      test('returns null when valid', () {
        expect(validateUsernameRequired('User One'), isNull);
      });
    });

    group('validatePasswordConfirmation', () {
      test('returns error when empty', () {
        expect(
          validatePasswordConfirmation(
            password: 'pass123',
            confirmation: '',
          ),
          'Repetí tu contraseña para continuar.',
        );
      });

      test('returns error when mismatch', () {
        expect(
          validatePasswordConfirmation(
            password: 'pass123',
            confirmation: 'different',
          ),
          'Las contraseñas no coinciden.',
        );
      });

      test('returns null when match', () {
        expect(
          validatePasswordConfirmation(
            password: 'pass123',
            confirmation: 'pass123',
          ),
          isNull,
        );
      });
    });
  });
}
