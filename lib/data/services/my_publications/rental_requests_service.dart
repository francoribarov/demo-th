import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/data/dto/rental/my_rental_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rental_requests_service.g.dart';

/// Retrofit service for rental requests API endpoints.
///
/// Defines HTTP operations for managing rental requests on user's publications
/// using Retrofit annotations. The implementation is generated at build time.
@RestApi()
abstract class RentalRequestsService {
  /// Creates a [RentalRequestsService] instance with the provided Dio client.
  ///
  /// The base URL is automatically set by DioClient.
  @factoryMethod
  factory RentalRequestsService(Dio dio) = _RentalRequestsService;

  /// Retrieves all rental requests for the current user's publications.
  ///
  /// GET /api/rentals/requests
  ///
  /// Returns a list of rental request models.
  ///
  /// Throws [DioException] on network or server errors.
  @GET('/api/rentals/requests')
  Future<List<MyRentalModel>> getRentalRequests();

  /// Accepts a rental request.
  ///
  /// POST /api/rentals/{id}/accept
  ///
  /// Parameters:
  /// - [id]: The rental request ID
  ///
  /// Returns a Future that completes when the request is accepted.
  ///
  /// Throws [DioException] on network or server errors.
  @POST('/api/rentals/{id}/accept')
  Future<void> acceptRentalRequest(@Path('id') String id);

  /// Rejects a rental request.
  ///
  /// POST /api/rentals/{id}/reject
  ///
  /// Parameters:
  /// - [id]: The rental request ID
  ///
  /// Returns a Future that completes when the request is rejected.
  ///
  /// Throws [DioException] on network or server errors.
  @POST('/api/rentals/{id}/reject')
  Future<void> rejectRentalRequest(@Path('id') String id);
}
