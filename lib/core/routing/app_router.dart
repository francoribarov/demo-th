import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/di/injection.dart';
import 'package:mobile_table_hopping/core/routing/go_router_refresh_stream.dart';
import 'package:mobile_table_hopping/core/widgets/templates/app_scaffold.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/pages/user_profile_page.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/catalog/catalog_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/edit_publication/edit_publication_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/my_publications_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/owner_rentals/owner_rentals_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/rental_requests/rental_requests_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/game_reviews_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/game_rules_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/publication_details_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/delivery_method_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/image_upload_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/publish_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/auth/login_page.dart';
import 'package:mobile_table_hopping/presentation/pages/auth/register_page.dart';
import 'package:mobile_table_hopping/presentation/pages/catalog/home_page.dart';
import 'package:mobile_table_hopping/presentation/pages/my_publications/edit_publication_page.dart';
import 'package:mobile_table_hopping/presentation/pages/my_publications/my_publications_page.dart';
import 'package:mobile_table_hopping/presentation/pages/my_rentals/my_rentals_page.dart';
import 'package:mobile_table_hopping/presentation/pages/profile/profile_page.dart';
import 'package:mobile_table_hopping/presentation/pages/publication_details/game_reviews_page.dart';
import 'package:mobile_table_hopping/presentation/pages/publication_details/game_rules_page.dart';
import 'package:mobile_table_hopping/presentation/pages/publication_details/publication_details_page.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/publish_game_page.dart';
import 'package:mobile_table_hopping/presentation/pages/rental/rental_confirm_page.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

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

  /// My PUBLICATIONS route.
  static const String myPublications = '/my-publications';

  /// My rentals dashboard route.
  static const String myRentals = '/my-rentals';

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

  /// Home route name.
  static const String homeName = 'home';

  /// Publish route name.
  static const String publishName = 'publish';

  /// My publications route name.
  static const String myPublicationsName = 'my-publications';

  /// My rentals dashboard route name.
  static const String myRentalsName = 'my-rentals';

  /// Profile route name.
  static const String profileName = 'profile';

  /// Login route name.
  static const String loginName = 'login';

  /// Register route name.
  static const String registerName = 'register';

  /// Publication details route name.
  static const String publicationDetailsName = 'publication-details';

  /// Rules route name.
  static const String gameRulesName = 'game-rules';

  /// Reviews route name.
  static const String gameReviewsName = 'game-reviews';

  /// Owner route name.
  static const String gameOwnerName = 'game-owner';

  /// Rental route name.
  static const String rentalName = 'rental';

  /// Edit publication route name.
  static const String editPublicationName = 'edit-publication';

  /// Publication details location.
  static String publicationDetailsPath(String id) => '/publications/$id';

  /// Rules location.
  static String gameRulesPath(String id) =>
      '${publicationDetailsPath(id)}/rules';

  /// Reviews location.
  static String gameReviewsPath(String id) =>
      '${publicationDetailsPath(id)}/reviews';

  /// Owner location.
  static String gameOwnerPath(String id) =>
      '${publicationDetailsPath(id)}/owner';

  /// Rental location.
  static String rentalPath(String id) => '${publicationDetailsPath(id)}/rental';

  /// Edit publication location.
  static String editPublicationPath(String id) => '/my-publications/$id/edit';

  /// Login location, optionally preserving where the user came from.
  static String loginPath({String? from}) {
    if (from == null || from.trim().isEmpty) {
      return login;
    }

    final normalizedFrom = _normalizeFromParam(from);

    return Uri(
      path: login,
      queryParameters: {'from': normalizedFrom},
    ).toString();
  }

  /// Register location, optionally preserving where the user came from.
  static String registerPath({String? from}) {
    if (from == null || from.trim().isEmpty) {
      return register;
    }

    final normalizedFrom = _normalizeFromParam(from);

    return Uri(
      path: register,
      queryParameters: {'from': normalizedFrom},
    ).toString();
  }

  static String _normalizeFromParam(String from) {
    final trimmed = from.trim();
    if (trimmed.isEmpty) {
      return trimmed;
    }

    try {
      return Uri.decodeComponent(trimmed);
    } on FormatException {
      return trimmed;
    }
  }
}

