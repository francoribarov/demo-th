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
    @Default(null) PublicationCondition? condition,
    @Default(0) int price,
    String? descriptionError,
    String? conditionError,
    String? priceError,
    @Default([]) List<Game> allGames,
    @Default([]) List<Game> filteredGames,
    @Default(false) bool isLoadingGames,
    @Default(false) bool isStepValid,
  }) = _PublishState;

  const PublishState._();
}
