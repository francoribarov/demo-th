part of 'auth_bloc.dart';

@freezed
/// Events for authentication flows and session handling.
abstract class AuthEvent with _$AuthEvent {
  /// Starts the authentication status check.
  const factory AuthEvent.started() = _Started;

  // Login
  /// Updates the login email input.
  const factory AuthEvent.loginEmailChanged(String email) = _LoginEmailChanged;

  /// Updates the login password input.
  const factory AuthEvent.loginPasswordChanged(String password) =
      _LoginPasswordChanged;

  /// Submits the login request.
  const factory AuthEvent.loginSubmitted() = _LoginSubmitted;

  // Register
  /// Updates the register email input.
  const factory AuthEvent.registerEmailChanged(String email) =
      _RegisterEmailChanged;

  /// Updates the register password input.
  const factory AuthEvent.registerPasswordChanged(String password) =
      _RegisterPasswordChanged;

  /// Updates the repeated register password input.
  const factory AuthEvent.registerPasswordConfirmChanged(
    String confirmPassword,
  ) = _RegisterPasswordConfirmChanged;

  /// Toggles password visibility for register form inputs.
  const factory AuthEvent.registerPasswordVisibilityToggled() =
      _RegisterPasswordVisibilityToggled;

  /// Updates the register username input.
  const factory AuthEvent.registerUsernameChanged(String username) =
      _RegisterUsernameChanged;

  /// Updates the register location input.
  const factory AuthEvent.registerLocationChanged(String location) =
      _RegisterLocationChanged;

  /// Submits the registration request.
  const factory AuthEvent.registerSubmitted() = _RegisterSubmitted;

  // Session
  /// Requests a logout.
  const factory AuthEvent.logoutRequested() = _LogoutRequested;

  /// Requests a token refresh.
  const factory AuthEvent.refreshRequested() = _RefreshRequested;

  /// Clears any surfaced error messages.
  const factory AuthEvent.clearErrors() = _ClearErrors;
}
