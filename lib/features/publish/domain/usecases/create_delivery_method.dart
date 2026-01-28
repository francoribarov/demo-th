import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/repositories/delivery_method_repository.dart';

@injectable
class CreateDeliveryMethod {
  CreateDeliveryMethod(this._repository);
  final DeliveryMethodRepository _repository;

  Future<DeliveryMethod> call(DeliveryMethod method) async {
    return _repository.createDeliveryMethod(method);
  }
}
