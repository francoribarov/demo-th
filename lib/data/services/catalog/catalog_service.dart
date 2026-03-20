import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/data/dto/catalog/game_model.dart';
import 'package:mobile_table_hopping/data/dto/catalog/publication_listing_model.dart';
import 'package:retrofit/retrofit.dart';

part 'catalog_service.g.dart';

/// Retrofit service for catalog API endpoints.
@RestApi()
abstract class CatalogService {
  /// Creates a [CatalogService] instance with the provided Dio client.
  @factoryMethod
  factory CatalogService(Dio dio) = _CatalogService;

  @GET('/api/publications')
  Future<dynamic> getPublications(@Queries() Map<String, String> queryParams);

  @GET('/api/publications/{id}')
  Future<PublicationListingModel> getPublicationById(@Path('id') String id);

  @GET('/api/publications/available-today')
  Future<dynamic> getPublicationsAvailableToday(@Query('limit') String limit);

  @GET('/api/publications')
  Future<dynamic> getRecommendedPublications(
    @Queries() Map<String, String> queryParams,
  );

  @GET('/api/publications/my-publications')
  Future<dynamic> getMyPublications();

  @GET('/api/categories')
  Future<dynamic> getCategories();

  @GET('/api/categories/filter-shortcuts')
  Future<dynamic> getFilterShortcuts();

  @GET('/api/publications')
  Future<dynamic> getPublicationListings(
    @Queries() Map<String, String> queryParams,
  );

  @GET('/api/games/{id}')
  Future<GameModel> getGameById(@Path('id') String id);

  @GET('/api/games')
  Future<dynamic> getGames();

  @GET('/api/publications/search')
  Future<dynamic> searchGames(@Queries() Map<String, String> queryParams);

  @GET('/api/games/{id}/recommended')
  Future<List<GameModel>> getRecommendedGames(@Path('id') String gameId);

  @POST('/api/games')
  Future<GameModel> createGame(@Body() Map<String, dynamic> body);
}
