import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/dto/rental/rental_drop_off_response.dart';
import 'package:mobile_table_hopping/domain/repository/rental/rental_repository.dart';

@injectable
class GetDropOffTicketUseCase {
  GetDropOffTicketUseCase(this._repository);

  final RentalRepository _repository;

  Future<Either<DomainException, RentalDropOffResponse>> call(String rentalId) {
    return _repository.getDropOffTicket(rentalId);
  }
}
