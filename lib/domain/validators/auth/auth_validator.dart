/// Typed validation errors for auth email.
enum AuthEmailError { required, invalidFormat }

/// Typed validation errors for auth password.
enum AuthPasswordError { required, tooShort }

/// Typed validation errors for auth username.
enum AuthUsernameError { required }

/// Typed validation errors for password confirmation.
enum AuthPasswordConfirmationError { required, mismatch }

/// Centralized validator for auth form data.
class AuthValidator {
  /// Validates email and returns a typed error when invalid.
  static AuthEmailError? validateEmail(String email) {
    final normalized = email.trim();
    if (normalized.isEmpty) {
      return AuthEmailError.required;
    }
    final atIndex = normalized.indexOf('@');
    if (atIndex <= 0 || atIndex >= normalized.length - 1) {
      return AuthEmailError.invalidFormat;
    }
    if (normalized.contains(RegExp(r'\s'))) {
      return AuthEmailError.invalidFormat;
    }
    final domain = normalized.substring(atIndex + 1);
    if (!domain.contains('.') ||
        domain.startsWith('.') ||
        domain.endsWith('.')) {
      return AuthEmailError.invalidFormat;
    }
    return null;
  }

  /// Validates password (min 8 chars) and returns a typed error when invalid.
  static AuthPasswordError? validatePassword(String password) {
    if (password.isEmpty) {
      return AuthPasswordError.required;
    }
    if (password.length < 8) {
      return AuthPasswordError.tooShort;
    }
    return null;
  }

  /// Validates required username.
  static AuthUsernameError? validateUsernameRequired(String username) {
    if (username.trim().isEmpty) {
      return AuthUsernameError.required;
    }
    return null;
  }

  /// Validates password confirmation.
  static AuthPasswordConfirmationError? validatePasswordConfirmation({
    required String password,
    required String confirmation,
  }) {
    if (confirmation.isEmpty) {
      return AuthPasswordConfirmationError.required;
    }
    if (password != confirmation) {
      return AuthPasswordConfirmationError.mismatch;
    }
    return null;
  }
}
