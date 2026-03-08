part of 'drop_off_bloc.dart';

@freezed
class DropOffEvent with _$DropOffEvent {
  const factory DropOffEvent.started() = _Started;
  const factory DropOffEvent.pickImage() = _PickImage;
  const factory DropOffEvent.submit(String rentalId) = _Submit;
}
