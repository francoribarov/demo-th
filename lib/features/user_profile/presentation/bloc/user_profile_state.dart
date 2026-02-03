part of 'user_profile_bloc.dart';

@freezed

/// State for the user profile screen.
abstract class UserProfileState with _$UserProfileState {
  /// Creates the user profile state.
  const factory UserProfileState({
    @Default(false) bool isLoading,
    Game? game,
    String? errorMessage,
  }) = _UserProfileState;
}
