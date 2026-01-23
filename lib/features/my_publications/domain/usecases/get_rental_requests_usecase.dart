import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/rental_request.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/repositories/my_publications_repository.dart';

@injectable
class GetRentalRequestsUseCase {
  GetRentalRequestsUseCase(this._repository);

  final MyPublicationsRepository _repository;

  Future<List<RentalRequest>> call() {
    return _repository.getRentalRequests();
  }
}
