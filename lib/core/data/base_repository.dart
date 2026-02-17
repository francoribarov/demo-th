import 'package:dartz/dartz.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/core/resources/data_state.dart';

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
  /// 4. Returns the domain model
  ///
  /// Type parameters:
  /// - [Dto]: The DTO type that implements [BaseDtoResponse<T>]
  /// - [T]: The domain model type
  ///
  /// Throws any exceptions from the datasource or mapping process.
  Future<T> executeDataSource<Dto extends BaseDtoResponse<T>, T>({
    required Future<Dto> Function() function,
  }) async {
    try {
      final dto = await function();
      return dto.toDomainModel();
    } catch (e) {
      // Re-throw to let repository handle errors according to its needs
      // (e.g., convert to domain exceptions, log, etc.)
      rethrow;
    }
  }

  /// Executes a datasource function for list responses and maps each item.
  ///
  /// This is a convenience method for handling list responses where each
  /// item needs to be mapped from DTO to domain model.
  ///
  /// Type parameters:
  /// - [Dto]: The DTO type that implements [BaseDtoResponse<T>]
  /// - [T]: The domain model type
  Future<List<T>> executeDataSourceList<Dto extends BaseDtoResponse<T>, T>({
    required Future<List<Dto>> Function() function,
  }) async {
    try {
      final dtos = await function();
      return dtos.map((dto) => dto.toDomainModel()).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Converts a [DataState] to an [Either] for use in domain layer.
  ///
  /// This helper method bridges the data layer ([DataState]) with the domain
  /// layer ([Either]). It converts:
  /// - [DataSuccess] → [Right] with the data
  /// - [DataFailed] → [Left] with the domain exception
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Future<Either<DomainException, User>> getUser(String id) async {
  ///   final result = await _dataSource.fetchUser(id);
  ///   return toEither(result);
  /// }
  /// ```
  Either<DomainException, T> toEither<T>(DataState<T> state) {
    return state.when(
      success: Right.new,
      failed: (error) => Left(error.toDomainException()),
    );
  }
}
