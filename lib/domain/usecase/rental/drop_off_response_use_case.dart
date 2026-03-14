import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/repository/rental/rental_repository.dart';

@injectable
class DropOffResponseUseCase {
  DropOffResponseUseCase(this._repository);

  final RentalRepository _repository;

  Future<Either<DomainException, void>> call(
    String rentalId,
    String status,
    String ticketId, {
    String? rejectionReason,
  }) {
    return _repository.dropOffResponse(
      rentalId,
      status,
      ticketId,
      rejectionReason: rejectionReason,
    );
  }
}
