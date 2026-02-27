import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/di/injection.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/widgets/templates/app_scaffold.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc authBloc;

  setUpAll(() {
    registerFallbackValue(const AuthEvent.started());
    registerFallbackValue(const AuthState());
  });

  setUp(() async {
    await getIt.reset();
    authBloc = MockAuthBloc();
    getIt.registerSingleton<AuthBloc>(authBloc);
  });

  tearDown(() async {
    await getIt.reset();
  });

  Widget buildSubject({
    required AuthStatus authStatus,
    String initialLocation = AppRoutes.home,
  }) {
    final authState = AuthState(status: authStatus);
    when(() => authBloc.state).thenReturn(authState);
    whenListen(
      authBloc,
      const Stream<AuthState>.empty(),
      initialState: authState,
    );

    final router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return AppScaffold(
              navigationShell: navigationShell,
              onItemTapped: (index) {
                const protectedIndexes = {1, 2, 3};
                final targets = {
                  0: AppRoutes.home,
                  1: AppRoutes.myPublications,
                  2: AppRoutes.publish,
                  3: AppRoutes.profile,
                };
                if (protectedIndexes.contains(index) && !getIt<AuthBloc>().state.isAuthenticated) {
                  context.goToLogin(from: targets[index]);
                  return;
                }
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
            );
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.home,
                  builder: (_, _) => const Scaffold(body: Text('home-page')),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.myPublications,
                  builder: (_, _) => const Scaffold(body: Text('my-publications-page')),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.publish,
                  builder: (_, _) => const Scaffold(body: Text('publish-page')),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  builder: (_, _) => const Scaffold(body: Text('profile-page')),
                ),
              ],
            ),
          ],
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

  testWidgets('selected tab follows current branch', (tester) async {
    await tester.pumpWidget(
      buildSubject(authStatus: AuthStatus.authenticated),
    );
    await tester.pumpAndSettle();

    expect(find.text('home-page'), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.home_outlined), findsNothing);

    await tester.tap(find.text('Publicar'));
    await tester.pumpAndSettle();

    expect(find.text('publish-page'), findsOneWidget);
    expect(find.byIcon(Icons.add_circle), findsOneWidget);
    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
  });

  testWidgets(
    'unauthenticated publish tab redirects to login preserving from',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        buildSubject(authStatus: AuthStatus.unauthenticated),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Publicar'));
      await tester.pumpAndSettle();

      expect(find.text('login:/publish'), findsOneWidget);
    },
  );

  testWidgets(
    'unauthenticated my publications tab redirects to login preserving from',
    (tester) async {
      await tester.pumpWidget(
        buildSubject(authStatus: AuthStatus.unauthenticated),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Mis Publicaciones'));
      await tester.pumpAndSettle();

      expect(find.text('login:/my-publications'), findsOneWidget);
    },
  );

  testWidgets(
    'unauthenticated profile tab redirects to login preserving from',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        buildSubject(authStatus: AuthStatus.unauthenticated),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Perfil'));
      await tester.pumpAndSettle();

      expect(find.text('login:/profile'), findsOneWidget);
    },
  );

  testWidgets('home tab switches branch without auth redirect', (tester) async {
    await tester.pumpWidget(
      buildSubject(
        authStatus: AuthStatus.unauthenticated,
        initialLocation: AppRoutes.publish,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('publish-page'), findsOneWidget);

    await tester.tap(find.text('Inicio'));
    await tester.pumpAndSettle();

    expect(find.text('home-page'), findsOneWidget);
    expect(find.textContaining('login:'), findsNothing);
  });
}
