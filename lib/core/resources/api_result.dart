import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/errors/data/data_exception.dart';

part 'api_result.freezed.dart';

/// ApiResult handles success and failure responses from remote operations.
@freezed
sealed class ApiResult<T> with _$ApiResult<T> {
  /// Successful remote response.
  const factory ApiResult.success({required T data}) = Success<T>;

  /// Failed remote response with structured data-layer error.
  const factory ApiResult.failure({required DataException dataException}) =
      Failure<T>;
}
