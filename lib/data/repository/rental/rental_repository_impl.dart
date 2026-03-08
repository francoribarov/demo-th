import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/datasource/rental/rental_data_source.dart';
import 'package:mobile_table_hopping/data/dto/rental/drop_off_body.dart';
import 'package:mobile_table_hopping/data/dto/rental/my_rental_model.dart';
import 'package:mobile_table_hopping/data/mapper/rental/rental_to_data_model.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/params/rental/confirm_rental_params.dart';
import 'package:mobile_table_hopping/domain/repository/rental/rental_repository.dart';

/// Implementation of [RentalRepository] using remote data source.
///
/// This repository bridges the domain and data layers, handling:
/// - Conversion from domain params to data DTOs
/// - Error handling and transformation
/// - ApiResult to Either conversion
///
/// Example flow:
/// 1. Receives [ConfirmRentalParams] from use case
/// 2. Converts to `ConfirmRentalBody` via mapper
/// 3. Calls data source
/// 4. Converts ApiResult to [Either] for domain layer
@LazySingleton(as: RentalRepository)
class RentalRepositoryImpl extends BaseRepository implements RentalRepository {
  /// Creates the repository with the remote data source.
  RentalRepositoryImpl(this._dataSource);

  final RentalRemoteDataSource _dataSource;

  @override
  Future<Either<DomainException, void>> confirmRental(
    ConfirmRentalParams params,
  ) async {
    final body = params.toBody();
    return executeVoidDataSource(
      function: () => _dataSource.createRental(body),
    );
  }

  @override
  Future<Either<DomainException, List<RentalRequest>>> getMyRentals() {
    return executeDataSourceList<MyRentalModel, RentalRequest>(
      function: _dataSource.getMyRentals,
    );
  }

  @override
  Future<Either<DomainException, void>> dropOffRental(
    String rentalId,
    String imagePath,
  ) {
    return executeVoidDataSource(
      function: () => _dataSource.dropOffRental(
        rentalId,
        DropOffBody(
          dropOffDate: DateTime.now().toIso8601String().split('T').first,
          images: [imagePath],
        ),
      ),
    );
  }
}
