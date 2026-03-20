part of 'create_game_bloc.dart';

@freezed
/// Events for the create-game wizard.
abstract class CreateGameEvent with _$CreateGameEvent {
  const factory CreateGameEvent.titleChanged(String value) = _TitleChanged;
  const factory CreateGameEvent.descriptionChanged(String value) =
      _DescriptionChanged;
  const factory CreateGameEvent.durationChanged(int value) = _DurationChanged;
  const factory CreateGameEvent.playersChanged(String value) = _PlayersChanged;
  const factory CreateGameEvent.difficultyChanged(String value) =
      _DifficultyChanged;
  const factory CreateGameEvent.nextStep() = _NextStep;
  const factory CreateGameEvent.previousStep() = _PreviousStep;
  const factory CreateGameEvent.submit() = _Submit;
}
