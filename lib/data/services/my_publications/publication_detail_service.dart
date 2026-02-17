import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/data/dto/my_publications/publication_detail_model.dart';
import 'package:mobile_table_hopping/data/dto/my_publications/publication_update_body.dart';
import 'package:retrofit/retrofit.dart';

part 'publication_detail_service.g.dart';

/// Retrofit service for publication detail API endpoints.
///
/// Defines HTTP operations for managing individual publications using Retrofit
/// annotations. The implementation is generated at build time.
@RestApi()
abstract class PublicationDetailService {
  /// Creates a [PublicationDetailService] instance with the provided Dio client.
  ///
  /// The base URL is automatically set from [ApiConstants.baseUrl].
  @factoryMethod
  factory PublicationDetailService(Dio dio) = _PublicationDetailService;

  /// Retrieves detailed information about a specific publication.
  ///
  /// GET /api/publications/{id}
  ///
  /// Parameters:
  /// - [id]: The publication ID
  ///
  /// Returns the publication detail model.
  ///
  /// Throws [DioException] on network or server errors.
  @GET('${ApiConstants.publications}/{id}')
  Future<PublicationDetailModel> getPublicationDetail(
    @Path('id') String id,
  );

  /// Updates an existing publication.
  ///
  /// PUT /api/publications/{id}
  ///
  /// Parameters:
  /// - [id]: The publication ID
  /// - [body]: The update request data
  ///
  /// Returns the updated publication detail model.
  ///
  /// Throws [DioException] on network or server errors.
  @PUT('${ApiConstants.publications}/{id}')
  Future<PublicationDetailModel> updatePublication(
    @Path('id') String id,
    @Body() PublicationUpdateBody body,
  );

  /// Deletes a publication.
  ///
  /// DELETE /api/publications/{id}
  ///
  /// Parameters:
  /// - [id]: The publication ID
  ///
  /// Returns a Future that completes when the publication is deleted.
  ///
  /// Throws [DioException] on network or server errors.
  @DELETE('${ApiConstants.publications}/{id}')
  Future<void> deletePublication(@Path('id') String id);
}
