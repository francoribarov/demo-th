import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_tokens.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/login.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/login/login_cubit.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';
import 'package:mocktail/mocktail.dart';

class MockLogin extends Mock implements Login {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late Login login;
  late AuthBloc authBloc;

  const session = AuthSession(
    tokens: AuthTokens(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
    ),
    user: User(id: 'user-1', email: 'user@example.com', username: 'User One'),
  );

  setUpAll(() {
    registerFallbackValue(const AuthEvent.started());
    registerFallbackValue(const AuthState());
    registerFallbackValue(const LoginState());
  });

  setUp(() {
    login = MockLogin();
    authBloc = MockAuthBloc();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: const AuthState(),
    );
  });

  LoginCubit buildCubit() => LoginCubit(login: login, authBloc: authBloc);

  group('LoginCubit', () {
    blocTest<LoginCubit, LoginState>(
      'emits errorMessage when email invalid on submit',
      build: buildCubit,
      act: (cubit) async {
        cubit
          ..emailChanged('invalid-email')
          ..passwordChanged('password123');
        await cubit.submit();
      },
      skip: 2,
      expect: () => [
        isA<LoginState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          'Ingresá un email válido.',
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits errorMessage when password too short on submit',
      build: buildCubit,
      act: (cubit) async {
        cubit
          ..emailChanged('user@example.com')
          ..passwordChanged('123');
        await cubit.submit();
      },
      skip: 2,
      expect: () => [
        isA<LoginState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          contains('8 caracteres'),
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'calls Login use case and adds sessionObtained to AuthBloc on success',
      build: buildCubit,
      act: (cubit) async {
        when(
          () => login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => session);
        cubit
          ..emailChanged('user@example.com')
          ..passwordChanged('password123');
        await cubit.submit();
      },
      verify: (_) {
        verify(
          () => login(email: 'user@example.com', password: 'password123'),
        ).called(1);
        verify(
          () => authBloc.add(const AuthEvent.sessionObtained(session)),
        ).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits feedbackNotice when DomainException on submit',
      build: buildCubit,
      act: (cubit) async {
        when(
          () => login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const DomainException(message: 'Credenciales inválidas'));
        cubit
          ..emailChanged('user@example.com')
          ..passwordChanged('password123');
        await cubit.submit();
      },
      skip: 3,
      expect: () => [
        isA<LoginState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having(
              (s) => s.feedbackNotice?.message,
              'feedbackNotice.message',
              'Credenciales inválidas',
            )
            .having(
              (s) => s.feedbackNotice?.severity,
              'feedbackNotice.severity',
              FeedbackSeverity.error,
            ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits feedbackNotice when generic Exception on submit',
      build: buildCubit,
      act: (cubit) async {
        when(
          () => login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception('Network error'));
        cubit
          ..emailChanged('user@example.com')
          ..passwordChanged('password123');
        await cubit.submit();
      },
      skip: 3,
      expect: () => [
        isA<LoginState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having(
              (s) => s.feedbackNotice?.message,
              'feedbackNotice.message',
              'No pudimos iniciar sesión. Intenta nuevamente.',
            )
            .having(
              (s) => s.feedbackNotice?.severity,
              'feedbackNotice.severity',
              FeedbackSeverity.error,
            ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emailChanged clears errorMessage',
      build: buildCubit,
      seed: () => const LoginState(errorMessage: 'Some error'),
      act: (cubit) => cubit.emailChanged('new@email.com'),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.email, 'email', 'new@email.com')
            .having((s) => s.errorMessage, 'errorMessage', isNull),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'passwordChanged clears errorMessage',
      build: buildCubit,
      seed: () => const LoginState(errorMessage: 'Some error'),
      act: (cubit) => cubit.passwordChanged('newpassword'),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.password, 'password', 'newpassword')
            .having((s) => s.errorMessage, 'errorMessage', isNull),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'clearNotice clears feedbackNotice',
      build: buildCubit,
      seed: () => const LoginState(
        feedbackNotice: FeedbackNotice(
          message: 'Error',
          severity: FeedbackSeverity.error,
        ),
      ),
      act: (cubit) => cubit.clearNotice(),
      expect: () => [
        isA<LoginState>().having(
          (s) => s.feedbackNotice,
          'feedbackNotice',
          isNull,
        ),
      ],
    );
  });
}