/// App router configuration using go_router.
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavigatorKey = GlobalKey<NavigatorState>();
  static final _myRentalsNavigatorKey = GlobalKey<NavigatorState>();
  static final _myPublicationsNavigatorKey = GlobalKey<NavigatorState>();
  static final _profileNavigatorKey = GlobalKey<NavigatorState>();

  static bool _isProtectedLocation(String location) {
    final path = Uri.parse(location).path;

    if (path == AppRoutes.publish ||
        path == AppRoutes.myPublications ||
        path == AppRoutes.myRentals ||
        path == AppRoutes.profile) {
      return true;
    }

    final segments = Uri(path: path).pathSegments;

    final isRentalRoute =
        segments.length == 3 &&
        segments.first == 'publications' &&
        segments.last == 'rental';

    if (isRentalRoute) {
      return true;
    }

    final isEditRoute =
        segments.length == 3 &&
        segments.first == 'my-publications' &&
        segments.last == 'edit';

    return isEditRoute;
  }

  @visibleForTesting
  static String? authRedirectFor(AuthState authState, String location) {
    if (authState.status == AuthStatus.unknown || authState.isCheckingStatus) {
      return null;
    }

    if (!_isProtectedLocation(location)) {
      return null;
    }

    if (authState.status != AuthStatus.authenticated) {
      return AppRoutes.loginPath(from: location);
    }

    return null;
  }

  /// Application router instance.
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(getIt<AuthBloc>().stream),
    redirect: (context, state) {
      return authRedirectFor(getIt<AuthBloc>().state, state.uri.toString());
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(
            navigationShell: navigationShell,
            onItemTapped: (int index) {
              const protectedIndexes = {1, 2, 3};
              const targets = {
                0: AppRoutes.home,
                1: AppRoutes.myRentals,
                2: AppRoutes.myPublications,
                3: AppRoutes.profile,
              };
              if (protectedIndexes.contains(index) &&
                  !getIt<AuthBloc>().state.isAuthenticated) {
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
          // 0 – Inicio
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: AppRoutes.homeName,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: BlocProvider<CatalogBloc>(
                    create: (_) =>
                        getIt<CatalogBloc>()
                          ..add(const CatalogEvent.loadGames()),
                    child: const HomePage(),
                  ),
                ),
              ),
            ],
          ),
          // 1 – Alquileres
          StatefulShellBranch(
            navigatorKey: _myRentalsNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.myRentals,
                name: AppRoutes.myRentalsName,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: MyRentalsPage(),
                ),
              ),
            ],
          ),
          // 2 – Publicaciones
          StatefulShellBranch(
            navigatorKey: _myPublicationsNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.myPublications,
                name: AppRoutes.myPublicationsName,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider<MyPublicationsBloc>(
                        create: (_) =>
                            getIt<MyPublicationsBloc>()
                              ..add(const MyPublicationsEvent.started()),
                      ),
                      BlocProvider<RentalRequestsBloc>(
                        create: (_) =>
                            getIt<RentalRequestsBloc>()
                              ..add(const RentalRequestsEvent.started()),
                      ),
                      BlocProvider<OwnerRentalsBloc>(
                        create: (_) =>
                            getIt<OwnerRentalsBloc>()
                              ..add(const OwnerRentalsEvent.started()),
                      ),
                    ],
                    child: const MyPublicationsPage(),
                  ),
                ),
              ),
            ],
          ),
          // 3 – Perfil
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: AppRoutes.profileName,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfilePage()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final from = state.uri.queryParameters['from'];
          return LoginPage(from: from);
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.registerName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final from = state.uri.queryParameters['from'];
          return RegisterPage(from: from);
        },
      ),
      // Publish route (full-screen, no bottom nav)
      GoRoute(
        path: AppRoutes.publish,
        name: AppRoutes.publishName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<PublishBloc>(
              create: (_) =>
                  getIt<PublishBloc>()..add(const PublishEvent.started()),
            ),
            BlocProvider<DeliveryMethodBloc>(
              create: (_) => getIt<DeliveryMethodBloc>(),
            ),
            BlocProvider<ImageUploadBloc>(
              create: (_) => getIt<ImageUploadBloc>(),
            ),
          ],
          child: const PublishGamePage(),
        ),
      ),
      // Routes outside of shell (no bottom nav)
      GoRoute(
        path: AppRoutes.publicationDetails,
        name: AppRoutes.publicationDetailsName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider<PublicationDetailsBloc>(
            create: (_) =>
                getIt<PublicationDetailsBloc>()
                  ..add(PublicationDetailsEvent.started(publicationId: id)),
            child: PublicationDetailsPage(publicationId: id),
          );
        },
        routes: [
          GoRoute(
            path: 'rules',
            name: AppRoutes.gameRulesName,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return BlocProvider<GameRulesBloc>(
                create: (_) =>
                    getIt<GameRulesBloc>()
                      ..add(GameRulesEvent.started(gameId: id)),
                child: GameRulesPage(gameId: id),
              );
            },
          ),
          GoRoute(
            path: 'reviews',
            name: AppRoutes.gameReviewsName,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return BlocProvider<GameReviewsBloc>(
                create: (_) =>
                    getIt<GameReviewsBloc>()
                      ..add(GameReviewsEvent.started(gameId: id)),
                child: GameReviewsPage(gameId: id),
              );
            },
          ),
          GoRoute(
            path: 'owner',
            name: AppRoutes.gameOwnerName,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return BlocProvider<UserProfileBloc>(
                create: (_) =>
                    getIt<UserProfileBloc>()
                      ..add(UserProfileEvent.started(gameId: id)),
                child: UserProfilePage(gameId: id),
              );
            },
          ),
          GoRoute(
            path: 'rental',
            name: AppRoutes.rentalName,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final extra = state.extra as Map<String, dynamic>?;
              final startDate = extra?['startDate'] as String?;
              final endDate = extra?['endDate'] as String?;
              final ownerId = extra?['ownerId'] as String?;
              final deposit = extra?['deposit'] as double?;
              return BlocProvider<RentalBloc>(
                create: (_) => getIt<RentalBloc>()
                  ..add(
                    RentalEvent.started(
                      publicationId: id,
                      startDate: startDate,
                      endDate: endDate,
                      ownerId: ownerId,
                      deposit: deposit,
                    ),
                  ),
                child: RentalConfirmPage(
                  publicationId: id,
                  startDate: startDate,
                  endDate: endDate,
                ),
              );
            },
          ),
        ],
      ),
      // Edit publication route
      GoRoute(
        path: AppRoutes.editPublication,
        name: AppRoutes.editPublicationName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider<EditPublicationBloc>(
            create: (_) =>
                getIt<EditPublicationBloc>()
                  ..add(EditPublicationEvent.started(publicationId: id)),
            child: EditPublicationPage(publicationId: id),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '404',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Página no encontrada'),
            const SizedBox(height: 24),
            AppPrimaryButton(
              label: 'Volver al inicio',
              onPressed: () => context.go(AppRoutes.home),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Extension methods for easier navigation.
extension GoRouterExtension on BuildContext {
  /// Navigate to publication details for [id].
  void goToPublication(String id) => push(AppRoutes.publicationDetailsPath(id));

  /// Navigate to game rules for [id].
  void goToGameRules(String id) => push(AppRoutes.gameRulesPath(id));

  /// Navigate to game reviews for [id].
  void goToGameReviews(String id) => push(AppRoutes.gameReviewsPath(id));

  /// Navigate to game owner for [id].
  void goToGameOwner(String id) => push(AppRoutes.gameOwnerPath(id));

  /// Navigate to rental confirmation for [id] with optional dates.
  void goToRental(
    String id, {
    String? startDate,
    String? endDate,
    String? ownerId,
    double? deposit,
  }) => push(
    AppRoutes.rentalPath(id),
    extra: {
      'startDate': startDate,
      'endDate': endDate,
      'ownerId': ownerId,
      'deposit': deposit,
    },
  );

  /// Navigate to login with an optional [from] redirect.
  void goToLogin({String? from}) => go(AppRoutes.loginPath(from: from));

  /// Navigate to registration with an optional [from] redirect.
  void goToRegister({String? from}) => go(AppRoutes.registerPath(from: from));

  /// Navigate to the publish flow.
  void goToPublish() => go(AppRoutes.publish);

  /// Navigate to the home route.
  void goHome() => go(AppRoutes.home);

  /// Navigate to edit a publication.
  void goToEditPublication(String id) =>
      push(AppRoutes.editPublicationPath(id));

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
