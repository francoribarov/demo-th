import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/data/dto/rental/my_rental_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rental_service.g.dart';

/// Retrofit service for rental API endpoints.
@RestApi()
abstract class RentalService {
  /// Creates a [RentalService] instance with the provided Dio client.
  @factoryMethod
  factory RentalService(Dio dio) = _RentalService;

  /// Creates a new rental request.
  ///
  /// POST /api/rentals
  @POST('/api/rentals')
  Future<void> createRental(@Body() Map<String, dynamic> body);

  /// Retrieves rentals filtered by [role], [status], and sorted.
  ///
  /// GET /api/rentals
  @GET('/api/rentals')
  Future<List<MyRentalModel>> getMyRentals(
    @Query('role') String? role,
    @Query('status') String? status,
    @Query('sort_by') String? sortBy,
    @Query('sort_order') String? sortOrder,
  );

  /// Initiates the drop-off process for a rental.
  ///
  /// POST /api/rentals/{id}/drop-off
  @POST('/api/rentals/{id}/drop-off')
  Future<void> dropOffRental(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );
}
