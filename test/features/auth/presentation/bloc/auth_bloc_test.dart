import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/auth/session_expired_notifier.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_tokens.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/get_auth_status.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/logout.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/refresh_token.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAuthStatus extends Mock implements GetAuthStatus {}

class MockLogout extends Mock implements Logout {}

class MockRefreshToken extends Mock implements RefreshToken {}

void main() {
  late GetAuthStatus getAuthStatus;
  late Logout logout;
  late RefreshToken refreshToken;
  late SessionExpiredNotifier sessionExpiredNotifier;

  const session = AuthSession(
    tokens: AuthTokens(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
    ),
    user: User(id: 'user-1', email: 'user@example.com', username: 'User One'),
  );

  setUp(() {
    getAuthStatus = MockGetAuthStatus();
    logout = MockLogout();
    refreshToken = MockRefreshToken();
    sessionExpiredNotifier = SessionExpiredNotifier();

    when(() => getAuthStatus()).thenAnswer((_) async => null);
  });

  AuthBloc buildBloc() => AuthBloc(
    getAuthStatus: getAuthStatus,
    logout: logout,
    refreshToken: refreshToken,
    sessionExpiredNotifier: sessionExpiredNotifier,
  );

  blocTest<AuthBloc, AuthState>(
    'emits unauthenticated when no session found on start',
    build: buildBloc,
    skip: 1,
    expect: () => [
      isA<AuthState>()
          .having(
            (s) => s.isCheckingStatus,
            'isCheckingStatus',
            false,
          )
          .having(
            (s) => s.status,
            'status',
            AuthStatus.unauthenticated,
          ),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits authenticated when session found on start',
    build: () {
      when(() => getAuthStatus()).thenAnswer((_) async => session);
      return buildBloc();
    },
    skip: 1,
    expect: () => [
      isA<AuthState>()
          .having(
            (s) => s.status,
            'status',
            AuthStatus.authenticated,
          )
          .having((s) => s.session, 'session', session),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits authenticated state when sessionObtained is added',
    build: buildBloc,
    act: (bloc) => bloc.add(const AuthEvent.sessionObtained(session)),
    skip: 2,
    expect: () => [
      isA<AuthState>()
          .having(
            (s) => s.status,
            'status',
            AuthStatus.authenticated,
          )
          .having((s) => s.session, 'session', session),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits unauthenticated state on logout',
    build: () {
      when(() => logout()).thenAnswer((_) async {});
      return buildBloc();
    },
    act: (bloc) => bloc
      ..add(const AuthEvent.sessionObtained(session))
      ..add(const AuthEvent.logoutRequested()),
    skip: 2,
    expect: () => [
      // sessionObtained -> authenticated
      isA<AuthState>().having(
        (s) => s.status,
        'status',
        AuthStatus.authenticated,
      ),
      // logoutRequested -> unauthenticated (clearErrors is deduplicated when
      // feedbackNotice is already null)
      isA<AuthState>().having(
        (s) => s.status,
        'status',
        AuthStatus.unauthenticated,
      ),
    ],
  );

  // Session expiry
  group('sessionExpired event', () {
    blocTest<AuthBloc, AuthState>(
      'emits unauthenticated and clears session when authenticated',
      build: () {
        when(() => getAuthStatus()).thenAnswer((_) async => session);
        return buildBloc();
      },
      act: (bloc) => bloc.add(const AuthEvent.sessionExpired()),
      skip: 2, // skip isCheckingStatus + authenticated from _onStarted
      expect: () => [
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.unauthenticated)
            .having((s) => s.session, 'session', isNull),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'is a no-op when already unauthenticated',
      build: buildBloc,
      // _onStarted resolves to unauthenticated (getAuthStatus returns null)
      act: (bloc) => bloc.add(const AuthEvent.sessionExpired()),
      skip: 2, // skip isCheckingStatus + unauthenticated from _onStarted
      expect: () => <AuthState>[], // no additional state change
    );

    blocTest<AuthBloc, AuthState>(
      'notifySessionExpired triggers unauthenticated via stream listener',
      build: () {
        when(() => getAuthStatus()).thenAnswer((_) async => session);
        return buildBloc();
      },
      act: (bloc) async {
        // Wait for _onStarted to settle before firing expiry
        await Future<void>.delayed(const Duration(milliseconds: 50));
        sessionExpiredNotifier.notifySessionExpired();
      },
      skip: 2,
      expect: () => [
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.unauthenticated)
            .having((s) => s.session, 'session', isNull),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'multiple notifySessionExpired calls only emit once',
      build: () {
        when(() => getAuthStatus()).thenAnswer((_) async => session);
        return buildBloc();
      },
      act: (bloc) async {
        await Future<void>.delayed(const Duration(milliseconds: 50));
        sessionExpiredNotifier
          ..notifySessionExpired()
          ..notifySessionExpired()
          ..notifySessionExpired();
      },
      skip: 2,
      expect: () => [
        isA<AuthState>().having(
          (s) => s.status,
          'status',
          AuthStatus.unauthenticated,
        ),
      ],
    );
  });
}
