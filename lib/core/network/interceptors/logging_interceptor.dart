import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logging interceptor for debugging.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('🌐 REQUEST[${options.method}] => URL: ${options.uri}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint(
        '✅ RESPONSE[${response.statusCode}] => URL: ${response.requestOptions.uri} DATA: ${response.data}',
      );
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
        debugPrint(
          '❌ ERROR[NO_RESPONSE] => URL: $url TYPE: ${err.type} MSG: ${err.message}',
        );
      }
      if (err.response?.data != null) {
        debugPrint('  data: ${_safeToString(err.response!.data)}');
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
}
