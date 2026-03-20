import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_tokens.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/register.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/register/register_cubit.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';
import 'package:mocktail/mocktail.dart';

class MockRegister extends Mock implements Register {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late Register register;
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
    registerFallbackValue(const RegisterState());
  });

  setUp(() {
    register = MockRegister();
    authBloc = MockAuthBloc();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: const AuthState(),
    );
  });

  RegisterCubit buildCubit() => RegisterCubit(
    register: register,
    authBloc: authBloc,
  );

  group('RegisterCubit', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits errorMessage when username empty on submit',
      build: buildCubit,
      act: (cubit) async {
        cubit
          ..usernameChanged('')
          ..emailChanged('user@example.com')
          ..passwordChanged('password123')
          ..passwordConfirmChanged('password123');
        await cubit.submit();
      },
      skip: 4,
      expect: () => [
        isA<RegisterState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          'Ingresá tu nombre.',
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits errorMessage when email invalid on submit',
      build: buildCubit,
      act: (cubit) async {
        cubit
          ..usernameChanged('User One')
          ..emailChanged('invalid-email')
          ..passwordChanged('password123')
          ..passwordConfirmChanged('password123');
        await cubit.submit();
      },
      skip: 4,
      expect: () => [
        isA<RegisterState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          'Ingresá un email válido.',
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits errorMessage when password too short on submit',
      build: buildCubit,
      act: (cubit) async {
        cubit
          ..usernameChanged('User One')
          ..emailChanged('user@example.com')
          ..passwordChanged('123')
          ..passwordConfirmChanged('123');
        await cubit.submit();
      },
      skip: 4,
      expect: () => [
        isA<RegisterState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          contains('8 caracteres'),
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits errorMessage when passwords do not match on submit',
      build: buildCubit,
      act: (cubit) async {
        cubit
          ..usernameChanged('User One')
          ..emailChanged('user@example.com')
          ..passwordChanged('password123')
          ..passwordConfirmChanged('different');
        await cubit.submit();
      },
      skip: 4,
      expect: () => [
        isA<RegisterState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          'Las contraseñas no coinciden.',
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'calls Register use case and adds sessionObtained to AuthBloc on success',
      build: buildCubit,
      act: (cubit) async {
        when(
          () => register(
            email: any(named: 'email'),
            password: any(named: 'password'),
            username: any(named: 'username'),
            location: any(named: 'location'),
          ),
        ).thenAnswer((_) async => session);
        cubit
          ..usernameChanged('User One')
          ..emailChanged('user@example.com')
          ..passwordChanged('password123')
          ..passwordConfirmChanged('password123');
        await cubit.submit();
      },
      verify: (_) {
        verify(
          () => register(
            email: 'user@example.com',
            password: 'password123',
            username: 'User One',
          ),
        ).called(1);
        verify(
          () => authBloc.add(const AuthEvent.sessionObtained(session)),
        ).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      'passes null location when location is blank whitespace',
      build: buildCubit,
      act: (cubit) async {
        when(
          () => register(
            email: any(named: 'email'),
            password: any(named: 'password'),
            username: any(named: 'username'),
            location: any(named: 'location'),
          ),
        ).thenAnswer((_) async => session);
        cubit
          ..usernameChanged('User One')
          ..emailChanged('user@example.com')
          ..passwordChanged('password123')
          ..passwordConfirmChanged('password123')
          ..locationChanged('   ');
        await cubit.submit();
      },
      verify: (_) {
        verify(
          () => register(
            email: 'user@example.com',
            password: 'password123',
            username: 'User One',
            // Explicit null verifies whitespace location is coerced to null.
            location: null, // ignore: avoid_redundant_argument_values
          ),
        ).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits feedbackNotice when DomainException on submit',
      build: buildCubit,
      act: (cubit) async {
        when(
          () => register(
            email: any(named: 'email'),
            password: any(named: 'password'),
            username: any(named: 'username'),
            location: any(named: 'location'),
          ),
        ).thenThrow(const DomainException(message: 'Email ya en uso'));
        cubit
          ..usernameChanged('User One')
          ..emailChanged('user@example.com')
          ..passwordChanged('password123')
          ..passwordConfirmChanged('password123');
        await cubit.submit();
      },
      skip: 5,
      expect: () => [
        isA<RegisterState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having(
              (s) => s.feedbackNotice?.message,
              'feedbackNotice.message',
              'Email ya en uso',
            )
            .having(
              (s) => s.feedbackNotice?.severity,
              'feedbackNotice.severity',
              FeedbackSeverity.error,
            ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits feedbackNotice when generic Exception on submit',
      build: buildCubit,
      act: (cubit) async {
        when(
          () => register(
            email: any(named: 'email'),
            password: any(named: 'password'),
            username: any(named: 'username'),
            location: any(named: 'location'),
          ),
        ).thenThrow(Exception('Network error'));
        cubit
          ..usernameChanged('User One')
          ..emailChanged('user@example.com')
          ..passwordChanged('password123')
          ..passwordConfirmChanged('password123');
        await cubit.submit();
      },
      skip: 5,
      expect: () => [
        isA<RegisterState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having(
              (s) => s.feedbackNotice?.message,
              'feedbackNotice.message',
              'No pudimos crear tu cuenta. Intenta nuevamente.',
            )
            .having(
              (s) => s.feedbackNotice?.severity,
              'feedbackNotice.severity',
              FeedbackSeverity.error,
            ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'clearNotice clears feedbackNotice',
      build: buildCubit,
      seed: () => const RegisterState(
        feedbackNotice: FeedbackNotice(
          message: 'Error',
          severity: FeedbackSeverity.error,
        ),
      ),
      act: (cubit) => cubit.clearNotice(),
      expect: () => [
        isA<RegisterState>().having(
          (s) => s.feedbackNotice,
          'feedbackNotice',
          isNull,
        ),
      ],
    );
  });
}
