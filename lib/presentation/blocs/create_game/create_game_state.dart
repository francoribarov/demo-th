part of 'create_game_bloc.dart';

@freezed
/// State for the create-game wizard.
abstract class CreateGameState with _$CreateGameState {
  const factory CreateGameState({
    @Default(0) int currentStep,
    @Default('') String title,
    @Default('') String description,
    @Default(0) int duration,
    @Default('') String players,
    @Default('Medio') String difficulty,
    @Default(false) bool isStepValid,
    @Default(false) bool isSubmitting,
    String? errorMessage,
    String? titleError,
    String? descriptionError,
    String? durationError,
    String? playersError,
    Game? createdGame,
  }) = _CreateGameState;

  const CreateGameState._();
}
