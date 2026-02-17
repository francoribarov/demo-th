import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/core/resources/data_state.dart';
import 'package:mobile_table_hopping/data/dto/my_publications/publication_detail_model.dart';
import 'package:mobile_table_hopping/data/dto/my_publications/publication_update_body.dart';
import 'package:mobile_table_hopping/data/services/my_publications/publication_detail_service.dart';

/// Remote datasource contract for publication detail operations.
///
/// Defines the interface for publication detail-related data operations
/// that interact with remote APIs.
abstract class PublicationDetailRemoteDataSource {
  /// Retrieves detailed information about a specific publication.
  ///
  /// Parameters:
  /// - [id]: The publication ID
  ///
  /// Returns:
  /// - [DataState.success] with publication detail model if successful
  /// - [DataState.failed] with error details if the operation failed
  Future<DataState<PublicationDetailModel>> getPublicationDetail(String id);

  /// Updates an existing publication.
  ///
  /// Parameters:
  /// - [id]: The publication ID
  /// - [body]: The update request data
  ///
  /// Returns:
  /// - [DataState.success] with updated publication detail model if successful
  /// - [DataState.failed] with error details if the operation failed
  Future<DataState<PublicationDetailModel>> updatePublication(
    String id,
    PublicationUpdateBody body,
  );

  /// Deletes a publication.
  ///
  /// Parameters:
  /// - [id]: The publication ID
  ///
  /// Returns:
  /// - [DataState.success] if the publication was deleted successfully
  /// - [DataState.failed] with error details if the operation failed
  Future<DataState<void>> deletePublication(String id);
}

/// Implementation of [PublicationDetailRemoteDataSource] using Retrofit service.
///
/// This class extends [BaseDataSource] to leverage the standard
/// error handling and [DataState] wrapping pattern.
///
/// Example:
/// ```dart
/// final result = await dataSource.getPublicationDetail('123');
/// result.when(
///   success: (model) => print('Got publication: ${model.description}'),
///   failed: (error) => print('Error: ${error.message}'),
/// );
/// ```
@LazySingleton(as: PublicationDetailRemoteDataSource)
class PublicationDetailRemoteDataSourceImpl extends BaseDataSource
    implements PublicationDetailRemoteDataSource {
  /// Creates a data source with the provided Retrofit service.
  PublicationDetailRemoteDataSourceImpl(this._service);

  final PublicationDetailService _service;

  @override
  Future<DataState<PublicationDetailModel>> getPublicationDetail(String id) {
    return getStateOf<PublicationDetailModel>(
      request: () => _service.getPublicationDetail(id),
    );
  }

  @override
  Future<DataState<PublicationDetailModel>> updatePublication(
    String id,
    PublicationUpdateBody body,
  ) {
    return getStateOf<PublicationDetailModel>(
      request: () => _service.updatePublication(id, body),
    );
  }

  @override
  Future<DataState<void>> deletePublication(String id) {
    return getStateOf<void>(
      request: () => _service.deletePublication(id),
    );
  }
}
