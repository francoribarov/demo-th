part of 'my_publications_bloc.dart';

@freezed
class MyPublicationsEvent with _$MyPublicationsEvent {
  const factory MyPublicationsEvent.started() = _Started;
}
