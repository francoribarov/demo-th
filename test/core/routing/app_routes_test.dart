import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';

// Convenience helpers
AuthState _state(AuthStatus status, {bool isChecking = false}) =>
    AuthState(status: status, isCheckingStatus: isChecking);

void main() {
  group('AppRoutes path builders', () {
    test('builds publication family paths', () {
      expect(AppRoutes.publicationDetailsPath('123'), '/publications/123');
      expect(AppRoutes.gameRulesPath('123'), '/publications/123/rules');
      expect(AppRoutes.gameReviewsPath('123'), '/publications/123/reviews');
      expect(AppRoutes.gameOwnerPath('123'), '/publications/123/owner');
      expect(AppRoutes.rentalPath('123'), '/publications/123/rental');
      expect(
        AppRoutes.editPublicationPath('123'),
        '/my-publications/123/edit',
      );
    });
  });

  group('Auth routes', () {
    test('builds login path preserving from', () {
      expect(AppRoutes.loginPath(), AppRoutes.login);
      expect(AppRoutes.loginPath(from: ''), AppRoutes.login);
      expect(
        AppRoutes.loginPath(from: AppRoutes.publish),
        '/login?from=%2Fpublish',
      );
    });

    test('builds register path preserving from', () {
      expect(AppRoutes.registerPath(), AppRoutes.register);
      expect(AppRoutes.registerPath(from: '   '), AppRoutes.register);
      expect(
        AppRoutes.registerPath(from: AppRoutes.myPublications),
        '/register?from=%2Fmy-publications',
      );
    });
  });

  group('authRedirectFor', () {
    const protectedRoutes = [
      AppRoutes.publish,
      AppRoutes.myPublications,
      AppRoutes.profile,
      '/publications/42/rental',
      '/my-publications/42/edit',
    ];

    const publicRoutes = [
      AppRoutes.home,
      AppRoutes.login,
      AppRoutes.register,
      '/publications/42',
      '/publications/42/rules',
      '/publications/42/reviews',
    ];

    test('returns null while status is unknown (splash hold)', () {
      for (final route in protectedRoutes) {
        expect(
          AppRouter.authRedirectFor(_state(AuthStatus.unknown), route),
          isNull,
          reason: 'unknown status should hold on $route',
        );
      }
    });

    test('returns null while isCheckingStatus is true', () {
      final checking = _state(AuthStatus.unknown, isChecking: true);
      for (final route in protectedRoutes) {
        expect(
          AppRouter.authRedirectFor(checking, route),
          isNull,
          reason: 'checking status should hold on $route',
        );
      }
    });

    test('returns null for authenticated user on any route', () {
      final auth = _state(AuthStatus.authenticated);
      for (final route in [...protectedRoutes, ...publicRoutes]) {
        expect(
          AppRouter.authRedirectFor(auth, route),
          isNull,
          reason: 'authenticated user should not be redirected from $route',
        );
      }
    });

    test('redirects unauthenticated user to login with from param', () {
      final unauth = _state(AuthStatus.unauthenticated);
      for (final route in protectedRoutes) {
        final result = AppRouter.authRedirectFor(unauth, route);
        expect(result, isNotNull, reason: 'should redirect from $route');
        expect(
          result,
          startsWith('/login?from='),
          reason: 'redirect should go to login with from param',
        );
      }
    });

    test('does not redirect unauthenticated user on public routes', () {
      final unauth = _state(AuthStatus.unauthenticated);
      for (final route in publicRoutes) {
        expect(
          AppRouter.authRedirectFor(unauth, route),
          isNull,
          reason: 'unauthenticated user should not be redirected from $route',
        );
      }
    });

    test('from param encodes the protected location correctly', () {
      final unauth = _state(AuthStatus.unauthenticated);
      final result = AppRouter.authRedirectFor(unauth, AppRoutes.publish);
      expect(result, '/login?from=%2Fpublish');
    });

    test('from param includes query params of protected location', () {
      final unauth = _state(AuthStatus.unauthenticated);
      final result = AppRouter.authRedirectFor(
        unauth,
        '/publish?step=2',
      );
      // /publish is protected; query string should be preserved in from
      expect(result, startsWith('/login?from='));
      expect(Uri.parse(result!).queryParameters['from'], '/publish?step=2');
    });
  });
}
