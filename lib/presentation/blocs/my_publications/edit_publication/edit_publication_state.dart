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
    @Default(PublicationFormState()) PublicationFormState form,
    @Default([]) List<String> images,
    @Default([]) List<DeliveryMethod> deliveryMethods,
    @Default([]) List<DeliveryMethod> availableDeliveryMethods,
    @Default([]) List<Game> allGames,
  }) = _EditPublicationState;

  const EditPublicationState._();

  /// The game associated with this publication.
  Game? get selectedGame =>
      allGames.where((g) => g.id == form.gameId).firstOrNull;

  /// Returns whether the current step is valid for proceeding.
  bool get canProceed {
    return switch (currentStep) {
      0 => form.hasValidData, // Data step
      1 => true, // Photos step (optional)
      2 => form.hasValidPrice, // Price step
      EditPublicationBloc.maxStep =>
        form.hasValidData && form.hasValidPrice, // Review
      _ => false,
    };
  }
}
