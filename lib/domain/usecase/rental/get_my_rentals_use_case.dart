import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/repository/rental/rental_repository.dart';

@injectable
class GetMyRentalsUseCase {
  GetMyRentalsUseCase(this._repository);

  final RentalRepository _repository;

  Future<Either<DomainException, List<RentalRequest>>> call() {
    return _repository.getMyRentals(role: 'renter');
  }
}
