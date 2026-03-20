import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/auth/session_expired_notifier.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/get_auth_status.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/logout.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/refresh_token.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
/// BLoC orchestrating authentication session state.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Creates an [AuthBloc] wired with session use cases.
  AuthBloc({
    required GetAuthStatus getAuthStatus,
    required Logout logout,
    required RefreshToken refreshToken,
    required SessionExpiredNotifier sessionExpiredNotifier,
  }) : _getAuthStatus = getAuthStatus,
       _logout = logout,
       _refreshToken = refreshToken,
       super(const AuthState()) {
    on<_Started>(_onStarted);
    on<_SessionObtained>(_onSessionObtained);
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
  final Logout _logout;
  final RefreshToken _refreshToken;
  late final StreamSubscription<void> _sessionExpiredSubscription;

  Future<void> _onStarted(_Started event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isCheckingStatus: true, feedbackNotice: null));

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
    } on DomainException catch (e) {
      if (kDebugMode) debugPrint('AuthBloc: Error checking status: $e');
      emit(
        state.copyWith(
          isCheckingStatus: false,
          status: AuthStatus.unauthenticated,
          session: null,
          feedbackNotice: FeedbackNotice(
            message: e.message,
            severity: FeedbackSeverity.error,
          ),
        ),
      );
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('AuthBloc: Error checking status: $e');
      emit(
        state.copyWith(
          isCheckingStatus: false,
          status: AuthStatus.unauthenticated,
          session: null,
          feedbackNotice: const FeedbackNotice(
            message: 'No pudimos verificar tu sesión.',
            severity: FeedbackSeverity.error,
          ),
        ),
      );
    }
  }

  void _onSessionObtained(
    _SessionObtained event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        status: AuthStatus.authenticated,
        session: event.session,
      ),
    );
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
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
    } on DomainException catch (e) {
      if (kDebugMode) debugPrint('AuthBloc: Refresh error: $e');
      emit(
        state.copyWith(
          feedbackNotice: FeedbackNotice(
            message: e.message,
            severity: FeedbackSeverity.error,
          ),
        ),
      );
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('AuthBloc: Refresh error: $e');
      emit(
        state.copyWith(
          feedbackNotice: const FeedbackNotice(
            message: 'Error al refrescar sesión.',
            severity: FeedbackSeverity.error,
          ),
        ),
      );
    }
  }

  void _onClearErrors(_ClearErrors event, Emitter<AuthState> emit) {
    emit(state.copyWith(feedbackNotice: null));
  }

  void _onSessionExpired(_SessionExpired event, Emitter<AuthState> emit) {
    if (!state.isAuthenticated || state.feedbackNotice != null) return;
    emit(
      state.copyWith(
        status: AuthStatus.unauthenticated,
        session: null,
        feedbackNotice: const FeedbackNotice(
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
    emit(state.copyWith(feedbackNotice: null));
  }

  @override
  Future<void> close() async {
    await _sessionExpiredSubscription.cancel();
    return super.close();
  }
}
