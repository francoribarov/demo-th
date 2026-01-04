part of 'rental_bloc.dart';

@freezed
/// Events for creating and submitting a rental draft.
abstract class RentalEvent with _$RentalEvent {
  /// Loads the game and initializes dates for the rental flow.
  const factory RentalEvent.started({
    required String gameId,
    String? startDate,
    String? endDate,
    String? ownerId,
    int? deposit,
  }) = _Started;

  /// Updates the rental start date.
  const factory RentalEvent.startDateChanged({String? startDate}) = _StartDateChanged;

  /// Updates the rental end date.
  const factory RentalEvent.endDateChanged({String? endDate}) = _EndDateChanged;

  /// Updates both dates at once.
  const factory RentalEvent.dateRangeChanged({
    String? startDate,
    String? endDate,
  }) = _DateRangeChanged;

  /// Toggles delivery for the current rental draft.
  const factory RentalEvent.deliveryChanged({required bool isDelivery}) =
      _DeliveryChanged;

  /// Updates the delivery address.
  const factory RentalEvent.deliveryAddressChanged({required String address}) =
      _DeliveryAddressChanged;

  /// Updates delivery comments/notes.
  const factory RentalEvent.deliveryCommentsChanged({required String comments}) =
      _DeliveryCommentsChanged;

  /// Updates the selected payment method.
  const factory RentalEvent.paymentMethodChanged({required String paymentMethod}) =
      _PaymentMethodChanged;

  /// Updates the selected food bundle identifiers.
  const factory RentalEvent.foodBundlesChanged({required List<String> foodBundles}) =
      _FoodBundlesChanged;

  /// Submits the current rental draft.
  const factory RentalEvent.submitted() = _Submitted;

  /// Clears the last snackbar message after it is shown.
  const factory RentalEvent.messageShown() = _MessageShown;

  /// Resets the flow to publish another rental.
  const factory RentalEvent.publishAnother() = _PublishAnother;
}
