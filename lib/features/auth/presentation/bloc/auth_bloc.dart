import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/auth/domain/entities/auth_session.dart';
import 'package:mobile_table_hopping/features/auth/domain/usecases/get_auth_status.dart';
import 'package:mobile_table_hopping/features/auth/domain/usecases/login.dart';
import 'package:mobile_table_hopping/features/auth/domain/usecases/logout.dart';
import 'package:mobile_table_hopping/features/auth/domain/usecases/refresh_token.dart';
import 'package:mobile_table_hopping/features/auth/domain/usecases/register.dart';

part 'auth_bloc.freezed.dart';

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
/// Events for authentication flows and session handling.
class AuthEvent with _$AuthEvent {
  /// Starts the authentication status check.
  const factory AuthEvent.started() = _Started;

  // Login
  /// Updates the login email input.
  const factory AuthEvent.loginEmailChanged(String value) = _LoginEmailChanged;

  /// Updates the login password input.
  const factory AuthEvent.loginPasswordChanged(String value) = _LoginPasswordChanged;

  /// Submits the login request.
  const factory AuthEvent.loginSubmitted() = _LoginSubmitted;

  // Register
  /// Updates the register email input.
  const factory AuthEvent.registerEmailChanged(String value) = _RegisterEmailChanged;

  /// Updates the register password input.
  const factory AuthEvent.registerPasswordChanged(String value) = _RegisterPasswordChanged;

  /// Updates the register name input.
  const factory AuthEvent.registerNameChanged(String value) = _RegisterNameChanged;

  /// Updates the register location input.
  const factory AuthEvent.registerLocationChanged(String value) = _RegisterLocationChanged;

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

@freezed
/// State for authentication and auth-related forms.
class AuthState with _$AuthState {
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
    @Default('') String registerName,
    @Default('') String registerLocation,
    @Default(false) bool isSubmittingRegister,
    String? registerErrorMessage,
  }) = _AuthState;

  const AuthState._();

  /// Whether the current state indicates an authenticated user.
  bool get isAuthenticated => status == AuthStatus.authenticated;
}

@lazySingleton
/// BLoC orchestrating authentication state and form submissions.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Creates an [AuthBloc] wired with auth use cases.
  AuthBloc({
    required GetAuthStatus getAuthStatus,
    required Login login,
    required Register register,
    required Logout logout,
    required RefreshToken refreshToken,
  }) : _getAuthStatus = getAuthStatus,
       _login = login,
       _register = register,
       _logout = logout,
       _refreshToken = refreshToken,
       super(const AuthState()) {
    on<_Started>(_onStarted);
    on<_LoginEmailChanged>(_onLoginEmailChanged);
    on<_LoginPasswordChanged>(_onLoginPasswordChanged);
    on<_LoginSubmitted>(_onLoginSubmitted);
    on<_RegisterEmailChanged>(_onRegisterEmailChanged);
    on<_RegisterPasswordChanged>(_onRegisterPasswordChanged);
    on<_RegisterNameChanged>(_onRegisterNameChanged);
    on<_RegisterLocationChanged>(_onRegisterLocationChanged);
    on<_RegisterSubmitted>(_onRegisterSubmitted);
    on<_LogoutRequested>(_onLogoutRequested);
    on<_RefreshRequested>(_onRefreshRequested);
    on<_ClearErrors>(_onClearErrors);

    add(const AuthEvent.started());
  }

  final GetAuthStatus _getAuthStatus;
  final Login _login;
  final Register _register;
  final Logout _logout;
  final RefreshToken _refreshToken;

  Future<void> _onStarted(_Started event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isCheckingStatus: true, errorMessage: null));

    try {
      final session = await _getAuthStatus();

      emit(
        state.copyWith(
          isCheckingStatus: false,
          status: session != null ? AuthStatus.authenticated : AuthStatus.unauthenticated,
          session: session,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isCheckingStatus: false,
          status: AuthStatus.unauthenticated,
          session: null,
          errorMessage: 'Error al verificar sesión: $e',
        ),
      );
    }
  }

  void _onLoginEmailChanged(_LoginEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(loginEmail: event.value, loginErrorMessage: null, errorMessage: null));
  }

  void _onLoginPasswordChanged(_LoginPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(loginPassword: event.value, loginErrorMessage: null, errorMessage: null));
  }

  Future<void> _onLoginSubmitted(_LoginSubmitted event, Emitter<AuthState> emit) async {
    final email = state.loginEmail.trim();
    final password = state.loginPassword;

    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(loginErrorMessage: 'Ingresá email y contraseña para continuar.'));
      return;
    }

    emit(state.copyWith(isSubmittingLogin: true, loginErrorMessage: null, errorMessage: null));

    try {
      final session = await _login(email: email, password: password);
      emit(
        state.copyWith(isSubmittingLogin: false, status: AuthStatus.authenticated, session: session, loginPassword: ''),
      );
    } on Exception catch (e) {
      emit(state.copyWith(isSubmittingLogin: false, loginErrorMessage: e.toString()));
    }
  }

  void _onRegisterEmailChanged(_RegisterEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(registerEmail: event.value, registerErrorMessage: null, errorMessage: null));
  }

  void _onRegisterPasswordChanged(_RegisterPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(registerPassword: event.value, registerErrorMessage: null, errorMessage: null));
  }

  void _onRegisterNameChanged(_RegisterNameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(registerName: event.value, registerErrorMessage: null, errorMessage: null));
  }

  void _onRegisterLocationChanged(_RegisterLocationChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(registerLocation: event.value, registerErrorMessage: null, errorMessage: null));
  }

  Future<void> _onRegisterSubmitted(_RegisterSubmitted event, Emitter<AuthState> emit) async {
    final email = state.registerEmail.trim();
    final password = state.registerPassword;
    final name = state.registerName.trim();
    final location = state.registerLocation.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      emit(state.copyWith(registerErrorMessage: 'Completá email, contraseña y nombre.'));
      return;
    }

    emit(state.copyWith(isSubmittingRegister: true, registerErrorMessage: null, errorMessage: null));

    try {
      final session = await _register(
        email: email,
        password: password,
        name: name,
        location: location.isEmpty ? null : location,
      );
      emit(
        state.copyWith(
          isSubmittingRegister: false,
          status: AuthStatus.authenticated,
          session: session,
          registerPassword: '',
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(isSubmittingRegister: false, registerErrorMessage: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(_LogoutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(errorMessage: null));
    try {
      await _logout();
    } on Exception catch (_) {
      // Ignore logout errors, always clear local session in repository.
    } finally {
      emit(state.copyWith(status: AuthStatus.unauthenticated, session: null));
    }
  }

  Future<void> _onRefreshRequested(_RefreshRequested event, Emitter<AuthState> emit) async {
    if (!state.isAuthenticated || state.session == null) return;

    try {
      final tokens = await _refreshToken();
      emit(state.copyWith(session: state.session!.copyWith(tokens: tokens)));
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: 'Error al refrescar sesión: $e'));
    }
  }

  void _onClearErrors(_ClearErrors event, Emitter<AuthState> emit) {
    emit(state.copyWith(errorMessage: null, loginErrorMessage: null, registerErrorMessage: null));
  }
}
