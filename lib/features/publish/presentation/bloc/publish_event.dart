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

  /// Submits the current publication.
  const factory PublishEvent.submit() = _Submit;

  /// Resets the form to publish another game.
  const factory PublishEvent.publishAnother() = _PublishAnother;

  /// Updates the game ID input.
  const factory PublishEvent.gameIdChanged(String value) = _GameIdChanged;

  /// Updates the description input.
  const factory PublishEvent.descriptionChanged(String value) =
      _DescriptionChanged;

  /// Updates the price input.
  const factory PublishEvent.priceChanged(int value) = _PriceChanged;

  /// Updates the condition input.
  const factory PublishEvent.conditionChanged(String value) = _ConditionChanged;

  /// Updates the selected images.
  const factory PublishEvent.imagesChanged(List<String> value) = _ImagesChanged;

  /// Loads the list of available games.
  const factory PublishEvent.loadGames() = _LoadGames;

  /// Filters the list of games by query.
  const factory PublishEvent.searchGames(String query) = _SearchGames;

  /// Updates the delivery methods.
  const factory PublishEvent.deliveryMethodsChanged(
      List<DeliveryMethod> value) = _DeliveryMethodsChanged;
}
