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

    @Default('') String title,
    @Default('') String publisher,
    @Default('Estrategia') String category,
    @Default('') String description,
    @Default('') String duration,
    @Default('') String players,
    @Default('Medio') String difficulty,
    @Default(50) int pricePerDay,
    @Default(500) int deposit,
    @Default('like_new') String condition,
    @Default('public') String visibility,
    @Default([]) List<String> images,
  }) = _PublishState;
  const PublishState._();

  /// Returns whether the current step is valid to advance.
  bool get canProceed {
    switch (currentStep) {
      case 0:
        return title.trim().isNotEmpty && description.trim().isNotEmpty;
      case 1:
        return true;
      case 2:
        return pricePerDay > 0;
      case 3:
        return true;
      default:
        return false;
    }
  }
}
