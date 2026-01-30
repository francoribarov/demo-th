import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/di/injection.dart';
import 'package:mobile_table_hopping/core/routing/go_router_refresh_stream.dart';
import 'package:mobile_table_hopping/core/widgets/app_scaffold.dart';
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_table_hopping/features/auth/presentation/pages/login_page.dart';
import 'package:mobile_table_hopping/features/auth/presentation/pages/register_page.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/pages/home_page.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/bloc/edit_publication_bloc.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/bloc/my_publications_bloc.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/pages/edit_publication_page.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/pages/my_publications_page.dart';
import 'package:mobile_table_hopping/features/publication_details/presentation/bloc/game_reviews_bloc.dart';
import 'package:mobile_table_hopping/features/publication_details/presentation/bloc/game_rules_bloc.dart';
import 'package:mobile_table_hopping/features/publication_details/presentation/bloc/publication_details_bloc.dart';
import 'package:mobile_table_hopping/features/publication_details/presentation/pages/game_reviews_page.dart';
import 'package:mobile_table_hopping/features/publication_details/presentation/pages/game_rules_page.dart';
import 'package:mobile_table_hopping/features/publication_details/presentation/pages/publication_details_page.dart';
import 'package:mobile_table_hopping/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:mobile_table_hopping/features/publish/presentation/pages/publish_game_page.dart';
import 'package:mobile_table_hopping/features/rental/presentation/bloc/rental_bloc.dart';
import 'package:mobile_table_hopping/features/rental/presentation/pages/rental_confirm_page.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/pages/user_profile_page.dart';

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
  static const String gameRules = '/games/:id/rules';

  /// Game reviews route template.
  static const String gameReviews = '/games/:id/reviews';

  /// Game owner route template.
  static const String gameOwner = '/publications/:id/owner';

  /// Rental confirmation route template.
  static const String rental = '/publications/:id/rental';

  /// Edit publication route template.
  static const String editPublication = '/my-publications/:id/edit';
}

/// App router configuration using go_router.
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  /// Application router instance.
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(getIt<AuthBloc>().stream),
    redirect: (context, state) {
      final location = state.uri.path;

      final isProtected = location == AppRoutes.publish ||
          location == AppRoutes.myPublications ||
          RegExp(r'^/publications/[^/]+/rental$').hasMatch(location) ||
          RegExp(r'^/my-publications/[^/]+/edit$').hasMatch(location);

      final authBloc = getIt<AuthBloc>();
      final authState = authBloc.state;

      if (authState.status == AuthStatus.unknown ||
          authState.isCheckingStatus) {
        return null;
      }
      final isAuthed = authState.status == AuthStatus.authenticated;

      if (!isAuthed && isProtected) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      // Shell route for bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: AppRoutes.publish,
            name: 'publish',
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider<PublishBloc>(
                create: (_) =>
                    getIt<PublishBloc>()..add(const PublishEvent.started()),
                child: const PublishGamePage(),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.myPublications,
            name: 'my-publications',
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider<MyPublicationsBloc>(
                create: (_) => getIt<MyPublicationsBloc>()
                  ..add(const MyPublicationsEvent.started()),
                child: const MyPublicationsPage(),
              ),
            ),
          ),
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
                          getIt<AuthBloc>()
                              .add(const AuthEvent.logoutRequested());
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
            create: (_) => getIt<PublicationDetailsBloc>()
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
                create: (_) => getIt<GameRulesBloc>()
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
                create: (_) => getIt<GameReviewsBloc>()
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
                create: (_) => getIt<UserProfileBloc>()
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
            create: (_) => getIt<EditPublicationBloc>()
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
  void goToPublication(String id) => push('/publications/$id');

  /// Navigate to game rules for [id].
  void goToGameRules(String id) => push('/publications/$id/rules');

  /// Navigate to game reviews for [id].
  void goToGameReviews(String id) => push('/publications/$id/reviews');

  /// Navigate to game owner for [id].
  void goToGameOwner(String id) => push('/publications/$id/owner');

  /// Navigate to rental confirmation for [id] with optional dates.
  void goToRental(
    String id, {
    String? startDate,
    String? endDate,
    String? ownerId,
    double? deposit,
  }) =>
      push(
        '/publications/$id/rental',
        extra: {
          'startDate': startDate,
          'endDate': endDate,
          'ownerId': ownerId,
          'deposit': deposit,
        },
      );

  /// Navigate to login with an optional [from] redirect.
  void goToLogin({String? from}) => go(
        from != null
            ? '${AppRoutes.login}?from=${Uri.encodeComponent(from)}'
            : AppRoutes.login,
      );

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
  void goToEditPublication(String id) => push('/my-publications/$id/edit');

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
