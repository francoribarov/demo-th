import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'catalog_service.g.dart';

/// Retrofit service for catalog API endpoints.
@RestApi()
abstract class CatalogService {
  /// Creates a [CatalogService] instance with the provided Dio client.
  @factoryMethod
  factory CatalogService(Dio dio) = _CatalogService;

  @GET(ApiConstants.publications)
  Future<dynamic> getPublications(@Queries() Map<String, String> queryParams);

  @GET('${ApiConstants.publications}/{id}')
  Future<dynamic> getPublicationById(@Path('id') String id);

  @GET('${ApiConstants.publications}/available-today')
  Future<dynamic> getPublicationsAvailableToday(@Query('limit') String limit);

  @GET(ApiConstants.publications)
  Future<dynamic> getRecommendedPublications(
    @Queries() Map<String, String> queryParams,
  );

  @GET('${ApiConstants.publications}/my-publications')
  Future<dynamic> getMyPublications();

  @GET(ApiConstants.categories)
  Future<dynamic> getCategories();

  @GET(ApiConstants.filterShortcuts)
  Future<dynamic> getFilterShortcuts();

  @GET(ApiConstants.publications)
  Future<dynamic> getPublicationListings(
    @Queries() Map<String, String> queryParams,
  );

  @GET('${ApiConstants.games}/{id}')
  Future<dynamic> getGameById(@Path('id') String id);

  @GET(ApiConstants.games)
  Future<dynamic> getGames();

  @GET('${ApiConstants.publications}/search')
  Future<dynamic> searchGames(@Queries() Map<String, String> queryParams);

  @GET('${ApiConstants.games}/{id}/recommended')
  Future<dynamic> getRecommendedGames(@Path('id') String gameId);
}
