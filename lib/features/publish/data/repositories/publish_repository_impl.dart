import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/publish/data/datasources/publish_remote_datasource.dart';
import 'package:mobile_table_hopping/features/publish/data/models/publication_model.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';
import 'package:mobile_table_hopping/features/publish/domain/repositories/publish_repository.dart';

@LazySingleton(as: PublishRepository)
/// Repository implementation for publish actions.
class PublishRepositoryImpl implements PublishRepository {
  /// Creates a repository backed by the remote datasource.
  PublishRepositoryImpl(this._remote);
  final PublishRemoteDatasource _remote;

  @override
  Future<Publication> createPublication(PublicationDraft draft) async {
    final response = await _remote.createPublication(PublicationCreateRequestModel.fromEntity(draft));
    return response.toEntity();
  }
}
