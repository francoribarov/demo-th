import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Route paths for type-safe navigation.
class AppRoutes {
  AppRoutes._();

  /// Home route.
  static const String home = '/';

  /// Login route.
  static const String login = '/login';

  /// Register route.
  static const String register = '/register';

  /// Publish game route.
  static const String publish = '/publish';

  /// My publications route.
  static const String myPublications = '/my-publications';

  /// Personal profile route.
  static const String profile = '/profile';

  /// Publication details route template.
  static const String publicationDetails = '/publications/:id';

  /// Game rules route template.
  static const String gameRules = '/publications/:id/rules';

  /// Game reviews route template.
  static const String gameReviews = '/publications/:id/reviews';

  /// Game owner route template.
  static const String gameOwner = '/publications/:id/owner';

  /// Rental confirmation route template.
  static const String rental = '/publications/:id/rental';

  /// Edit publication route template.
  static const String editPublication = '/my-publications/:id/edit';
}

/// Builds the publication details path for [id].
String publicationDetailsPath(String id) =>
    '/publications/${Uri.encodeComponent(id)}';

/// Builds the publication rules path for [id].
String publicationRulesPath(String id) => '${publicationDetailsPath(id)}/rules';

/// Builds the publication reviews path for [id].
String publicationReviewsPath(String id) =>
    '${publicationDetailsPath(id)}/reviews';

/// Builds the publication owner path for [id].
String publicationOwnerPath(String id) => '${publicationDetailsPath(id)}/owner';

/// Builds the publication rental path for [id].
String publicationRentalPath(String id) =>
    '${publicationDetailsPath(id)}/rental';

/// Extension methods for easier navigation.
extension NavigationBuildContextX on BuildContext {
  /// Navigate to publication details for [id].
  void goToPublication(String id) => push(publicationDetailsPath(id));

  /// Navigate to game rules for [id].
  void goToGameRules(String id) => push(publicationRulesPath(id));

  /// Navigate to game reviews for [id].
  void goToGameReviews(String id) => push(publicationReviewsPath(id));

  /// Navigate to game owner for [id].
  void goToGameOwner(String id) => push(publicationOwnerPath(id));

  /// Navigate to rental confirmation for [id] with optional dates.
  void goToRental(
    String id, {
    String? startDate,
    String? endDate,
    String? ownerId,
    double? deposit,
  }) => push(
    publicationRentalPath(id),
    extra: {
      'startDate': startDate,
      'endDate': endDate,
      'ownerId': ownerId,
      'deposit': deposit,
    },
  );

  /// Navigate to login with an optional [from] redirect.
  void goToLogin({String? from}) {
    final uri = Uri(
      path: AppRoutes.login,
      queryParameters: {
        if (from != null && from.trim().isNotEmpty) 'from': from,
      },
    );
    go(uri.toString());
  }

  /// Navigate to registration with an optional [from] redirect.
  void goToRegister({String? from}) => go(
    from != null
        ? '${AppRoutes.register}?from=${Uri.encodeComponent(from)}'
        : AppRoutes.register,
  );

  /// Navigate to the publish flow.
  void goToPublish() => go(AppRoutes.publish);

  /// Navigate to the home route.
  void goHome() => go(AppRoutes.home);

  /// Navigate to edit a publication.
  void goToEditPublication(String id) =>
      push('/my-publications/${Uri.encodeComponent(id)}/edit');

  /// Safe back navigation for deep links (no back stack).
  void popOrGo(String location) {
    final router = GoRouter.of(this);
    if (router.canPop()) {
      router.pop();
    } else {
      router.go(location);
    }
  }
}
