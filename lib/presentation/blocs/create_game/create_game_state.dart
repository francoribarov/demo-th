part of 'create_game_bloc.dart';

@freezed
/// State for the create-game wizard.
abstract class CreateGameState with _$CreateGameState {
  const factory CreateGameState({
    @Default(0) int currentStep,
    // Title, description, images (step 1)
    @Default('') String title,
    @Default('') String description,
    @Default([]) List<String> images,
    @Default(false) bool isUploadingImages,
    // Characteristics (step 2)
    @Default(0) int duration,
    @Default('') String players,
    @Default('Medio') String difficulty,
    // PDF rules (step 3)
    @Default('') String rulesUrl,
    @Default(false) bool isUploadingPdf,
    // Flow state
    @Default(false) bool isStepValid,
    @Default(false) bool isSubmitting,
    String? errorMessage,
    // Validation errors
    String? titleError,
    String? descriptionError,
    String? durationError,
    String? playersError,
    // Result
    Game? createdGame,
  }) = _CreateGameState;

  const CreateGameState._();
}
