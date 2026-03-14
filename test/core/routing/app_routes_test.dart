import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';

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
}
