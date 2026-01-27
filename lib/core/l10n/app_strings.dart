/// Centralized user-facing strings for the application.
class AppStrings {
  // Common

  /// Generic error message.
  static const String errorGeneric = 'Ocurrió un error inesperado.';

  /// Message shown when a game fails to load.
  static const String errorLoadingGame = 'Error al cargar el juego.';

  /// Message shown when an invalid ID is encountered.
  static const String errorInvalidId = 'ID inválido.';

  /// Message shown when a game is not found.
  static const String errorGameNotFound = 'Juego no encontrado.';

  // Rental

  /// Message shown when the rental duration is less than 3 days.
  static const String rentalMinDays =
      'El alquiler mínimo es de 3 días (ej: Lun a Jue).';

  /// Message shown when the rental duration exceeds 30 days.
  static const String rentalMaxDays =
      'El alquiler no puede superar los 30 días.';

  /// Message shown when selected dates are not fully available.
  static const String rentalUnavailableRange =
      'Las fechas seleccionadas no están disponibles en su totalidad.';

  /// Message shown when rental dates have not been selected.
  static const String rentalSelectDates = 'Seleccioná las fechas del alquiler.';

  /// Message shown when the end date is not after the start date.
  static const String rentalChooseLaterEnd =
      'Elegí una fecha de fin posterior al inicio.';

  /// Message shown when a game is not available for at least 3 days.
  static const String rentalMinAvailability =
      'El juego debe estar disponible por al menos 3 días.';

  /// Message shown when the game owner cannot be identified.
  static const String rentalIdentifyOwnerError =
      'No pudimos identificar al dueño del juego.';

  /// Message shown when a rental confirmation fails.
  static const String rentalConfirmError = 'No se pudo confirmar el alquiler.';

  // Auth

  /// Message shown when login fails.
  static const String authLoginError =
      'No pudimos iniciar sesión. Intenta nuevamente.';

  /// Message shown when registration fails.
  static const String authRegisterError =
      'No pudimos crear tu cuenta. Intenta nuevamente.';

  /// Message shown when token refresh fails.
  static const String authRefreshError = 'Error al refrescar sesión.';

  /// Validation message when email is missing.
  static const String authEmailRequired = 'Ingresá tu email.';

  /// Validation message when email format is invalid.
  static const String authEmailInvalid = 'Ingresá un email válido.';

  /// Validation message when password is missing.
  static const String authPasswordRequired = 'Ingresá tu contraseña.';

  /// Validation message when password is too short.
  static const String authPasswordTooShort =
      'La contraseña debe tener al menos 8 caracteres.';

  /// Validation message when passwords in registration don't match.
  static const String authPasswordsDontMatch = 'Las contraseñas no coinciden.';

  /// Validation message when name is missing.
  static const String authNameRequired = 'Ingresá tu nombre.';
}
