import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/datasource/rental/rental_data_source.dart';
import 'package:mobile_table_hopping/data/mapper/rental/rental_to_data_model.dart';
import 'package:mobile_table_hopping/domain/params/rental/confirm_rental_params.dart';
import 'package:mobile_table_hopping/domain/repository/rental/rental_repository.dart';

/// Implementation of [RentalRepository] using remote data source.
///
/// This repository bridges the domain and data layers, handling:
/// - Conversion from domain params to data DTOs
/// - Error handling and transformation
/// - Data state to Either conversion
///
/// Example flow:
/// 1. Receives [ConfirmRentalParams] from use case
/// 2. Converts to [ConfirmRentalBody] via mapper
/// 3. Calls data source
/// 4. Converts [DataState] to [Either] for domain layer
@LazySingleton(as: RentalRepository)
class RentalRepositoryImpl extends BaseRepository
    implements RentalRepository {
  /// Creates the repository with the remote data source.
  RentalRepositoryImpl(this._dataSource);

  final RentalRemoteDataSource _dataSource;

  @override
  Future<Either<DomainException, void>> confirmRental(
    ConfirmRentalParams params,
  ) async {
    // Convert domain params to data DTO using mapper extension
    final body = params.toBody();

    // Execute data source operation
    final result = await _dataSource.createRental(body);

    // Convert DataState to Either for domain layer
    return toEither(result);
  }
}
