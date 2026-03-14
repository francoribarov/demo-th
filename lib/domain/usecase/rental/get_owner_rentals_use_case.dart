import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/repository/rental/rental_repository.dart';

@injectable
class GetOwnerRentalsUseCase {
  GetOwnerRentalsUseCase(this._repository);

  final RentalRepository _repository;

  Future<Either<DomainException, Tuple2<List<RentalRequest>, List<RentalRequest>>>> call() async {
    final activeRentals = await _repository.getMyRentals(
      role: 'owner',
      status: 'Active',
      sortBy: 'start_date',
      sortOrder: 'asc',
    );
    final acceptedRentals = await _repository.getMyRentals(
      role: 'owner',
      status: 'Accepted',
      sortBy: 'start_date',
      sortOrder: 'asc',
    );
    return activeRentals.fold(
      Left.new,
      (activeList) => acceptedRentals.fold(
        Left.new,
        (acceptedList) => Right(Tuple2(activeList, acceptedList)),
      ),
    );
  }
}
