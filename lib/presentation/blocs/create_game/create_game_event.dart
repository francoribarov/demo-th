part of 'create_game_bloc.dart';

@freezed
/// Events for the create-game wizard.
abstract class CreateGameEvent with _$CreateGameEvent {
  // Step 1: title, description, images
  const factory CreateGameEvent.titleChanged(String value) = _TitleChanged;
  const factory CreateGameEvent.descriptionChanged(String value) =
      _DescriptionChanged;
  const factory CreateGameEvent.imagesChanged(List<String> value) =
      _ImagesChanged;
  // Step 2: characteristics
  const factory CreateGameEvent.durationChanged(int value) = _DurationChanged;
  const factory CreateGameEvent.playersChanged(String value) = _PlayersChanged;
  const factory CreateGameEvent.difficultyChanged(String value) =
      _DifficultyChanged;
  // Step 3: PDF rules
  const factory CreateGameEvent.rulesUrlChanged(String value) =
      _RulesUrlChanged;
  // Navigation
  const factory CreateGameEvent.nextStep() = _NextStep;
  const factory CreateGameEvent.previousStep() = _PreviousStep;
  const factory CreateGameEvent.goToStep(int step) = _GoToStep;
  const factory CreateGameEvent.submit({
    @Default([]) List<String> images,
  }) = _Submit;
}
