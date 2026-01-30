part of 'my_publications_bloc.dart';

/// Events for [MyPublicationsBloc].
@freezed
sealed class MyPublicationsEvent with _$MyPublicationsEvent {
  /// Initial load of user's publications.
  const factory MyPublicationsEvent.started() = _Started;

  /// Refresh the publications list.
  const factory MyPublicationsEvent.refresh() = _Refresh;
}
