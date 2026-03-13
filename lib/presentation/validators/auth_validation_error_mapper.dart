import 'package:mobile_table_hopping/domain/validators/auth/auth_validator.dart';

/// Maps typed auth validation errors into UI messages.
class AuthValidationErrorMapper {
  static String? mapEmailError(AuthEmailError? error) {
    return switch (error) {
      AuthEmailError.required => 'Ingresá tu email.',
      AuthEmailError.invalidFormat => 'Ingresá un email válido.',
      null => null,
    };
  }

  static String? mapPasswordError(
    AuthPasswordError? error, {
    String emptyMessage = 'Ingresá tu contraseña.',
  }) {
    return switch (error) {
      AuthPasswordError.required => emptyMessage,
      AuthPasswordError.tooShort => 'La contraseña debe tener al menos 8 caracteres.',
      null => null,
    };
  }

  static String? mapUsernameError(AuthUsernameError? error) {
    return switch (error) {
      AuthUsernameError.required => 'Ingresá tu nombre.',
      null => null,
    };
  }

  static String? mapPasswordConfirmationError(
    AuthPasswordConfirmationError? error,
  ) {
    return switch (error) {
      AuthPasswordConfirmationError.required => 'Repetí tu contraseña para continuar.',
      AuthPasswordConfirmationError.mismatch => 'Las contraseñas no coinciden.',
      null => null,
    };
  }
}
