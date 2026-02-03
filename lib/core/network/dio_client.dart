import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/auth/token_storage.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/interceptors/auth_interceptor.dart';
import 'package:mobile_table_hopping/core/network/interceptors/error_interceptor.dart';
import 'package:mobile_table_hopping/core/network/interceptors/logging_interceptor.dart';
import 'package:mobile_table_hopping/core/network/interceptors/refresh_interceptor.dart';

/// Dio HTTP client configuration.
@lazySingleton
class DioClient {
  /// Creates a configured Dio client with interceptors.
  DioClient(this._tokenStorage) : _dio = Dio() {
    final baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    _dio.options = baseOptions;

    final refreshDio = Dio(baseOptions.copyWith());

    // Add interceptors
    _dio.interceptors.addAll([
      AuthInterceptor(_tokenStorage),
      RefreshInterceptor(_tokenStorage, _dio, refreshDio),
      createLoggingInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  final Dio _dio;
  final TokenStorage _tokenStorage;

  /// Exposes the configured Dio instance.
  Dio get dio => _dio;

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
