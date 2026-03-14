import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/auth/token_storage.dart';
import 'package:mobile_table_hopping/core/di/injection.dart';
import 'package:mobile_table_hopping/core/routing/go_router_refresh_stream.dart';
import 'package:mobile_table_hopping/core/widgets/templates/app_scaffold.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/pages/user_profile_page.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/edit_publication/edit_publication_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/my_publications_bloc.dart';
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
import 'package:mobile_table_hopping/presentation/pages/publication_details/game_reviews_page.dart';
import 'package:mobile_table_hopping/presentation/pages/publication_details/game_rules_page.dart';
import 'package:mobile_table_hopping/presentation/pages/publication_details/publication_details_page.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/publish_game_page.dart';
import 'package:mobile_table_hopping/presentation/pages/rental/rental_confirm_page.dart';

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

  /// Builds the publication details path for [id].
  static String publicationDetailsPath(String id) =>
      '/publications/${Uri.encodeComponent(id)}';

  /// Builds the publication rules path for [id].
  static String gameRulesPath(String id) =>
      '${publicationDetailsPath(id)}/rules';

  /// Builds the publication reviews path for [id].
  static String gameReviewsPath(String id) =>
      '${publicationDetailsPath(id)}/reviews';

  /// Builds the publication owner path for [id].
  static String gameOwnerPath(String id) =>
      '${publicationDetailsPath(id)}/owner';

  /// Builds the publication rental path for [id].
  static String rentalPath(String id) => '${publicationDetailsPath(id)}/rental';

  /// Builds the edit publication path for [id].
  static String editPublicationPath(String id) =>
      '/my-publications/${Uri.encodeComponent(id)}/edit';

  /// Builds the login path preserving an optional redirect.
  static String loginPath({String? from}) {
    if (from == null || from.trim().isEmpty) return login;
    return '$login?from=${Uri.encodeComponent(from)}';
  }

  /// Builds the register path preserving an optional redirect.
  static String registerPath({String? from}) {
    if (from == null || from.trim().isEmpty) return register;
    return '$register?from=${Uri.encodeComponent(from)}';
  }
}

/// App router configuration using go_router.
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final Listenable _routerRefreshListenable = Listenable.merge([
    GoRouterRefreshStream(getIt<AuthBloc>().stream),
    getIt<TokenStorage>(),
  ]);

  static bool _isProtectedLocation({
    required String location,
    required String? routeTemplate,
  }) {
    const protectedRoutes = {
      AppRoutes.publish,
      AppRoutes.myPublications,
      AppRoutes.rental,
      AppRoutes.editPublication,
    };

    if (routeTemplate != null && protectedRoutes.contains(routeTemplate)) {
      return true;
    }

    // Fallback for direct static paths if fullPath is null.
    return location == AppRoutes.publish ||
        location == AppRoutes.myPublications;
  }

  static bool _isAuthLocation(String location) {
    return location == AppRoutes.login || location == AppRoutes.register;
  }

  static bool _isSafeRedirectLocation(String? location) {
    if (location == null || location.trim().isEmpty) return false;
    return location.startsWith('/') &&
        !location.startsWith(AppRoutes.login) &&
        !location.startsWith(AppRoutes.register);
  }

  static String _loginLocationWithFrom(String from) {
    return AppRoutes.loginPath(from: from);
  }

  /// Application router instance.
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    refreshListenable: _routerRefreshListenable,
    redirect: (context, state) {
      final location = state.uri.path;
      final isProtected = _isProtectedLocation(
        location: location,
        routeTemplate: state.fullPath,
      );
      final isAuthLocation = _isAuthLocation(location);
      final requestedLocation = state.uri.toString();

      final authBloc = getIt<AuthBloc>();
      final authState = authBloc.state;
      final tokenStorage = getIt<TokenStorage>();
      final hasTokens =
          tokenStorage.getAccessToken() != null &&
          tokenStorage.getRefreshToken() != null;

      if (authState.status == AuthStatus.unknown ||
          authState.isCheckingStatus) {
        return null;
      }

      final isAuthed =
          authState.status == AuthStatus.authenticated && hasTokens;

      if (!isAuthed && isProtected) {
        return _loginLocationWithFrom(requestedLocation);
      }

      if (isAuthed && isAuthLocation) {
        final from = state.uri.queryParameters['from'];
        if (_isSafeRedirectLocation(from)) {
          return from;
        }
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      // Shell route for bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppScaffold(
          navigationShell: navigationShell,
          onItemTapped: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomePage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.myPublications,
                name: 'my-publications',
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
                    ],
                    child: const MyPublicationsPage(),
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.publish,
                name: 'publish',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider<PublishBloc>(
                        create: (_) =>
                            getIt<PublishBloc>()
                              ..add(const PublishEvent.started()),
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
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: Scaffold(
                    appBar: AppBar(title: const Text('Mi Perfil')),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Configuración de tu perfil.'),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            onPressed: () {
                              getIt<AuthBloc>().add(
                                const AuthEvent.logoutRequested(),
                              );
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text('Cerrar Sesión'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final from = state.uri.queryParameters['from'];
          return LoginPage(from: from);
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final from = state.uri.queryParameters['from'];
          return RegisterPage(from: from);
        },
      ),
      // Routes outside of shell (no bottom nav)
      GoRoute(
        path: AppRoutes.publicationDetails,
        name: AppRoutes.publicationDetails,
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
            name: 'gameRules',
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
            name: 'gameReviews',
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
            name: 'gameOwner',
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
            name: 'rental',
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
        name: 'edit-publication',
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
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Volver al inicio'),
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
