part of 'edit_publication_bloc.dart';

/// Events for the edit publication flow.
@freezed
sealed class EditPublicationEvent with _$EditPublicationEvent {
  /// Initialize and load publication data.
  const factory EditPublicationEvent.started({
    required String publicationId,
  }) = _Started;

  /// Description field changed.
  const factory EditPublicationEvent.descriptionChanged(String value) =
      _DescriptionChanged;

  /// Price field changed.
  const factory EditPublicationEvent.priceChanged(int value) = _PriceChanged;

  /// Condition selection changed.
  const factory EditPublicationEvent.conditionChanged(String value) =
      _ConditionChanged;

  /// Images list changed.
  const factory EditPublicationEvent.imagesChanged(List<String> value) =
      _ImagesChanged;

  /// Delivery methods changed.
  const factory EditPublicationEvent.deliveryMethodsChanged(
    List<DeliveryMethod> value,
  ) = _DeliveryMethodsChanged;

  /// Toggle a delivery method selection.
  const factory EditPublicationEvent.toggleDeliveryMethod(
    DeliveryMethod method,
  ) = _ToggleDeliveryMethod;

  /// Move to next step.
  const factory EditPublicationEvent.nextStep() = _NextStep;

  /// Move to previous step.
  const factory EditPublicationEvent.previousStep() = _PreviousStep;

  /// Pick and upload image from gallery.
  const factory EditPublicationEvent.pickImage() = _PickImage;

  /// Pick and upload multiple images from gallery.
  const factory EditPublicationEvent.pickMultipleImages() = _PickMultipleImages;

  /// Remove image at index.
  const factory EditPublicationEvent.removeImage(int index) = _RemoveImage;

  /// Submit changes to the publication.
  const factory EditPublicationEvent.submit() = _Submit;

  /// Delete the publication.
  const factory EditPublicationEvent.delete() = _Delete;
}
