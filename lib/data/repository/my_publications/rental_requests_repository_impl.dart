import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/datasource/my_publications/rental_requests_data_source.dart';
import 'package:mobile_table_hopping/data/dto/my_publications/rental_request_model.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/repository/my_publications/rental_requests_repository.dart';

/// Implementation of [RentalRequestsRepository] using remote data source.
///
/// This repository bridges the domain and data layers, handling:
/// - DTO to domain model mapping
/// - Error handling and transformation
/// - ApiResult to Either conversion
///
/// Example flow:
/// 1. Receives request from use case
/// 2. Calls data source
/// 3. Maps DTOs to domain models (for list operations)
/// 4. Converts ApiResult to [Either] for domain layer
@LazySingleton(as: RentalRequestsRepository)
class RentalRequestsRepositoryImpl extends BaseRepository
    implements RentalRequestsRepository {
  /// Creates the repository with the remote data source.
  RentalRequestsRepositoryImpl(this._dataSource);

  final RentalRequestsRemoteDataSource _dataSource;

  @override
  Future<Either<DomainException, List<RentalRequest>>>
      getRentalRequests() async {
    return executeDataSourceList<RentalRequestModel, RentalRequest>(
      function: _dataSource.getRentalRequests,
    );
  }

  @override
  Future<Either<DomainException, void>> acceptRentalRequest(String id) async {
    return executeVoidDataSource(
      function: () => _dataSource.acceptRentalRequest(id),
    );
  }

  @override
  Future<Either<DomainException, void>> rejectRentalRequest(String id) async {
    return executeVoidDataSource(
      function: () => _dataSource.rejectRentalRequest(id),
    );
  }
}
