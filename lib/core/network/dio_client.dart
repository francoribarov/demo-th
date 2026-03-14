import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/auth/token_storage.dart';
import 'package:mobile_table_hopping/core/network/interceptors/auth_interceptor.dart';
import 'package:mobile_table_hopping/core/network/interceptors/logging_interceptor.dart';
import 'package:mobile_table_hopping/core/network/interceptors/refresh_interceptor.dart';

/// Dio HTTP client configuration.
@lazySingleton
class DioClient {
  /// Creates a configured Dio client with interceptors.
  DioClient(this._tokenStorage) : _dio = Dio() {
    final baseOptions = BaseOptions(
      baseUrl: _resolveBaseUrl(),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
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
    final normalizedData = _normalizeRequestBody(data);
    final resolvedOptions = _resolveOptionsForData(
      options: options,
      data: normalizedData,
    );
    return _dio.post<T>(
      path,
      data: normalizedData,
      queryParameters: queryParameters,
      options: resolvedOptions,
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final normalizedData = _normalizeRequestBody(data);
    final resolvedOptions = _resolveOptionsForData(
      options: options,
      data: normalizedData,
    );
    return _dio.put<T>(
      path,
      data: normalizedData,
      queryParameters: queryParameters,
      options: resolvedOptions,
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final normalizedData = _normalizeRequestBody(data);
    final resolvedOptions = _resolveOptionsForData(
      options: options,
      data: normalizedData,
    );
    return _dio.delete<T>(
      path,
      data: normalizedData,
      queryParameters: queryParameters,
      options: resolvedOptions,
    );
  }

  dynamic _normalizeRequestBody(dynamic data) {
    if (data == null ||
        data is Map ||
        data is List ||
        data is String ||
        data is num ||
        data is bool ||
        data is FormData ||
        data is List<int>) {
      return data;
    }

    try {
      return (data as dynamic).toJson();
    } on Object {
      return data;
    }
  }

  Options? _resolveOptionsForData({
    required Options? options,
    required dynamic data,
  }) {
    if (data == null) return options;

    final baseOptions = options ?? Options();
    final headers = Map<String, dynamic>.from(baseOptions.headers ?? {})
      ..remove('Content-Type');

    final contentType = data is FormData
        ? Headers.multipartFormDataContentType
        : Headers.jsonContentType;
    return baseOptions.copyWith(
      headers: headers,
      contentType: contentType,
    );
  }
}

String _resolveBaseUrl() {
  const overrideUrl = String.fromEnvironment('API_BASE_URL');
  if (overrideUrl.isNotEmpty) {
    return _normalizeBaseUrl(overrideUrl);
  }

  if (kIsWeb) return 'http://localhost:8000';

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'http://10.0.2.2:8000';
    case TargetPlatform.iOS:
      return 'http://localhost:8000';
    default:
      return 'http://localhost:8000';
  }
}

String _normalizeBaseUrl(String url) {
  if (url.endsWith('/')) return url.substring(0, url.length - 1);
  return url;
}
