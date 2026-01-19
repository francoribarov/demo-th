import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_table_hopping/features/auth/presentation/pages/login_page.dart';
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

  tearDown(() async {
    await authBloc.close();
  });

  Widget buildSubject() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<AuthBloc>.value(
          value: authBloc,
          child: const LoginPage(),
        ),
      ),
    );
  }

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

    await tester.tap(find.widgetWithText(ElevatedButton, 'Ingresar'));
    verify(() => authBloc.add(const AuthEvent.loginSubmitted())).called(1);

    controller.add(submittingState);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    controller.add(errorState);
    await tester.pump();
    expect(find.text('Login failed'), findsOneWidget);

    await controller.close();
  });
}
