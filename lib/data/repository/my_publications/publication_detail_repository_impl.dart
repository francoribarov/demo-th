import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/core/resources/data_state.dart';
import 'package:mobile_table_hopping/data/datasource/my_publications/publication_detail_data_source.dart';
import 'package:mobile_table_hopping/data/mapper/my_publications/publication_update_to_body.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_detail.dart';
import 'package:mobile_table_hopping/domain/params/my_publications/update_publication_params.dart';
import 'package:mobile_table_hopping/domain/repository/my_publications/publication_detail_repository.dart';

/// Implementation of [PublicationDetailRepository] using remote data source.
///
/// This repository bridges the domain and data layers, handling:
/// - Conversion from domain params to data DTOs
/// - DTO to domain model mapping
/// - Error handling and transformation
/// - Data state to Either conversion
///
/// Example flow for update:
/// 1. Receives [UpdatePublicationParams] from use case
/// 2. Converts to `PublicationUpdateBody` via mapper
/// 3. Calls data source
/// 4. Maps DTO to domain model
/// 5. Converts data state to [Either] for domain layer
@LazySingleton(as: PublicationDetailRepository)
class PublicationDetailRepositoryImpl extends BaseRepository
    implements PublicationDetailRepository {
  /// Creates the repository with the remote data source.
  PublicationDetailRepositoryImpl(this._dataSource);

  final PublicationDetailRemoteDataSource _dataSource;

  @override
  Future<Either<DomainException, PublicationDetail>> getPublicationDetail(
    String id,
  ) async {
    // Execute data source operation
    final dataState = await _dataSource.getPublicationDetail(id);

    // Map DTO to domain model within DataState
    final mappedState = dataState.map(
      success: (data) => DataState.success(data.data.toDomainModel()),
      failed: (error) => DataState<PublicationDetail>.failed(error.error),
    );

    // Convert DataState to Either for domain layer
    return toEither(mappedState);
  }

  @override
  Future<Either<DomainException, PublicationDetail>> updatePublication(
    UpdatePublicationParams params,
  ) async {
    // Convert domain params to data DTO using mapper extension
    final body = params.toBody();

    // Execute data source operation
    final dataState = await _dataSource.updatePublication(params.id, body);

    // Map DTO to domain model within DataState
    final mappedState = dataState.map(
      success: (data) => DataState.success(data.data.toDomainModel()),
      failed: (error) => DataState<PublicationDetail>.failed(error.error),
    );

    // Convert DataState to Either for domain layer
    return toEither(mappedState);
  }

  @override
  Future<Either<DomainException, void>> deletePublication(String id) async {
    // Execute data source operation
    final result = await _dataSource.deletePublication(id);

    // Convert DataState to Either for domain layer
    return toEither(result);
  }
}
