part of 'edit_publication_bloc.dart';

/// State for the edit publication flow.
@freezed
abstract class EditPublicationState with _$EditPublicationState {
  /// Creates the edit publication state.
  const factory EditPublicationState({
    String? publicationId,
    PublicationDetail? publication,
    @Default(false) bool isLoading,
    @Default(false) bool isSubmitting,
    @Default(false) bool isDeleting,
    @Default(false) bool success,
    @Default(false) bool deleted,
    @Default(false) bool hasChanges,
    @Default(false) bool isUploadingImage,
    String? errorMessage,
    @Default(0) int currentStep,

    // Editable fields
    @Default('') String gameId,
    @Default('') String description,
    @Default('') String condition,
    @Default(0) int price,
    @Default([]) List<String> images,
    @Default([]) List<DeliveryMethod> deliveryMethods,
    @Default([]) List<DeliveryMethod> availableDeliveryMethods,
    @Default([]) List<Game> allGames,
  }) = _EditPublicationState;

  const EditPublicationState._();

  /// The game associated with this publication.
  Game? get selectedGame => allGames.where((g) => g.id == gameId).firstOrNull;

  /// Returns whether the current step is valid.
  bool get canProceed {
    switch (currentStep) {
      case 0: // Data step
        return description.isNotEmpty && condition.isNotEmpty;
      case 1: // Photos step
        return true;
      case 2: // Price step
        return price > 0;
      case 3: // Review step
        return description.isNotEmpty && condition.isNotEmpty && price > 0;
      default:
        return false;
    }
  }
}
