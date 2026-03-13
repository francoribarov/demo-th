import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/register/register_cubit.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';
import 'package:mobile_table_hopping/presentation/pages/auth/register_page.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockRegisterCubit extends MockCubit<RegisterState> implements RegisterCubit {}

void main() {
  late MockAuthBloc authBloc;
  late MockRegisterCubit registerCubit;

  setUpAll(() {
    registerFallbackValue(const AuthEvent.started());
    registerFallbackValue(const AuthState());
    registerFallbackValue(const RegisterState());
  });

  setUp(() {
    authBloc = MockAuthBloc();
    registerCubit = MockRegisterCubit();

    when(() => registerCubit.submit()).thenAnswer((_) async {});
  });

  Widget buildSubject({String? from}) {
    return MaterialApp(
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<RegisterCubit>.value(value: registerCubit),
          ],
          child: RegisterPage(from: from),
        ),
      ),
    );
  }

  Widget buildRoutedSubject({required String initialLocation}) {
    final router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) {
            final from = state.uri.queryParameters['from'];
            return MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>.value(value: authBloc),
                BlocProvider<RegisterCubit>.value(value: registerCubit),
              ],
              child: RegisterPage(from: from),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) {
            final from = state.uri.queryParameters['from'] ?? '';
            return Scaffold(body: Text('login:$from'));
          },
        ),
      ],
    );

    return MaterialApp.router(routerConfig: router);
  }

  testWidgets('dispatches to RegisterCubit and renders loading state', (
    tester,
  ) async {
    const authState = AuthState(status: AuthStatus.unauthenticated);
    const initialRegisterState = RegisterState();
    final submittingState = const RegisterState().copyWith(isSubmitting: true);

    final registerController = StreamController<RegisterState>();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: authState,
    );
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      registerCubit,
      registerController.stream,
      initialState: initialRegisterState,
    );
    when(() => registerCubit.state).thenReturn(initialRegisterState);

    await tester.pumpWidget(buildSubject());

    verify(() => authBloc.add(const AuthEvent.clearErrors())).called(1);

    await tester.enterText(
      find.byKey(const Key('registerNameField')),
      'User One',
    );
    await tester.enterText(
      find.byKey(const Key('registerEmailField')),
      'user@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('registerPasswordField')),
      'password123',
    );
    await tester.enterText(
      find.byKey(const Key('registerConfirmPasswordField')),
      'password123',
    );

    await tester.ensureVisible(find.byKey(const Key('registerSubmitButton')));
    await tester.tap(find.byKey(const Key('registerSubmitButton')));

    verify(() => registerCubit.usernameChanged('User One')).called(1);
    verify(() => registerCubit.emailChanged('user@example.com')).called(1);
    verify(() => registerCubit.passwordChanged('password123')).called(1);
    verify(() => registerCubit.passwordConfirmChanged('password123')).called(1);
    verify(() => registerCubit.submit()).called(1);

    registerController.add(submittingState);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await registerController.close();
  });

  testWidgets('validates required fields before submitting', (tester) async {
    const authState = AuthState(status: AuthStatus.unauthenticated);
    const registerState = RegisterState();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: authState,
    );
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      registerCubit,
      const Stream<RegisterState>.empty(),
      initialState: registerState,
    );
    when(() => registerCubit.state).thenReturn(registerState);

    await tester.pumpWidget(buildSubject());

    await tester.ensureVisible(find.byKey(const Key('registerSubmitButton')));
    await tester.tap(find.byKey(const Key('registerSubmitButton')));
    await tester.pump();

    expect(find.text('Ingresá tu nombre.'), findsOneWidget);
    expect(find.text('Ingresá tu email.'), findsOneWidget);
    expect(find.text('Ingresá tu contraseña.'), findsOneWidget);
    expect(find.text('Repetí tu contraseña para continuar.'), findsOneWidget);
    verifyNever(() => registerCubit.submit());
  });

  testWidgets('validates password confirmation before submitting', (
    tester,
  ) async {
    const authState = AuthState(status: AuthStatus.unauthenticated);
    const registerState = RegisterState();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: authState,
    );
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      registerCubit,
      const Stream<RegisterState>.empty(),
      initialState: registerState,
    );
    when(() => registerCubit.state).thenReturn(registerState);

    await tester.pumpWidget(buildSubject());

    await tester.enterText(find.byKey(const Key('registerNameField')), 'User');
    await tester.enterText(
      find.byKey(const Key('registerEmailField')),
      'user@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('registerPasswordField')),
      'password123',
    );
    await tester.enterText(
      find.byKey(const Key('registerConfirmPasswordField')),
      'different123',
    );
    await tester.ensureVisible(find.byKey(const Key('registerSubmitButton')));
    await tester.tap(find.byKey(const Key('registerSubmitButton')));
    await tester.pump();

    expect(find.text('Las contraseñas no coinciden.'), findsOneWidget);
    verifyNever(() => registerCubit.submit());
  });

  testWidgets(
    'shows snackbar and calls clearNotice when feedbackNotice emitted',
    (
      tester,
    ) async {
      const authState = AuthState(status: AuthStatus.unauthenticated);
      const initialRegisterState = RegisterState();
      final errorState = const RegisterState().copyWith(
        feedbackNotice: const FeedbackNotice(
          message: 'Registration failed',
          severity: FeedbackSeverity.error,
        ),
      );

      final registerController = StreamController<RegisterState>();
      whenListen(
        authBloc,
        const Stream<AuthState>.empty(),
        initialState: authState,
      );
      when(() => authBloc.state).thenReturn(authState);
      whenListen(
        registerCubit,
        registerController.stream,
        initialState: initialRegisterState,
      );
      when(() => registerCubit.state).thenReturn(initialRegisterState);

      await tester.pumpWidget(buildSubject());

      registerController.add(errorState);
      await tester.pump();
      expect(find.text('Registration failed'), findsOneWidget);
      verify(() => registerCubit.clearNotice()).called(1);

      await registerController.close();
    },
  );

  testWidgets('ya tengo cuenta navigates to login preserving from query', (
    tester,
  ) async {
    const authState = AuthState(status: AuthStatus.unauthenticated);
    const registerState = RegisterState();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: authState,
    );
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      registerCubit,
      const Stream<RegisterState>.empty(),
      initialState: registerState,
    );
    when(() => registerCubit.state).thenReturn(registerState);

    await tester.pumpWidget(
      buildRoutedSubject(initialLocation: '/register?from=%2Fpublish'),
    );

    await tester.pumpAndSettle();
    final goToLoginAction = find.text('Iniciá sesión');
    await tester.ensureVisible(goToLoginAction);
    await tester.tap(goToLoginAction);
    await tester.pumpAndSettle();

    expect(find.text('login:/publish'), findsOneWidget);
  });
}
