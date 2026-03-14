import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/datasource/my_publications/publication_detail_data_source.dart';
import 'package:mobile_table_hopping/data/dto/my_publications/publication_detail_model.dart';
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
/// - ApiResult to Either conversion
///
/// Example flow for update:
/// 1. Receives [UpdatePublicationParams] from use case
/// 2. Converts to `PublicationUpdateBody` via mapper
/// 3. Calls data source
/// 4. Maps DTO to domain model
/// 5. Converts ApiResult to [Either] for domain layer
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
    return executeDataSource<PublicationDetailModel, PublicationDetail>(
      function: () => _dataSource.getPublicationDetail(id),
    );
  }

  @override
  Future<Either<DomainException, PublicationDetail>> updatePublication(
    UpdatePublicationParams params,
  ) async {
    final body = params.toBody();
    return executeDataSource<PublicationDetailModel, PublicationDetail>(
      function: () => _dataSource.updatePublication(params.id, body),
    );
  }

  @override
  Future<Either<DomainException, void>> deletePublication(String id) async {
    return executeVoidDataSource(
      function: () => _dataSource.deletePublication(id),
    );
  }
}
