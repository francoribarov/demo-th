import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/errors/data/data_exception.dart';

void main() {
  RequestOptions options() => RequestOptions(path: '/test');

  DioException dioError({
    required DioExceptionType type,
    int? statusCode,
    dynamic data,
    String? message,
    Object? error,
  }) {
    return DioException(
      requestOptions: options(),
      type: type,
      response: statusCode == null
          ? null
          : Response<dynamic>(
              requestOptions: options(),
              statusCode: statusCode,
              data: data,
            ),
      message: message,
      error: error,
    );
  }

  test('maps timeout errors to timeout-style message', () {
    final ex = DataException.fromDioError(
      dioError(type: DioExceptionType.connectionTimeout),
    );

    expect(ex.message, contains('Connection timeout'));
    expect(ex.statusCode, isNull);
  });

  test('maps connection error to offline message', () {
    final ex = DataException.fromDioError(
      dioError(type: DioExceptionType.connectionError),
    );

    expect(ex.message, contains('No internet connection'));
  });

  test('maps 401/403 bad responses with status code', () {
    final ex = DataException.fromDioError(
      dioError(
        type: DioExceptionType.badResponse,
        statusCode: 401,
        data: {'message': 'Token expired'},
      ),
    );

    expect(ex.statusCode, 401);
    expect(ex.message, 'Token expired');
  });

  test('maps 422 bad response with extracted message and payload', () {
    final payload = {
      'message': 'Validation failed',
      'errors': {
        'email': ['Invalid email'],
      },
    };

    final ex = DataException.fromDioError(
      dioError(
        type: DioExceptionType.badResponse,
        statusCode: 422,
        data: payload,
      ),
    );

    expect(ex.statusCode, 422);
    expect(ex.message, 'Validation failed');
    expect(ex.data, payload);
  });

  test('maps 5xx with nested fault payload message', () {
    final payload = {
      'fault': {
        'faultstring': 'Upstream gateway failure',
      },
    };

    final ex = DataException.fromDioError(
      dioError(
        type: DioExceptionType.badResponse,
        statusCode: 500,
        data: payload,
      ),
    );

    expect(ex.statusCode, 500);
    expect(ex.message, 'Upstream gateway failure');
  });

  test('uses safe fallback for unknown payloads', () {
    final ex = DataException.fromDioError(
      dioError(
        type: DioExceptionType.badResponse,
        statusCode: 400,
        data: 'unexpected-format',
      ),
    );

    expect(ex.statusCode, 400);
    expect(ex.message, 'Request failed');
  });
}
