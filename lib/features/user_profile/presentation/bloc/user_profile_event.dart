part of 'user_profile_bloc.dart';

@freezed

/// Events for loading user profile data.
abstract class UserProfileEvent with _$UserProfileEvent {
  /// Starts loading a profile based on the selected game id.
  const factory UserProfileEvent.started({required String gameId}) = _Started;
}
