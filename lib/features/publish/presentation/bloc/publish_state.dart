part of 'publish_bloc.dart';

@freezed

/// State for the publish flow.
abstract class PublishState with _$PublishState {
  /// Creates a publish state snapshot.
  const factory PublishState({
    @Default(0) int formVersion,
    @Default(0) int currentStep,
    @Default(false) bool success,
    @Default(false) bool isSubmitting,
    String? errorMessage,
    @Default('') String gameId,
    @Default('') String description,
    @Default('') String condition,
    @Default(0) int price,
    @Default([]) List<String> images,
    @Default([]) List<DeliveryMethod> deliveryMethods,
    @Default([]) List<Game> allGames,
    @Default([]) List<Game> filteredGames,
    @Default(false) bool isLoadingGames,
    @Default(false) bool isLoadingDeliveryMethods,
  }) = _PublishState;

  const PublishState._();

  /// Returns whether the current step is valid to advance.
  bool get canProceed {
    switch (currentStep) {
      case 0: // Data step: game and description
        return gameId.isNotEmpty &&
            PublicationValidator.validateDescription(description).isValid &&
            condition.isNotEmpty;
      case 1: // Photos step: no validation required (optional)
        return true;
      case 2: // Price step: price must be valid
        return PublicationValidator.validatePricing(price).isValid;
      case 3: // Review step: ready to submit
        return gameId.isNotEmpty &&
            PublicationValidator.validateDescription(description).isValid &&
            PublicationValidator.validatePricing(price).isValid;
      default:
        return false;
    }
  }
}
