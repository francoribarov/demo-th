import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/data/dto/rental/confirm_rental_body.dart';
import 'package:retrofit/retrofit.dart';

part 'rental_service.g.dart';

/// Retrofit service for rental API endpoints.
///
/// Defines HTTP operations for rental-related requests using Retrofit
/// annotations. The implementation is generated at build time.
///
/// Example:
/// ```dart
/// @injectable
/// class RentalDataSource {
///   RentalDataSource(this._service);
///
///   final RentalService _service;
///
///   Future<void> createRental(ConfirmRentalBody body) {
///     return _service.createRental(body);
///   }
/// }
/// ```
@RestApi()
// Retrofit services can validly expose a single endpoint per feature module.
// ignore: one_member_abstracts
abstract class RentalService {
  /// Creates a [RentalService] instance with the provided Dio client.
  ///
  /// The base URL is automatically set from [ApiConstants.baseUrl].
  @factoryMethod
  factory RentalService(Dio dio) = _RentalService;

  /// Creates a new rental request.
  ///
  /// POST /api/rentals
  ///
  /// Parameters:
  /// - [body]: The rental confirmation request data
  ///
  /// Returns a Future that completes when the rental is created.
  ///
  /// Throws [DioException] on network or server errors.
  @POST(ApiConstants.rentals)
  Future<void> createRental(@Body() ConfirmRentalBody body);
}
