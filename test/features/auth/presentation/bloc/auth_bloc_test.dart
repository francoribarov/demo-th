import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
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

    when(() => getAuthStatus()).thenAnswer((_) async => null);
  });

  AuthBloc buildBloc() => AuthBloc(
    getAuthStatus: getAuthStatus,
    logout: logout,
    refreshToken: refreshToken,
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
}
