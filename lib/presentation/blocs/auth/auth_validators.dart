import 'package:mobile_table_hopping/core/l10n/app_strings.dart';

final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

/// Validates an email address and returns an error message when invalid.
String? validateEmail(String email) {
  final normalizedEmail = email.trim();
  if (normalizedEmail.isEmpty) {
    return AppStrings.authEmailRequired;
  }
  if (!_emailPattern.hasMatch(normalizedEmail)) {
    return AppStrings.authEmailInvalid;
  }
  return null;
}

/// Validates password requirements and returns an error message when invalid.
String? validatePasswordMin8(
  String password, {
  String emptyMessage = AppStrings.authPasswordRequired,
}) {
  if (password.isEmpty) {
    return emptyMessage;
  }
  if (password.length < 8) {
    return AppStrings.authPasswordTooShort;
  }
  return null;
}

/// Validates a required username.
String? validateUsernameRequired(String username) {
  if (username.trim().isEmpty) {
    return AppStrings.authNameRequired;
  }
  return null;
}

/// Validates registration password confirmation.
String? validatePasswordConfirmation({
  required String password,
  required String confirmation,
}) {
  if (confirmation.isEmpty) {
    return AppStrings.authPasswordConfirmRequired;
  }
  if (password != confirmation) {
    return AppStrings.authPasswordsDontMatch;
  }
  return null;
}
