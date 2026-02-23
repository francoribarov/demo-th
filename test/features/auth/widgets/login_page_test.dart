import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/l10n/app_strings.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/auth/login_page.dart';
import 'package:mobile_table_hopping/presentation/widgets/auth/auth_error_text.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc authBloc;

  setUpAll(() {
    registerFallbackValue(const AuthEvent.started());
    registerFallbackValue(const AuthState());
  });

  setUp(() {
    authBloc = MockAuthBloc();
  });

  Widget buildSubject({String? from}) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<AuthBloc>.value(
          value: authBloc,
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
            return BlocProvider<AuthBloc>.value(
              value: authBloc,
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
    const state = AuthState(status: AuthStatus.unauthenticated);
    whenListen(authBloc, const Stream<AuthState>.empty(), initialState: state);
    when(() => authBloc.state).thenReturn(state);

    await tester.pumpWidget(buildSubject());

    verify(() => authBloc.add(const AuthEvent.clearErrors())).called(1);
    expect(find.byKey(const Key('loginEmailField')), findsOneWidget);
    expect(find.byKey(const Key('loginPasswordField')), findsOneWidget);
    expect(find.byKey(const Key('loginSubmitButton')), findsOneWidget);
  });

  testWidgets('dispatches submit and renders loading and error states', (
    tester,
  ) async {
    const initialState = AuthState(status: AuthStatus.unauthenticated);
    final submittingState = initialState.copyWith(isSubmittingLogin: true);
    final errorState = initialState.copyWith(loginErrorMessage: 'Login failed');

    final controller = StreamController<AuthState>();
    whenListen(authBloc, controller.stream, initialState: initialState);
    when(() => authBloc.state).thenReturn(initialState);

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

    verify(
      () => authBloc.add(const AuthEvent.loginEmailChanged('user@example.com')),
    ).called(1);
    verify(
      () => authBloc.add(const AuthEvent.loginPasswordChanged('password123')),
    ).called(1);
    verify(() => authBloc.add(const AuthEvent.loginSubmitted())).called(1);

    controller.add(submittingState);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    controller.add(errorState);
    await tester.pump();
    expect(find.text('Login failed'), findsOneWidget);

    await controller.close();
  });

  testWidgets('validates invalid email and password before submitting', (
    tester,
  ) async {
    const state = AuthState(status: AuthStatus.unauthenticated);
    whenListen(authBloc, const Stream<AuthState>.empty(), initialState: state);
    when(() => authBloc.state).thenReturn(state);

    await tester.pumpWidget(buildSubject());

    await tester.enterText(
      find.byKey(const Key('loginEmailField')),
      'correo-invalido',
    );
    await tester.enterText(find.byKey(const Key('loginPasswordField')), '123');
    await tester.tap(find.byKey(const Key('loginSubmitButton')));
    await tester.pump();

    expect(find.text(AppStrings.authEmailInvalid), findsOneWidget);
    expect(find.text(AppStrings.authPasswordTooShort), findsOneWidget);
    verifyNever(() => authBloc.add(const AuthEvent.loginSubmitted()));
  });

  testWidgets('toggles password visibility icon', (tester) async {
    const state = AuthState(status: AuthStatus.unauthenticated);
    whenListen(authBloc, const Stream<AuthState>.empty(), initialState: state);
    when(() => authBloc.state).thenReturn(state);

    await tester.pumpWidget(buildSubject());

    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    await tester.tap(find.byKey(const Key('loginPasswordVisibilityButton')));
    await tester.pump();

    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });

  testWidgets('renders only one consolidated error message', (tester) async {
    const state = AuthState(
      status: AuthStatus.unauthenticated,
      loginErrorMessage: 'Login failed',
      errorMessage: 'Unexpected error',
    );
    whenListen(authBloc, const Stream<AuthState>.empty(), initialState: state);
    when(() => authBloc.state).thenReturn(state);

    await tester.pumpWidget(buildSubject());

    expect(find.byType(AuthErrorText), findsOneWidget);
    expect(find.text('Login failed'), findsOneWidget);
    expect(find.text('Unexpected error'), findsNothing);
  });

  testWidgets('register switch row navigates to register preserving from', (
    tester,
  ) async {
    const state = AuthState(status: AuthStatus.unauthenticated);
    whenListen(authBloc, const Stream<AuthState>.empty(), initialState: state);
    when(() => authBloc.state).thenReturn(state);

    await tester.pumpWidget(
      buildRoutedSubject(initialLocation: '/login?from=%2Fpublish'),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.authLoginSwitchAction));
    await tester.pumpAndSettle();

    expect(find.text('register:/publish'), findsOneWidget);
  });
}
