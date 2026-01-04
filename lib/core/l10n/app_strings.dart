/// Centralized user-facing strings for the application.
class AppStrings {
  // Common
  static const String errorGeneric = 'Ocurrió un error inesperado.';
  static const String errorLoadingGame = 'Error al cargar el juego.';
  static const String errorInvalidId = 'ID inválido.';
  static const String errorGameNotFound = 'Juego no encontrado.';

  // Rental
  static const String rentalMinDays = 'El alquiler mínimo es de 3 días (ej: Lun a Jue).';
  static const String rentalMaxDays = 'El alquiler no puede superar los 30 días.';
  static const String rentalUnavailableRange = 'Las fechas seleccionadas no están disponibles en su totalidad.';
  static const String rentalSelectDates = 'Seleccioná las fechas del alquiler.';
  static const String rentalChooseLaterEnd = 'Elegí una fecha de fin posterior al inicio.';
  static const String rentalMinAvailability = 'El juego debe estar disponible por al menos 3 días.';
  static const String rentalIdentifyOwnerError = 'No pudimos identificar al dueño del juego.';
  static const String rentalConfirmError = 'No se pudo confirmar el alquiler.';
  
  // Auth
  static const String authLoginError = 'No pudimos iniciar sesión. Intenta nuevamente.';
  static const String authRegisterError = 'No pudimos crear tu cuenta. Intenta nuevamente.';
  static const String authRefreshError = 'Error al refrescar sesión.';
  static const String authEmailRequired = 'Ingresá tu email.';
  static const String authEmailInvalid = 'Ingresá un email válido.';
  static const String authPasswordRequired = 'Ingresá tu contraseña.';
  static const String authPasswordTooShort = 'La contraseña debe tener al menos 8 caracteres.';
  static const String authPasswordsDontMatch = 'Las contraseñas no coinciden.';
  static const String authNameRequired = 'Ingresá tu nombre.';
}
