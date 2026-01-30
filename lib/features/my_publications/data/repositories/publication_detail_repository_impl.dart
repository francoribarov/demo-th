import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/features/my_publications/data/datasources/publication_detail_remote_datasource.dart';
import 'package:mobile_table_hopping/features/my_publications/data/models/publication_detail_model.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/publication_detail.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/repositories/publication_detail_repository.dart';

@LazySingleton(as: PublicationDetailRepository)

/// Repository implementation for publication detail operations.
class PublicationDetailRepositoryImpl extends BaseRepository
    implements PublicationDetailRepository {
  /// Creates a repository backed by the remote datasource.
  PublicationDetailRepositoryImpl(this._remote);

  final PublicationDetailRemoteDatasource _remote;

  @override
  Future<PublicationDetail> getPublicationDetail(String id) async {
    return executeDataSource<PublicationDetailModel, PublicationDetail>(
      function: () => _remote.getPublicationDetail(id),
    );
  }

  @override
  Future<PublicationDetail> updatePublication(
    String id,
    PublicationUpdate update,
  ) async {
    return executeDataSource<PublicationDetailModel, PublicationDetail>(
      function: () => _remote.updatePublication(
        id,
        PublicationUpdateRequestModel.fromEntity(update),
      ),
    );
  }

  @override
  Future<void> deletePublication(String id) async {
    await _remote.deletePublication(id);
  }
}
