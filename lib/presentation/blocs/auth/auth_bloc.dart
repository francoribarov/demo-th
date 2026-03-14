import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/auth/session_expired_notifier.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/get_auth_status.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/login.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/logout.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/refresh_token.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/register.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_validators.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

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
    required SessionExpiredNotifier sessionExpiredNotifier,
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
    on<_RegisterPasswordConfirmChanged>(_onRegisterPasswordConfirmChanged);
    on<_RegisterUsernameChanged>(_onRegisterUsernameChanged);
    on<_RegisterLocationChanged>(_onRegisterLocationChanged);
    on<_RegisterPasswordVisibilityToggled>(
      _onRegisterPasswordVisibilityToggled,
    );
    on<_RegisterSubmitted>(_onRegisterSubmitted);
    on<_LogoutRequested>(_onLogoutRequested);
    on<_RefreshRequested>(_onRefreshRequested);
    on<_ClearErrors>(_onClearErrors);
    on<_SessionExpired>(_onSessionExpired);
    on<_ClearSessionNotice>(_onClearSessionNotice);

    _sessionExpiredSubscription = sessionExpiredNotifier.stream.listen(
      (_) => add(const AuthEvent.sessionExpired()),
    );

    add(const AuthEvent.started());
  }

  final GetAuthStatus _getAuthStatus;
  final Login _login;
  final Register _register;
  final Logout _logout;
  final RefreshToken _refreshToken;
  late final StreamSubscription<void> _sessionExpiredSubscription;

  Future<void> _onStarted(_Started event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isCheckingStatus: true, errorMessage: null));

    try {
      final session = await _getAuthStatus();

      emit(
        state.copyWith(
          isCheckingStatus: false,
          status: session != null
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated,
          session: session,
        ),
      );
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('AuthBloc: Error checking status: $e');
      emit(
        state.copyWith(
          isCheckingStatus: false,
          status: AuthStatus.unauthenticated,
          session: null,
          errorMessage: _friendlyMessage(
            e,
            fallback: 'No pudimos verificar tu sesión.',
          ),
        ),
      );
    }
  }

  void _onLoginEmailChanged(_LoginEmailChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        loginEmail: event.email,
        loginErrorMessage: null,
        errorMessage: null,
      ),
    );
  }

  void _onLoginPasswordChanged(
    _LoginPasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        loginPassword: event.password,
        loginErrorMessage: null,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    _LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (state.isSubmittingLogin) return;

    final email = state.loginEmail.trim();
    final password = state.loginPassword;

    final emailError = validateEmail(email);
    if (emailError != null) {
      emit(state.copyWith(loginErrorMessage: emailError, errorMessage: null));
      return;
    }

    final passwordError = validatePasswordMin8(password);
    if (passwordError != null) {
      emit(
        state.copyWith(loginErrorMessage: passwordError, errorMessage: null),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmittingLogin: true,
        loginErrorMessage: null,
        errorMessage: null,
      ),
    );

    try {
      final session = await _login(email: email, password: password);
      emit(
        state.copyWith(
          isSubmittingLogin: false,
          status: AuthStatus.authenticated,
          session: session,
          loginPassword: '',
        ),
      );
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('AuthBloc: Login error: $e');
      emit(
        state.copyWith(
          isSubmittingLogin: false,
          loginErrorMessage: _friendlyMessage(
            e,
            fallback: 'No pudimos iniciar sesión. Intenta nuevamente.',
          ),
        ),
      );
    }
  }

  void _onRegisterEmailChanged(
    _RegisterEmailChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        registerEmail: event.email,
        registerErrorMessage: null,
        errorMessage: null,
      ),
    );
  }

  void _onRegisterPasswordChanged(
    _RegisterPasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        registerPassword: event.password,
        registerErrorMessage: null,
        errorMessage: null,
      ),
    );
  }

  void _onRegisterPasswordConfirmChanged(
    _RegisterPasswordConfirmChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        registerPasswordConfirm: event.confirmPassword,
        registerErrorMessage: null,
        errorMessage: null,
      ),
    );
  }

  void _onRegisterUsernameChanged(
    _RegisterUsernameChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        registerUsername: event.username,
        registerErrorMessage: null,
        errorMessage: null,
      ),
    );
  }

  void _onRegisterLocationChanged(
    _RegisterLocationChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        registerLocation: event.location,
        registerErrorMessage: null,
        errorMessage: null,
      ),
    );
  }

  void _onRegisterPasswordVisibilityToggled(
    _RegisterPasswordVisibilityToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        isRegisterPasswordVisible: !state.isRegisterPasswordVisible,
      ),
    );
  }

  Future<void> _onRegisterSubmitted(
    _RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (state.isSubmittingRegister) return;

    final email = state.registerEmail.trim();
    final password = state.registerPassword;
    final confirmPassword = state.registerPasswordConfirm;
    final username = state.registerUsername.trim();
    final location = state.registerLocation.trim();

    final usernameError = validateUsernameRequired(username);
    if (usernameError != null) {
      emit(
        state.copyWith(registerErrorMessage: usernameError, errorMessage: null),
      );
      return;
    }

    final emailError = validateEmail(email);
    if (emailError != null) {
      emit(
        state.copyWith(registerErrorMessage: emailError, errorMessage: null),
      );
      return;
    }

    final passwordError = validatePasswordMin8(password);
    if (passwordError != null) {
      emit(
        state.copyWith(registerErrorMessage: passwordError, errorMessage: null),
      );
      return;
    }

    final confirmationError = validatePasswordConfirmation(
      password: password,
      confirmation: confirmPassword,
    );
    if (confirmationError != null) {
      emit(
        state.copyWith(
          registerErrorMessage: confirmationError,
          errorMessage: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmittingRegister: true,
        registerErrorMessage: null,
        errorMessage: null,
      ),
    );

    try {
      final session = await _register(
        email: email,
        password: password,
        username: username,
        location: location.isEmpty ? null : location,
      );
      emit(
        state.copyWith(
          isSubmittingRegister: false,
          status: AuthStatus.authenticated,
          session: session,
          registerPassword: '',
          registerPasswordConfirm: '',
        ),
      );
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('AuthBloc: Register error: $e');
      emit(
        state.copyWith(
          isSubmittingRegister: false,
          registerErrorMessage: _friendlyMessage(
            e,
            fallback: 'No pudimos crear tu cuenta. Intenta nuevamente.',
          ),
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(errorMessage: null));
    try {
      await _logout();
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('AuthBloc: Logout error: $e');
    } finally {
      emit(state.copyWith(status: AuthStatus.unauthenticated, session: null));
    }
  }

  Future<void> _onRefreshRequested(
    _RefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (!state.isAuthenticated || state.session == null) return;

    try {
      final tokens = await _refreshToken();
      emit(state.copyWith(session: state.session!.copyWith(tokens: tokens)));
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('AuthBloc: Refresh error: $e');
      emit(
        state.copyWith(
          errorMessage: _friendlyMessage(
            e,
            fallback: 'Error al refrescar sesión.',
          ),
        ),
      );
    }
  }

  void _onClearErrors(_ClearErrors event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        errorMessage: null,
        loginErrorMessage: null,
        registerErrorMessage: null,
      ),
    );
  }

  void _onSessionExpired(_SessionExpired event, Emitter<AuthState> emit) {
    if (!state.isAuthenticated || state.sessionNotice != null) return;
    emit(
      state.copyWith(
        status: AuthStatus.unauthenticated,
        session: null,
        sessionNotice: const FeedbackNotice(
          message: 'Tu sesión expiró. Iniciá sesión nuevamente.',
          severity: FeedbackSeverity.warning,
        ),
      ),
    );
  }

  void _onClearSessionNotice(
    _ClearSessionNotice event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(sessionNotice: null));
  }

  @override
  Future<void> close() async {
    await _sessionExpiredSubscription.cancel();
    return super.close();
  }

  String _friendlyMessage(Object error, {required String fallback}) {
    if (error is DomainException) {
      return error.message;
    }
    final cleaned = _stripExceptionPrefix(error.toString());
    if (cleaned.isEmpty || cleaned == 'Exception') {
      return fallback;
    }
    return cleaned;
  }

  String _stripExceptionPrefix(String message) {
    var cleaned = message;
    const prefixes = [
      'Exception: ',
      'DomainException: ',
    ];
    for (final prefix in prefixes) {
      if (cleaned.startsWith(prefix)) {
        cleaned = cleaned.substring(prefix.length);
        break;
      }
    }
    final detailIndex = cleaned.indexOf(' (');
    if (detailIndex > 0) {
      cleaned = cleaned.substring(0, detailIndex);
    }
    return cleaned.trim();
  }
}
