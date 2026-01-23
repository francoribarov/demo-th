import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Creates a pretty logging interceptor for Dio.
/// Only logs in debug mode.
PrettyDioLogger createLoggingInterceptor() {
  return PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    compact: true,
    maxWidth: 90,
    enabled: kDebugMode,
  );
}
