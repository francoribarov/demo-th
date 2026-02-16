import 'package:dartz/dartz.dart';
import 'package:mobile_table_hopping/core/errors/data/data_exception_mapper.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';

/// Base repository class providing common utilities for repository implementations.
///
/// This class provides helper methods to reduce boilerplate in repository
/// implementations, particularly for mapping DTOs to domain models.
///
/// Example:
/// ```dart
/// @LazySingleton(as: PublishRepository)
/// class PublishRepositoryImpl extends BaseRepository implements PublishRepository {
///   PublishRepositoryImpl(this._remote);
///
///   final PublishRemoteDatasource _remote;
///
///   @override
///   Future<Publication> createPublication(PublicationDraft draft) async {
///     return executeDataSource<PublicationResponse, Publication>(
///       function: () => _remote.createPublication(
///         PublicationCreateRequestModel.fromEntity(draft),
///       ),
///     );
///   }
/// }
/// ```
abstract class BaseRepository {
  /// Executes a datasource function and automatically maps the DTO to domain model.
  ///
  /// This method:
  /// 1. Calls the provided datasource function
  /// 2. Receives the DTO response
  /// 3. Automatically calls `toDomainModel()` on the DTO
  /// 4. Returns [Right] with the domain model or [Left] with a domain error
  ///
  /// Type parameters:
  /// - [Dto]: The DTO type that implements [BaseDtoResponse<T>]
  /// - [T]: The domain model type
  ///
  Future<Either<DomainException, T>>
  executeDataSource<Dto extends BaseDtoResponse<T>, T>({
    required Future<ApiResult<Dto>> Function() function,
  }) async {
    final state = await function();
    return state.when(
      success: (dto) => Right(dto.toDomainModel()),
      failure: (error) => Left(error.toDomainException()),
    );
  }

  /// Executes a datasource function for list responses and maps each item.
  ///
  /// This is a convenience method for handling list responses where each
  /// item needs to be mapped from DTO to domain model.
  ///
  /// Type parameters:
  /// - [Dto]: The DTO type that implements [BaseDtoResponse<T>]
  /// - [T]: The domain model type
  Future<Either<DomainException, List<T>>>
  executeDataSourceList<Dto extends BaseDtoResponse<T>, T>({
    required Future<ApiResult<List<Dto>>> Function() function,
  }) async {
    final state = await function();
    return state.when(
      success: (dtos) => Right(dtos.map((dto) => dto.toDomainModel()).toList()),
      failure: (error) => Left(error.toDomainException()),
    );
  }

  /// Executes a datasource list function and maps each DTO with a custom mapper.
  Future<Either<DomainException, List<T>>> executeDataSourceListMapped<Dto, T>({
    required Future<ApiResult<List<Dto>>> Function() function,
    required T Function(Dto dto) mapper,
  }) async {
    final state = await function();
    return state.when(
      success: (dtos) => Right(dtos.map(mapper).toList()),
      failure: (error) => Left(error.toDomainException()),
    );
  }

  /// Executes a void datasource function and converts result to [Either].
  Future<Either<DomainException, void>> executeVoidDataSource({
    required Future<ApiResult<void>> Function() function,
  }) async {
    final state = await function();
    return state.when(
      success: (_) => const Right(null),
      failure: (error) => Left(error.toDomainException()),
    );
  }

  /// Unwraps an [ApiResult], returning data or throwing a [DomainException].
  Future<T> unwrapOrThrow<T>(Future<ApiResult<T>> Function() function) async {
    final state = await function();
    return state.when(
      success: (data) => data,
      failure: (error) => throw error.toDomainException(),
    );
  }

  /// Converts an [ApiResult] to an [Either] for use in domain layer.
  ///
  /// This helper method bridges the data layer ([ApiResult]) with the domain
  /// layer ([Either]). It converts:
  /// - [Success] → [Right] with the data
  /// - [Failure] → [Left] with the domain exception
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Future<Either<DomainException, User>> getUser(String id) async {
  ///   final result = await _dataSource.fetchUser(id);
  ///   return toEither(result);
  /// }
  /// ```
  Either<DomainException, T> toEither<T>(ApiResult<T> state) {
    return state.when(
      success: Right.new,
      failure: (error) => Left(error.toDomainException()),
    );
  }
}
