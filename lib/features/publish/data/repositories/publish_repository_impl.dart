import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/publish/data/datasources/publish_remote_datasource.dart';
import 'package:mobile_table_hopping/features/publish/data/models/listing_model.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/listing.dart';
import 'package:mobile_table_hopping/features/publish/domain/repositories/publish_repository.dart';

@LazySingleton(as: PublishRepository)
/// Repository implementation for publish actions.
class PublishRepositoryImpl implements PublishRepository {
  /// Creates a repository backed by the remote datasource.
  PublishRepositoryImpl(this._remote);
  final PublishRemoteDatasource _remote;

  @override
  Future<Listing> createListing(ListingDraft draft) async {
    final response = await _remote.createListing(ListingCreateRequestModel.fromEntity(draft));
    return response.toEntity();
  }
}
