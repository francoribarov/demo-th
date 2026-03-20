import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/login/login_cubit.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';
import 'package:mobile_table_hopping/presentation/pages/auth/login_page.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  late MockAuthBloc authBloc;
  late MockLoginCubit loginCubit;

  setUpAll(() {
    registerFallbackValue(const AuthEvent.started());
    registerFallbackValue(const AuthState());
    registerFallbackValue(const LoginState());
  });

  setUp(() {
    authBloc = MockAuthBloc();
    loginCubit = MockLoginCubit();

    when(() => loginCubit.submit()).thenAnswer((_) async {});
  });

  Widget buildSubject({String? from}) {
    return MaterialApp(
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<LoginCubit>.value(value: loginCubit),
          ],
          child: LoginPage(from: from),
        ),
      ),
    );
  }

  Widget buildRoutedSubject({required String initialLocation}) {
    final router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) {
            final from = state.uri.queryParameters['from'];
            return MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>.value(value: authBloc),
                BlocProvider<LoginCubit>.value(value: loginCubit),
              ],
              child: LoginPage(from: from),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) {
            final from = state.uri.queryParameters['from'] ?? '';
            return Scaffold(body: Text('register:$from'));
          },
        ),
      ],
    );

    return MaterialApp.router(routerConfig: router);
  }

  testWidgets('renders email and password fields directly', (tester) async {
    const authState = AuthState(status: AuthStatus.unauthenticated);
    const loginState = LoginState();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: authState,
    );
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      loginCubit,
      const Stream<LoginState>.empty(),
      initialState: loginState,
    );
    when(() => loginCubit.state).thenReturn(loginState);

    await tester.pumpWidget(buildSubject());

    verify(() => authBloc.add(const AuthEvent.clearErrors())).called(1);
    expect(find.byKey(const Key('loginEmailField')), findsOneWidget);
    expect(find.byKey(const Key('loginPasswordField')), findsOneWidget);
    expect(find.byKey(const Key('loginSubmitButton')), findsOneWidget);
  });

  testWidgets('dispatches to LoginCubit and renders loading and error states', (
    tester,
  ) async {
    const authState = AuthState(status: AuthStatus.unauthenticated);
    const initialLoginState = LoginState();
    final submittingState = const LoginState().copyWith(isSubmitting: true);
    final errorState = const LoginState().copyWith(
      feedbackNotice: const FeedbackNotice(
        message: 'Login failed',
        severity: FeedbackSeverity.error,
      ),
    );

    final loginController = StreamController<LoginState>();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: authState,
    );
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      loginCubit,
      loginController.stream,
      initialState: initialLoginState,
    );
    when(() => loginCubit.state).thenReturn(initialLoginState);

    await tester.pumpWidget(buildSubject());

    await tester.enterText(
      find.byKey(const Key('loginEmailField')),
      'user@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('loginPasswordField')),
      'password123',
    );
    await tester.tap(find.byKey(const Key('loginSubmitButton')));

    verify(() => loginCubit.emailChanged('user@example.com')).called(1);
    verify(() => loginCubit.passwordChanged('password123')).called(1);
    verify(() => loginCubit.submit()).called(1);

    loginController.add(submittingState);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    loginController.add(errorState);
    await tester.pump();
    expect(find.text('Login failed'), findsOneWidget);
    verify(() => loginCubit.clearNotice()).called(1);

    await loginController.close();
  });

  testWidgets('validates invalid email and password before submitting', (
    tester,
  ) async {
    const authState = AuthState(status: AuthStatus.unauthenticated);
    const loginState = LoginState();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: authState,
    );
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      loginCubit,
      const Stream<LoginState>.empty(),
      initialState: loginState,
    );
    when(() => loginCubit.state).thenReturn(loginState);

    await tester.pumpWidget(buildSubject());

    await tester.enterText(
      find.byKey(const Key('loginEmailField')),
      'correo-invalido',
    );
    await tester.enterText(find.byKey(const Key('loginPasswordField')), '123');
    await tester.tap(find.byKey(const Key('loginSubmitButton')));
    await tester.pump();

    expect(find.text('Ingresá un email válido.'), findsOneWidget);
    expect(
      find.text('La contraseña debe tener al menos 8 caracteres.'),
      findsOneWidget,
    );
    verifyNever(() => loginCubit.submit());
  });

  testWidgets('toggles password visibility icon', (tester) async {
    const authState = AuthState(status: AuthStatus.unauthenticated);
    const loginState = LoginState();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: authState,
    );
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      loginCubit,
      const Stream<LoginState>.empty(),
      initialState: loginState,
    );
    when(() => loginCubit.state).thenReturn(loginState);

    await tester.pumpWidget(buildSubject());

    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    await tester.tap(find.byKey(const Key('loginPasswordVisibilityButton')));
    await tester.pump();

    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });

  testWidgets('register switch row navigates to register preserving from', (
    tester,
  ) async {
    const authState = AuthState(status: AuthStatus.unauthenticated);
    const loginState = LoginState();
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: authState,
    );
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      loginCubit,
      const Stream<LoginState>.empty(),
      initialState: loginState,
    );
    when(() => loginCubit.state).thenReturn(loginState);

    await tester.pumpWidget(
      buildRoutedSubject(initialLocation: '/login?from=%2Fpublish'),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('Registrate'));
    await tester.pumpAndSettle();

    expect(find.text('register:/publish'), findsOneWidget);
  });
}
