import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/domain/repository/publish/delivery_method_repository.dart';

/// Gets all delivery methods for the current user.
@injectable
class GetDeliveryMethodsUseCase {
  const GetDeliveryMethodsUseCase(this._repository);

  final DeliveryMethodRepository _repository;

  Future<Either<DomainException, List<DeliveryMethod>>> call() {
    return _repository.getDeliveryMethods();
  }
}
