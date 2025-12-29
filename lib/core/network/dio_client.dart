import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/auth/token_storage.dart';
import 'package:mobile_table_hopping/core/errors/exceptions.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';

/// Dio HTTP client configuration.
@lazySingleton
class DioClient {
  /// Creates a configured Dio client with interceptors.
  DioClient(this._tokenStorage) : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    );

    // Add interceptors
    _dio.interceptors.addAll([_LoggingInterceptor(), _AuthInterceptor(_tokenStorage), _ErrorInterceptor()]);
  }

  final Dio _dio;
  final TokenStorage _tokenStorage;

  /// Exposes the configured Dio instance.
  Dio get dio => _dio;

  /// GET request
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    return _dio.get<T>(path, queryParameters: queryParameters, options: options);
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.delete<T>(path, data: data, queryParameters: queryParameters, options: options);
  }
}

/// Authentication interceptor to add JWT tokens to requests.
class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Skip auth for login/register endpoints
    if (options.path.contains('/auth/login') ||
        options.path.contains('/auth/register') ||
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

/// Logging interceptor for debugging.
class _LoggingInterceptor extends Interceptor {
  static const int _maxBodyChars = 4000;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('🌐 REQUEST[${options.method}] => URL: ${options.uri}');
      debugPrint('  headers: ${options.headers}');
      if (options.queryParameters.isNotEmpty) {
        debugPrint('  query: ${options.queryParameters}');
      }
      if (options.data != null) {
        debugPrint('  body: ${_truncate(_safeToString(options.data))}');
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('✅ RESPONSE[${response.statusCode}] => URL: ${response.requestOptions.uri}');
      debugPrint('  headers: ${response.headers.map}');
      if (response.data != null) {
        debugPrint('  data: ${_truncate(_safeToString(response.data))}');
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final url = err.requestOptions.uri;

    if (kDebugMode) {
      if (statusCode != null) {
        debugPrint('❌ ERROR[$statusCode] => URL: $url');
      } else {
        debugPrint('❌ ERROR[NO_RESPONSE] => URL: $url TYPE: ${err.type} MSG: ${err.message}');
      }
      if (err.response?.data != null) {
        debugPrint('  data: ${_truncate(_safeToString(err.response!.data))}');
      }
    }
    super.onError(err, handler);
  }

  String _safeToString(dynamic value) {
    if (value == null) return 'null';
    try {
      if (value is String) return value;
      if (value is Map || value is List) {
        return const JsonEncoder.withIndent('  ').convert(value);
      }
      return value.toString();
    } on Exception catch (_) {
      return value.toString();
    }
  }

  String _truncate(String value) {
    if (value.length <= _maxBodyChars) return value;
    return '${value.substring(0, _maxBodyChars)}…(truncated)';
  }
}

/// Error interceptor to convert Dio errors to app exceptions.
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapDioError(err);
    handler.reject(
      DioException(requestOptions: err.requestOptions, error: exception, response: err.response, type: err.type),
    );
  }

  AppException _mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(message: 'La conexión tardó demasiado. Intente nuevamente.');
      case DioExceptionType.connectionError:
        return const NetworkException(message: 'Sin conexión a internet.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = _extractErrorMessage(error.response);
        if (statusCode == 401) {
          return ServerException(message: message ?? 'No autorizado.', statusCode: statusCode);
        }
        if (statusCode == 404) {
          return NotFoundException(message: message ?? 'No se encontró el recurso.');
        }
        if (statusCode != null && statusCode >= 500) {
          return ServerException(message: message ?? 'Error del servidor. Intente más tarde.', statusCode: statusCode);
        }
        return ServerException(message: message ?? 'Error desconocido.', statusCode: statusCode);
      case DioExceptionType.cancel:
        return const ServerException(message: 'La solicitud fue cancelada.');
      case DioExceptionType.badCertificate:
        return const ServerException(message: 'Certificado SSL inválido.');
      case DioExceptionType.unknown:
        return const ServerException(message: 'Ocurrió un error inesperado.');
    }
  }

  String? _extractErrorMessage(Response<dynamic>? response) {
    if (response?.data is Map) {
      final data = response!.data as Map;
      return data['message'] as String? ?? data['error'] as String?;
    }
    return null;
  }
}
