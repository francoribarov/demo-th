import 'dart:async';
import 'package:dio/dio.dart';
import 'package:mobile_table_hopping/core/auth/token_storage.dart';

/// Interceptor that handles token refreshing on 401 errors.
class RefreshInterceptor extends Interceptor {
  /// Creates a RefreshInterceptor with token storage and Dio clients.
  RefreshInterceptor(this._tokenStorage, this._dio, this._refreshDio);

  static const String _retryKey = 'refresh_retry';

  final TokenStorage _tokenStorage;
  final Dio _dio;
  final Dio _refreshDio;

  Future<_TokenPair?>? _refreshing;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldAttemptRefresh(err)) {
      return handler.next(err);
    }

    try {
      final tokens = await _refreshTokens();
      if (tokens == null) {
        await _tokenStorage.clearTokens();
        return handler.next(err);
      }

      final retryOptions = err.requestOptions.copyWith(
        headers: Map<String, dynamic>.from(err.requestOptions.headers)
          ..['Authorization'] = 'Bearer ${tokens.accessToken}',
        extra: Map<String, dynamic>.from(err.requestOptions.extra)
          ..[_retryKey] = true,
      );

      final response = await _dio.fetch<dynamic>(retryOptions);
      return handler.resolve(response);
    } on Exception catch (_) {
      await _tokenStorage.clearTokens();
      return handler.next(err);
    }
  }

  bool _shouldAttemptRefresh(DioException err) {
    final statusCode = err.response?.statusCode;
    if (statusCode != 401) return false;

    final path = err.requestOptions.path;
    if (path.contains('/auth/login') ||
        path.contains('/auth/register') ||
        path.contains('/auth/refresh') ||
        path.contains('/auth/logout') ||
        path.contains('/health')) {
      return false;
    }

    return err.requestOptions.extra[_retryKey] != true;
  }

  Future<_TokenPair?> _refreshTokens() async {
    if (_refreshing != null) return _refreshing!;

    final completer = Completer<_TokenPair?>();
    _refreshing = completer.future;

    try {
      final refreshToken = _tokenStorage.getRefreshToken();
      if (refreshToken == null) {
        completer.complete(null);
        return completer.future;
      }

      final response = await _refreshDio.post<Map<String, dynamic>>(
        '/api/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      final data = response.data;
      final accessToken = data?['access_token'] as String?;
      final newRefreshToken = data?['refresh_token'] as String?;

      if (accessToken == null || newRefreshToken == null) {
        completer.complete(null);
        return completer.future;
      }

      await _tokenStorage.saveTokens(accessToken, newRefreshToken);
      completer.complete(
        _TokenPair(accessToken: accessToken, refreshToken: newRefreshToken),
      );
      return completer.future;
    } on Exception catch (_) {
      completer.complete(null);
      return completer.future;
    } finally {
      // Small delay to ensure concurrent requests hitting this simultaneously
      // don't trigger multiple refreshes before the first one completes and saves.
      Future.delayed(const Duration(milliseconds: 100), () {
        _refreshing = null;
      });
    }
  }
}

class _TokenPair {
  const _TokenPair({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;
}
