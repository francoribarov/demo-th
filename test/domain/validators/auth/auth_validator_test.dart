import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/domain/validators/auth/auth_validator.dart';

void main() {
  group('AuthValidator', () {
    group('validateEmail', () {
      test('returns required when empty', () {
        expect(AuthValidator.validateEmail(''), AuthEmailError.required);
        expect(AuthValidator.validateEmail('   '), AuthEmailError.required);
      });

      test('returns invalidFormat when invalid format', () {
        expect(
          AuthValidator.validateEmail('correo-invalido'),
          AuthEmailError.invalidFormat,
        );
        expect(
          AuthValidator.validateEmail('sinarroba.com'),
          AuthEmailError.invalidFormat,
        );
      });

      test('returns invalidFormat when contains whitespace', () {
        expect(
          AuthValidator.validateEmail('user @example.com'),
          AuthEmailError.invalidFormat,
        );
        expect(
          AuthValidator.validateEmail('user\t@example.com'),
          AuthEmailError.invalidFormat,
        );
        expect(
          AuthValidator.validateEmail('user\n@example.com'),
          AuthEmailError.invalidFormat,
        );
      });

      test('returns null when valid', () {
        expect(AuthValidator.validateEmail('user@example.com'), isNull);
        expect(AuthValidator.validateEmail('  user@example.com  '), isNull);
      });
    });

    group('validatePassword', () {
      test('returns required when empty', () {
        expect(AuthValidator.validatePassword(''), AuthPasswordError.required);
      });

      test('returns tooShort when less than 8 chars', () {
        expect(
          AuthValidator.validatePassword('1234567'),
          AuthPasswordError.tooShort,
        );
      });

      test('returns null when valid', () {
        expect(AuthValidator.validatePassword('password123'), isNull);
      });
    });

    group('validateUsernameRequired', () {
      test('returns required when empty', () {
        expect(
          AuthValidator.validateUsernameRequired(''),
          AuthUsernameError.required,
        );
        expect(
          AuthValidator.validateUsernameRequired('   '),
          AuthUsernameError.required,
        );
      });

      test('returns null when valid', () {
        expect(
          AuthValidator.validateUsernameRequired('User One'),
          isNull,
        );
      });
    });

    group('validatePasswordConfirmation', () {
      test('returns required when confirmation empty', () {
        expect(
          AuthValidator.validatePasswordConfirmation(
            password: 'pass123',
            confirmation: '',
          ),
          AuthPasswordConfirmationError.required,
        );
      });

      test('returns mismatch when passwords differ', () {
        expect(
          AuthValidator.validatePasswordConfirmation(
            password: 'pass123',
            confirmation: 'different',
          ),
          AuthPasswordConfirmationError.mismatch,
        );
      });

      test('returns null when match', () {
        expect(
          AuthValidator.validatePasswordConfirmation(
            password: 'pass123',
            confirmation: 'pass123',
          ),
          isNull,
        );
      });
    });
  });
}
