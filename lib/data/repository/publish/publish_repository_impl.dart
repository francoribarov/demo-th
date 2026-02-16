import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/datasource/publish/publish_data_source.dart';
import 'package:mobile_table_hopping/data/dto/publish/publication_model.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/repository/publish/publish_repository.dart';

/// Repository implementation for publish actions.
///
/// This repository bridges the domain and data layers, handling:
/// - Conversion from ApiResult to Either
/// - DTO to domain model mapping
/// - Error handling and transformation
@LazySingleton(as: PublishRepository)
class PublishRepositoryImpl extends BaseRepository
    implements PublishRepository {
  /// Creates a repository backed by the remote datasource.
  PublishRepositoryImpl(this._dataSource);

  final PublishRemoteDataSource _dataSource;

  @override
  Future<Either<DomainException, Publication>> createPublication(
    PublicationDraft draft, {
    required String ownerId,
  }) async {
    return executeDataSource<PublicationModel, Publication>(
      function: () => _dataSource.createPublication(
        PublicationCreateRequestModel.fromEntity(draft, ownerId: ownerId),
      ),
    );
  }
}
