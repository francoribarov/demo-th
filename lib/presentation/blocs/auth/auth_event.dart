part of 'auth_bloc.dart';

@freezed
/// Events for authentication flows and session handling.
abstract class AuthEvent with _$AuthEvent {
  /// Starts the authentication status check.
  const factory AuthEvent.started() = _Started;

  /// Signals that a session was obtained (from login or register).
  const factory AuthEvent.sessionObtained(AuthSession session) = _SessionObtained;

  // Session
  /// Requests a logout.
  const factory AuthEvent.logoutRequested() = _LogoutRequested;

  /// Requests a token refresh.
  const factory AuthEvent.refreshRequested() = _RefreshRequested;

  /// Clears any surfaced error messages.
  const factory AuthEvent.clearErrors() = _ClearErrors;
}
