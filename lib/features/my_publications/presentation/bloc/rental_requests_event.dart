part of 'rental_requests_bloc.dart';

@freezed
class RentalRequestsEvent with _$RentalRequestsEvent {
  const factory RentalRequestsEvent.started() = _Started;
  const factory RentalRequestsEvent.accepted(String requestId) =
      _RequestAccepted;
  const factory RentalRequestsEvent.rejected(String requestId) =
      _RequestRejected;
  const factory RentalRequestsEvent.messageDismissed() = _MessageDismissed;
}
