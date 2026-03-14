final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

/// Validates an email address and returns an error message when invalid.
String? validateEmail(String email) {
  final normalizedEmail = email.trim();
  if (normalizedEmail.isEmpty) {
    return 'Ingresá tu email.';
  }
  if (!_emailPattern.hasMatch(normalizedEmail)) {
    return 'Ingresá un email válido.';
  }
  return null;
}

/// Validates password requirements and returns an error message when invalid.
String? validatePasswordMin8(
  String password, {
  String emptyMessage = 'Ingresá tu contraseña.',
}) {
  if (password.isEmpty) {
    return emptyMessage;
  }
  if (password.length < 8) {
    return 'La contraseña debe tener al menos 8 caracteres.';
  }
  return null;
}

/// Validates a required username.
String? validateUsernameRequired(String username) {
  if (username.trim().isEmpty) {
    return 'Ingresá tu nombre.';
  }
  return null;
}

/// Validates registration password confirmation.
String? validatePasswordConfirmation({
  required String password,
  required String confirmation,
}) {
  if (confirmation.isEmpty) {
    return 'Repetí tu contraseña para continuar.';
  }
  if (password != confirmation) {
    return 'Las contraseñas no coinciden.';
  }
  return null;
}
