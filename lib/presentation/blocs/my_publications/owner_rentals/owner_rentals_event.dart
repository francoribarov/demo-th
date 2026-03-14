import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner_rentals_event.freezed.dart';

@freezed
class OwnerRentalsEvent with _$OwnerRentalsEvent {
  const factory OwnerRentalsEvent.started() = _Started;
  const factory OwnerRentalsEvent.refresh() = _Refresh;
}
