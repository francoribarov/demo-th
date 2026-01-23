import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/my_publications/data/datasources/rental_requests_datasource.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/rental_request.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/repositories/my_publications_repository.dart';

@LazySingleton(as: MyPublicationsRepository)
class MyPublicationsRepositoryImpl implements MyPublicationsRepository {
  MyPublicationsRepositoryImpl(this._dataSource);

  final RentalRequestsDataSource _dataSource;

  @override
  Future<List<RentalRequest>> getRentalRequests() {
    return _dataSource.getRentalRequests();
  }

  @override
  Future<void> acceptRentalRequest(String requestId) {
    return _dataSource.acceptRentalRequest(requestId);
  }

  @override
  Future<void> rejectRentalRequest(String requestId) {
    return _dataSource.rejectRentalRequest(requestId);
  }
}
