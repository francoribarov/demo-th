import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/domain/repository/publish/delivery_method_repository.dart';

/// Creates a delivery method via the delivery method repository.
@injectable
class CreateDeliveryMethodUseCase {
  const CreateDeliveryMethodUseCase(this._repository);

  final DeliveryMethodRepository _repository;

  Future<Either<DomainException, DeliveryMethod>> call(
    DeliveryMethod method,
  ) {
    return _repository.createDeliveryMethod(method);
  }
}
