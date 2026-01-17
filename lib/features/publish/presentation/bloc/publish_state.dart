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
    @Default(0) int price,
    @Default('like_new') String condition,
    @Default([]) List<String> images,
    @Default([]) List<String> deliveryMethods,
  }) = _PublishState;
  const PublishState._();

  /// Returns whether the current step is valid to advance.
  bool get canProceed {
    return PublicationValidator.validateDescription(description).isValid &&
        PublicationValidator.validatePricing(price).isValid &&
        gameId.isNotEmpty;
  }
}
