import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/l10n/app_strings.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_tokens.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/get_auth_status.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/login.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/logout.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/refresh_token.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/register.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAuthStatus extends Mock implements GetAuthStatus {}

class MockLogin extends Mock implements Login {}

class MockRegister extends Mock implements Register {}

class MockLogout extends Mock implements Logout {}

class MockRefreshToken extends Mock implements RefreshToken {}

void main() {
  late GetAuthStatus getAuthStatus;
  late Login login;
  late Register register;
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
    login = MockLogin();
    register = MockRegister();
    logout = MockLogout();
    refreshToken = MockRefreshToken();

    when(() => getAuthStatus()).thenAnswer((_) async => null);
  });

  AuthBloc buildBloc() => AuthBloc(
    getAuthStatus: getAuthStatus,
    login: login,
    register: register,
    logout: logout,
    refreshToken: refreshToken,
  );

  blocTest<AuthBloc, AuthState>(
    'emits authenticated state on login success',
    build: () {
      when(
        () => login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => session);
      return buildBloc();
    },
    act: (bloc) => bloc
      ..add(const AuthEvent.loginEmailChanged('user@example.com'))
      ..add(const AuthEvent.loginPasswordChanged('password123'))
      ..add(const AuthEvent.loginSubmitted()),
    skip: 4,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.isSubmittingLogin,
        'isSubmittingLogin',
        true,
      ),
      isA<AuthState>()
          .having(
            (state) => state.isSubmittingLogin,
            'isSubmittingLogin',
            false,
          )
          .having((state) => state.status, 'status', AuthStatus.authenticated)
          .having((state) => state.session, 'session', session),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits error on login failure',
    build: () {
      when(
        () => login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception('Invalid'));
      return buildBloc();
    },
    act: (bloc) => bloc
      ..add(const AuthEvent.loginEmailChanged('user@example.com'))
      ..add(const AuthEvent.loginPasswordChanged('password123'))
      ..add(const AuthEvent.loginSubmitted()),
    skip: 4,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.isSubmittingLogin,
        'isSubmittingLogin',
        true,
      ),
      isA<AuthState>()
          .having(
            (state) => state.isSubmittingLogin,
            'isSubmittingLogin',
            false,
          )
          .having(
            (state) => state.loginErrorMessage,
            'loginErrorMessage',
            contains('Invalid'),
          ),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits validation error on invalid login email without calling login',
    build: buildBloc,
    act: (bloc) => bloc
      ..add(const AuthEvent.loginEmailChanged('correo-invalido'))
      ..add(const AuthEvent.loginPasswordChanged('password123'))
      ..add(const AuthEvent.loginSubmitted()),
    skip: 4,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.loginErrorMessage,
        'loginErrorMessage',
        AppStrings.authEmailInvalid,
      ),
    ],
    verify: (_) {
      verifyNever(
        () => login(
          email: 'correo-invalido',
          password: 'password123',
        ),
      );
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits authenticated state on register success',
    build: () {
      when(
        () => register(
          email: any(named: 'email'),
          password: any(named: 'password'),
          username: any(named: 'username'),
          location: any(named: 'location'),
        ),
      ).thenAnswer((_) async => session);
      return buildBloc();
    },
    act: (bloc) => bloc
      ..add(const AuthEvent.registerEmailChanged('user@example.com'))
      ..add(const AuthEvent.registerPasswordChanged('password123'))
      ..add(const AuthEvent.registerPasswordConfirmChanged('password123'))
      ..add(const AuthEvent.registerUsernameChanged('User One'))
      ..add(const AuthEvent.registerLocationChanged('Montevideo'))
      ..add(const AuthEvent.registerSubmitted()),
    skip: 7,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.isSubmittingRegister,
        'isSubmittingRegister',
        true,
      ),
      isA<AuthState>()
          .having(
            (state) => state.isSubmittingRegister,
            'isSubmittingRegister',
            false,
          )
          .having((state) => state.status, 'status', AuthStatus.authenticated)
          .having((state) => state.session, 'session', session)
          .having((state) => state.registerPassword, 'registerPassword', ''),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'registers with null location when location input is blank',
    build: () {
      when(
        () => register(
          email: any(named: 'email'),
          password: any(named: 'password'),
          username: any(named: 'username'),
          location: any(named: 'location'),
        ),
      ).thenAnswer((_) async => session);
      return buildBloc();
    },
    act: (bloc) => bloc
      ..add(const AuthEvent.registerEmailChanged('user@example.com'))
      ..add(const AuthEvent.registerPasswordChanged('password123'))
      ..add(const AuthEvent.registerPasswordConfirmChanged('password123'))
      ..add(const AuthEvent.registerUsernameChanged('User One'))
      ..add(const AuthEvent.registerLocationChanged('   '))
      ..add(const AuthEvent.registerSubmitted()),
    skip: 7,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.isSubmittingRegister,
        'isSubmittingRegister',
        true,
      ),
      isA<AuthState>()
          .having(
            (state) => state.isSubmittingRegister,
            'isSubmittingRegister',
            false,
          )
          .having((state) => state.status, 'status', AuthStatus.authenticated)
          .having((state) => state.session, 'session', session),
    ],
    verify: (_) {
      final capturedLocation = verify(
        () => register(
          email: 'user@example.com',
          password: 'password123',
          username: 'User One',
          location: captureAny(named: 'location'),
        ),
      ).captured.single;
      expect(capturedLocation, isNull);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits validation error when register passwords do not match',
    build: buildBloc,
    act: (bloc) => bloc
      ..add(const AuthEvent.registerEmailChanged('user@example.com'))
      ..add(const AuthEvent.registerPasswordChanged('password123'))
      ..add(const AuthEvent.registerPasswordConfirmChanged('different123'))
      ..add(const AuthEvent.registerUsernameChanged('User One'))
      ..add(const AuthEvent.registerSubmitted()),
    skip: 6,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.registerErrorMessage,
        'registerErrorMessage',
        AppStrings.authPasswordsDontMatch,
      ),
    ],
    verify: (_) {
      verifyNever(
        () => register(
          email: 'user@example.com',
          password: 'password123',
          username: 'User One',
        ),
      );
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits error on register failure',
    build: () {
      when(
        () => register(
          email: any(named: 'email'),
          password: any(named: 'password'),
          username: any(named: 'username'),
          location: any(named: 'location'),
        ),
      ).thenThrow(Exception('Register failed'));
      return buildBloc();
    },
    act: (bloc) => bloc
      ..add(const AuthEvent.registerEmailChanged('user@example.com'))
      ..add(const AuthEvent.registerPasswordChanged('password123'))
      ..add(const AuthEvent.registerPasswordConfirmChanged('password123'))
      ..add(const AuthEvent.registerUsernameChanged('User One'))
      ..add(const AuthEvent.registerLocationChanged('Montevideo'))
      ..add(const AuthEvent.registerSubmitted()),
    skip: 7,
    expect: () => [
      isA<AuthState>().having(
        (state) => state.isSubmittingRegister,
        'isSubmittingRegister',
        true,
      ),
      isA<AuthState>()
          .having(
            (state) => state.isSubmittingRegister,
            'isSubmittingRegister',
            false,
          )
          .having(
            (state) => state.registerErrorMessage,
            'registerErrorMessage',
            contains('Register failed'),
          ),
    ],
  );
}
