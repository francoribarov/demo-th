import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/auth/register_page.dart';
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
            return BlocProvider<AuthBloc>.value(
              value: authBloc,
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

  testWidgets('dispatches submit and renders loading state', (tester) async {
    const initialState = AuthState(status: AuthStatus.unauthenticated);
    final submittingState = initialState.copyWith(isSubmittingRegister: true);

    final controller = StreamController<AuthState>();
    whenListen(authBloc, controller.stream, initialState: initialState);
    when(() => authBloc.state).thenReturn(initialState);

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

    verify(
      () => authBloc.add(const AuthEvent.registerUsernameChanged('User One')),
    ).called(1);
    verify(
      () => authBloc.add(
        const AuthEvent.registerEmailChanged('user@example.com'),
      ),
    ).called(1);
    verify(
      () =>
          authBloc.add(const AuthEvent.registerPasswordChanged('password123')),
    ).called(1);
    verify(
      () => authBloc.add(
        const AuthEvent.registerPasswordConfirmChanged('password123'),
      ),
    ).called(1);
    verify(() => authBloc.add(const AuthEvent.registerSubmitted())).called(1);

    controller.add(submittingState);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await controller.close();
  });

  testWidgets('validates required fields before submitting', (tester) async {
    const state = AuthState(status: AuthStatus.unauthenticated);
    whenListen(authBloc, const Stream<AuthState>.empty(), initialState: state);
    when(() => authBloc.state).thenReturn(state);

    await tester.pumpWidget(buildSubject());

    await tester.ensureVisible(find.byKey(const Key('registerSubmitButton')));
    await tester.tap(find.byKey(const Key('registerSubmitButton')));
    await tester.pump();

    expect(find.text('Ingresá tu nombre.'), findsOneWidget);
    expect(find.text('Ingresá tu email.'), findsOneWidget);
    expect(find.text('Ingresá tu contraseña.'), findsOneWidget);
    expect(find.text('Repetí tu contraseña para continuar.'), findsOneWidget);
    verifyNever(() => authBloc.add(const AuthEvent.registerSubmitted()));
  });

  testWidgets('ya tengo cuenta navigates to login preserving from query', (
    tester,
  ) async {
    const state = AuthState(status: AuthStatus.unauthenticated);
    whenListen(authBloc, const Stream<AuthState>.empty(), initialState: state);
    when(() => authBloc.state).thenReturn(state);

    await tester.pumpWidget(
      buildRoutedSubject(initialLocation: '/register?from=%2Fpublish'),
    );

    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Iniciá sesión'));
    await tester.tap(find.text('Iniciá sesión'));
    await tester.pumpAndSettle();

    expect(find.text('login:/publish'), findsOneWidget);
  });
}
