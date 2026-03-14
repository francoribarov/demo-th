import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';

class _TestDataSource extends BaseDataSource {
  Future<ApiResult<T>> run<T>(Future<T> Function() request) {
    return getStateOf<T>(request: request);
  }
}

void main() {
  late _TestDataSource dataSource;

  setUp(() {
    dataSource = _TestDataSource();
  });

  test('wraps successful request in ApiResult.success', () async {
    final result = await dataSource.run(() async => 42);

    expect(result, isA<Success<int>>());
    expect((result as Success<int>).data, 42);
  });

  test('wraps DioException in ApiResult.failure', () async {
    final result = await dataSource.run<int>(
      () async => throw DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      ),
    );

    expect(result, isA<Failure<int>>());
    final failure = result as Failure<int>;
    expect(failure.dataException.message, contains('Connection timeout'));
  });

  test('maps FormatException to predictable parsing message', () async {
    final result = await dataSource.run<int>(
      () async => throw const FormatException('Invalid response format'),
    );

    expect(result, isA<Failure<int>>());
    final failure = result as Failure<int>;
    expect(failure.dataException.message, 'Invalid response format');
  });

  test('maps TypeError to predictable type message', () async {
    final result = await dataSource.run<int>(
      () async {
        const dynamic value = 'not-an-int';
        return value as int;
      },
    );

    expect(result, isA<Failure<int>>());
    final failure = result as Failure<int>;
    expect(failure.dataException.message, contains('type'));
  });

  test('maps generic exceptions to normalized message', () async {
    final result = await dataSource.run<int>(
      () async => throw Exception('boom'),
    );

    expect(result, isA<Failure<int>>());
    final failure = result as Failure<int>;
    expect(failure.dataException.message, 'Exception: boom');
  });
}
