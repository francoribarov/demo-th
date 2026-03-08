part of 'my_rentals_bloc.dart';

@freezed
class MyRentalsEvent with _$MyRentalsEvent {
  const factory MyRentalsEvent.started() = _Started;
  const factory MyRentalsEvent.refresh() = _Refresh;
  const factory MyRentalsEvent.dropOffRequested(String rentalId) = _DropOffRequested;
  const factory MyRentalsEvent.messageDismissed() = _MessageDismissed;
}
