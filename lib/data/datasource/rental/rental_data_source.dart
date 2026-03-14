import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/data/dto/rental/confirm_rental_body.dart';
import 'package:mobile_table_hopping/data/dto/rental/drop_off_body.dart';
import 'package:mobile_table_hopping/data/dto/rental/my_rental_model.dart';
import 'package:mobile_table_hopping/data/dto/rental/rental_drop_off_response.dart';
import 'package:mobile_table_hopping/data/services/rental/rental_service.dart';

/// Remote datasource contract for rental operations.
abstract class RentalRemoteDataSource {
  /// Creates a new rental request on the server.
  Future<ApiResult<void>> createRental(ConfirmRentalBody body);

  /// Retrieves all rentals for the current user.
  Future<ApiResult<List<MyRentalModel>>> getMyRentals();

  /// Initiates the drop-off process by uploading a proof image.
  Future<ApiResult<void>> dropOffRental(String rentalId, DropOffBody body);

  /// Retrieves the drop-off ticket for a given rental.
  Future<ApiResult<RentalDropOffResponse>> getDropOffTicket(String rentalId);

  /// Responds to a drop-off request (owner).
  Future<ApiResult<void>> dropOffResponse(
    String rentalId,
    String status,
    String ticketId, {
    String? rejectionReason,
  });
}

/// Implementation of [RentalRemoteDataSource].
@LazySingleton(as: RentalRemoteDataSource)
class RentalRemoteDataSourceImpl extends BaseDataSource
    implements RentalRemoteDataSource {
  /// Creates a data source with the provided service.
  RentalRemoteDataSourceImpl(this._service);

  final RentalService _service;

  @override
  Future<ApiResult<void>> createRental(ConfirmRentalBody body) {
    return getStateOf<void>(
      request: () => _service.createRental(body.toJson()),
    );
  }

  @override
  Future<ApiResult<List<MyRentalModel>>> getMyRentals() {
    return getStateOf<List<MyRentalModel>>(
      request: () => _service.getMyRentals('renter'),
    );
  }

  @override
  Future<ApiResult<void>> dropOffRental(String rentalId, DropOffBody body) {
    return getStateOf<void>(
      request: () => _service.dropOffRental(
        rentalId,
        body.toJson(),
      ),
    );
  }

  @override
  Future<ApiResult<RentalDropOffResponse>> getDropOffTicket(String rentalId) {
    return getStateOf<RentalDropOffResponse>(
      request: () => _service.getDropOffTicket(rentalId),
    );
  }

  @override
  Future<ApiResult<void>> dropOffResponse(
    String rentalId,
    String status,
    String ticketId, {
    String? rejectionReason,
  }) {
    return getStateOf<void>(
      request: () => _service.dropOffResponse(
        rentalId,
        {
          'status': status,
          'ticketId': ticketId,
          'rejectionReason': ?rejectionReason,
        },
      ),
    );
  }
}
