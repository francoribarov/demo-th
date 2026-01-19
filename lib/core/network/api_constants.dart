import 'package:flutter/foundation.dart';

/// API endpoint constants.
class ApiConstants {
  ApiConstants._();

  /// Base API path prefix.
  static const String apiBasePath = '/api';

  // Base URL defaults:
  // - Android emulator uses 10.0.2.2 to access host localhost
  // - iOS simulator can use localhost
  // - Physical devices should override with your computer's IP
  //
  // Override at build/run time with:
  //   flutter run --dart-define=API_BASE_URL=http://<host>:8000
  /// Base URL computed from platform defaults or API_BASE_URL override.
  static String get baseUrl {
    const overrideUrl = String.fromEnvironment('API_BASE_URL');
    if (overrideUrl.isNotEmpty) {
      return _normalizeBaseUrl(overrideUrl);
    }

    if (kIsWeb) return _defaultWebBaseUrl;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _defaultAndroidBaseUrl;
      case TargetPlatform.iOS:
        return _defaultIosBaseUrl;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return _defaultFallbackBaseUrl;
    }
  }

  static const String _defaultAndroidBaseUrl = 'http://10.0.2.2:8000';
  static const String _defaultIosBaseUrl = 'http://localhost:8000';
  static const String _defaultWebBaseUrl = 'http://localhost:8000';
  static const String _defaultFallbackBaseUrl = 'http://localhost:8000';

  static String _normalizeBaseUrl(String url) {
    if (url.endsWith('/')) return url.substring(0, url.length - 1);
    return url;
  }

  /// Authentication endpoints.
  static const String register = '$apiBasePath/auth/register';

  /// Login endpoint.
  static const String login = '$apiBasePath/auth/login';

  /// Refresh token endpoint.
  static const String refreshToken = '$apiBasePath/auth/refresh';

  /// Logout endpoint.
  static const String logout = '$apiBasePath/auth/logout';

  /// Publications endpoints.
  static const String publications = '$apiBasePath/publications';

  /// Publication detail endpoint.
  static String publicationById(dynamic id) => '$publications/$id';

  /// Publications available today endpoint.
  static const String publicationsAvailableToday =
      '$publications/available-today';

  /// My publications endpoint (current user's publications).
  static const String myPublications = '$publications/my-publications';

  /// Publication reviews endpoint.
  static String publicationReviews(dynamic id) => '$publications/$id/reviews';

  /// Publication recommendations endpoint.
  static String publicationRecommendations(dynamic id) =>
      '$publications/$id/recommendations';

  /// Categories endpoints.
  static const String categories = '$apiBasePath/categories';

  /// Category filter shortcuts endpoint.
  static const String filterShortcuts = '$categories/filter-shortcuts';

  /// Users endpoints.
  static const String users = '$apiBasePath/users';

  /// Current user endpoint.
  static const String currentUser = '$users/me';

  /// Games endpoints.
  static const String games = '$apiBasePath/games';

  /// Rentals endpoints.
  static const String rentals = '$apiBasePath/rentals';

  /// Health check endpoint.
  static const String health = '/health';
}
