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

  /// Message shown when a rental request submission fails.
  static const String rentalConfirmError =
      'No se pudo enviar la solicitud de alquiler.';

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

  /// Validation message when password confirmation is missing.
  static const String authPasswordConfirmRequired =
      'Repetí tu contraseña para continuar.';

  /// Validation message when passwords in registration don't match.
  static const String authPasswordsDontMatch = 'Las contraseñas no coinciden.';

  /// Validation message when name is missing.
  static const String authNameRequired = 'Ingresá tu nombre.';

  /// Auth heading shown on login.
  static const String authLoginWelcomeTitle = 'Bienvenido/a';

  /// Auth subtitle shown on login.
  static const String authLoginWelcomeSubtitle =
      'Ingresá tus datos para continuar.';

  /// Auth heading shown on registration.
  static const String authRegisterWelcomeTitle = 'Empecemos';

  /// Auth subtitle shown on registration.
  static const String authRegisterWelcomeSubtitle =
      'Creá tu cuenta para publicar y alquilar juegos.';

  /// Label for email field.
  static const String authEmailLabel = 'Email';

  /// Hint for email field.
  static const String authEmailHint = 'tu@email.com';

  /// Label for password field.
  static const String authPasswordLabel = 'Contraseña';

  /// Helper text for password field.
  static const String authPasswordHelper = 'Mínimo 8 caracteres.';

  /// Label for password confirmation field.
  static const String authPasswordConfirmLabel = 'Repetí la contraseña';

  /// Label for username field.
  static const String authNameLabel = 'Nombre';

  /// Label for optional location field.
  static const String authLocationLabel = 'Ubicación (opcional)';

  /// Hint for optional location field.
  static const String authLocationHint = 'Ej: Palermo, CABA';

  /// Label for login submit button.
  static const String authLoginCta = 'Ingresar';

  /// Label for register submit button.
  static const String authRegisterCta = 'Crear cuenta';

  /// Prompt shown on login to invite new users to register.
  static const String authLoginSwitchPrompt = 'No tenés cuenta? ';

  /// Tappable action on login switch row.
  static const String authLoginSwitchAction = 'Registrate';

  /// Prompt shown on register to invite existing users to log in.
  static const String authRegisterSwitchPrompt = 'Ya tenés cuenta? ';

  /// Tappable action on register switch row.
  static const String authRegisterSwitchAction = 'Iniciá sesión';

  /// Tooltip label for showing a password.
  static const String authShowPassword = 'Mostrar contraseña';

  /// Tooltip label for hiding a password.
  static const String authHidePassword = 'Ocultar contraseña';
}
