import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logging interceptor for debugging.
class LoggingInterceptor extends Interceptor {
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
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint(
        '✅ RESPONSE[${response.statusCode}] => URL: ${response.requestOptions.uri}',
      );
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
        debugPrint(
          '❌ ERROR[NO_RESPONSE] => URL: $url TYPE: ${err.type} MSG: ${err.message}',
        );
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
