import 'package:dio/dio.dart';
import 'package:mobile_table_hopping/core/auth/token_storage.dart';

/// Authentication interceptor to add JWT tokens to requests.
class AuthInterceptor extends Interceptor {
  /// Creates an AuthInterceptor with the given token storage.
  AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Skip auth for login/register endpoints
    if (options.path.contains('/auth/login') ||
        options.path.contains('/auth/register') ||
        options.path.contains('/auth/refresh') ||
        options.path.contains('/health')) {
      return super.onRequest(options, handler);
    }

    // Add access token to Authorization header
    final accessToken = _tokenStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }
}
