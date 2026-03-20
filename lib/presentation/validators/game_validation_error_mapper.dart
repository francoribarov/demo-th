import 'package:mobile_table_hopping/domain/validators/game/game_validator.dart';

/// Maps typed game validation errors into UI messages.
class GameValidationErrorMapper {
  static String? mapTitleError(GameTitleError? error) {
    return switch (error) {
      GameTitleError.required => 'El nombre del juego es obligatorio.',
      GameTitleError.tooShort => 'El nombre debe tener al menos 2 caracteres.',
      null => null,
    };
  }

  static String? mapDescriptionError(GameDescriptionError? error) {
    return switch (error) {
      GameDescriptionError.required => 'La descripción es obligatoria.',
      GameDescriptionError.tooShort =>
        'La descripción debe ser más detallada (min 10 caracteres).',
      null => null,
    };
  }

  static String? mapDurationError(GameDurationError? error) {
    return switch (error) {
      GameDurationError.mustBePositive =>
        'La duración debe ser mayor a 0 minutos.',
      null => null,
    };
  }

  static String? mapPlayersError(GamePlayersError? error) {
    return switch (error) {
      GamePlayersError.required =>
        'El número de jugadores es obligatorio.',
      GamePlayersError.invalidFormat =>
        'Formato inválido. Usá "2-4" o "3".',
      null => null,
    };
  }
}
