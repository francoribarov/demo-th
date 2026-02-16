import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/core/resources/data_state.dart';
import 'package:mobile_table_hopping/data/dto/publish/publication_model.dart';
import 'package:mobile_table_hopping/data/services/publish/publish_service.dart';

/// Remote datasource contract for publishing publications.
// ignore: one_member_abstracts
abstract class PublishRemoteDataSource {
  /// Creates a publication on the backend.
  Future<DataState<PublicationModel>> createPublication(
    PublicationCreateRequestModel request,
  );
}

/// Remote datasource implementation using Retrofit service.
///
/// Extends [BaseDataSource] to leverage the standard error handling
/// and [DataState] wrapping pattern.
@LazySingleton(as: PublishRemoteDataSource)
class PublishRemoteDataSourceImpl extends BaseDataSource
    implements PublishRemoteDataSource {
  /// Creates a datasource backed by the Retrofit service.
  PublishRemoteDataSourceImpl(this._service);

  final PublishService _service;

  @override
  Future<DataState<PublicationModel>> createPublication(
    PublicationCreateRequestModel request,
  ) {
    return getStateOf<PublicationModel>(
      request: () => _service.createPublication(request.toJson()),
    );
  }
}
