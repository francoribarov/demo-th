/// Typed validation errors for game title.
enum GameTitleError { required, tooShort }

/// Typed validation errors for game description.
enum GameDescriptionError { required, tooShort }

/// Typed validation errors for game duration.
enum GameDurationError { mustBePositive }

/// Typed validation errors for game players.
enum GamePlayersError { required, invalidFormat }

/// Centralized validator for game creation data.
class GameValidator {
  static const int _minTitleLength = 2;
  static const int _minDescriptionLength = 10;

  /// Validates game title.
  static GameTitleError? validateTitle(String title) {
    if (title.trim().isEmpty) return GameTitleError.required;
    if (title.trim().length < _minTitleLength) return GameTitleError.tooShort;
    return null;
  }

  /// Validates game description.
  static GameDescriptionError? validateDescription(String description) {
    if (description.trim().isEmpty) return GameDescriptionError.required;
    if (description.trim().length < _minDescriptionLength) {
      return GameDescriptionError.tooShort;
    }
    return null;
  }

  /// Validates game duration in minutes.
  static GameDurationError? validateDuration(int duration) {
    if (duration <= 0) return GameDurationError.mustBePositive;
    return null;
  }

  /// Validates player count string (e.g. "2-4").
  static GamePlayersError? validatePlayers(String players) {
    if (players.trim().isEmpty) return GamePlayersError.required;
    final pattern = RegExp(r'^\d+(-\d+)?$');
    if (!pattern.hasMatch(players.trim())) {
      return GamePlayersError.invalidFormat;
    }
    return null;
  }
}
