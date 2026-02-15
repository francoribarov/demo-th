import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/errors/data/data_exception.dart';

part 'data_state.freezed.dart';

/// Represents the result of a data layer operation.
///
/// [DataState] is a sealed union type that wraps data-layer results,
/// providing explicit success/failure handling.
///
/// Use [DataSuccess] to wrap successful results and [DataFailed] to wrap errors.
///
/// Example:
/// ```dart
/// Future<DataState<User>> getUser() async {
///   try {
///     final user = await _api.fetchUser();
///     return DataState.success(user);
///   } on DioException catch (e) {
///     return DataState.failed(DataException.fromDioError(e));
///   }
/// }
/// ```
@freezed
sealed class DataState<T> with _$DataState<T> {
  /// Represents a successful data operation with the resulting data.
  const factory DataState.success(T data) = DataSuccess<T>;

  /// Represents a failed data operation with the error details.
  const factory DataState.failed(DataException error) = DataFailed<T>;
}
