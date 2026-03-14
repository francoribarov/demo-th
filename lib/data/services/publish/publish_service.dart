import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/data/dto/publish/delivery_method_model.dart';
import 'package:mobile_table_hopping/data/dto/publish/publication_model.dart';
import 'package:retrofit/retrofit.dart';

part 'publish_service.g.dart';

/// Retrofit service for publish API endpoints.
@RestApi()
abstract class PublishService {
  /// Creates a [PublishService] instance with the provided Dio client.
  @factoryMethod
  factory PublishService(Dio dio) = _PublishService;

  @POST('/api/publications')
  Future<PublicationModel> createPublication(@Body() Map<String, dynamic> body);

  @POST('/api/delivery-methods')
  Future<DeliveryMethodModel> createDeliveryMethod(
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/delivery-methods')
  Future<List<DeliveryMethodModel>> getDeliveryMethods();
}
