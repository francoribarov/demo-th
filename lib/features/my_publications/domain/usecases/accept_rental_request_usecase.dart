import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/repositories/my_publications_repository.dart';

@injectable
class AcceptRentalRequestUseCase {
  AcceptRentalRequestUseCase(this._repository);

  final MyPublicationsRepository _repository;

  Future<void> call(String requestId) {
    return _repository.acceptRentalRequest(requestId);
  }
}
