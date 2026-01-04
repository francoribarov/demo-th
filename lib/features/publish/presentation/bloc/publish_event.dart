part of 'publish_bloc.dart';

@freezed
/// Publish flow actions.
abstract class PublishEvent with _$PublishEvent {
  /// Initializes the publish flow.
  const factory PublishEvent.started() = _Started;

  /// Advances to the next step.
  const factory PublishEvent.nextStep() = _NextStep;

  /// Returns to the previous step.
  const factory PublishEvent.previousStep() = _PreviousStep;

  /// Submits the current listing.
  const factory PublishEvent.submit() = _Submit;

  /// Resets the form to publish another game.
  const factory PublishEvent.publishAnother() = _PublishAnother;

  /// Updates the title input.
  const factory PublishEvent.titleChanged(String value) = _TitleChanged;

  /// Updates the publisher input.
  const factory PublishEvent.publisherChanged(String value) = _PublisherChanged;

  /// Updates the category input.
  const factory PublishEvent.categoryChanged(String value) = _CategoryChanged;

  /// Updates the description input.
  const factory PublishEvent.descriptionChanged(String value) = _DescriptionChanged;

  /// Updates the duration input.
  const factory PublishEvent.durationChanged(String value) = _DurationChanged;

  /// Updates the players input.
  const factory PublishEvent.playersChanged(String value) = _PlayersChanged;

  /// Updates the difficulty input.
  const factory PublishEvent.difficultyChanged(String value) = _DifficultyChanged;

  /// Updates the daily price input.
  const factory PublishEvent.pricePerDayChanged(int value) = _PricePerDayChanged;

  /// Updates the deposit input.
  const factory PublishEvent.depositChanged(int value) = _DepositChanged;

  /// Updates the condition input.
  const factory PublishEvent.conditionChanged(String value) = _ConditionChanged;

  /// Updates the visibility input.
  const factory PublishEvent.visibilityChanged(String value) = _VisibilityChanged;

  /// Updates the selected images.
  const factory PublishEvent.imagesChanged(List<String> value) = _ImagesChanged;
}
