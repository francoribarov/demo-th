part of 'owner_rentals_bloc.dart';

@freezed
sealed class OwnerRentalsEvent with _$OwnerRentalsEvent {
  const factory OwnerRentalsEvent.started() = _Started;
  const factory OwnerRentalsEvent.refresh() = _Refresh;
  const factory OwnerRentalsEvent.confirmReturn(String rentalId) =
      _ConfirmReturn;
  const factory OwnerRentalsEvent.messageDismissed() = _MessageDismissed;
}
