part of 'auth_bloc.dart';

/// Represents the current authentication status of the user.
enum AuthStatus {
  /// Status is not yet determined.
  unknown,

  /// User has an active authenticated session.
  authenticated,

  /// User is signed out.
  unauthenticated,
}

@freezed
/// State for authentication and auth-related forms.
abstract class AuthState with _$AuthState {
  /// Creates the current authentication state snapshot.
  const factory AuthState({
    @Default(AuthStatus.unknown) AuthStatus status,
    AuthSession? session,
    @Default(false) bool isCheckingStatus,
    String? errorMessage,

    // Login
    @Default('') String loginEmail,
    @Default('') String loginPassword,
    @Default(false) bool isSubmittingLogin,
    String? loginErrorMessage,

    // Register
    @Default('') String registerEmail,
    @Default('') String registerPassword,
    @Default('') String registerPasswordConfirm,
    @Default('') String registerName,
    @Default('') String registerLocation,
    @Default(false) bool isSubmittingRegister,
    @Default(false) bool isRegisterPasswordVisible,
    String? registerErrorMessage,
  }) = _AuthState;

  const AuthState._();

  /// Whether the current state indicates an authenticated user.
  bool get isAuthenticated => status == AuthStatus.authenticated;
}
