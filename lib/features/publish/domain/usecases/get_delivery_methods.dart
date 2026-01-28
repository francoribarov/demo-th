import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/repositories/delivery_method_repository.dart';

@injectable
class GetDeliveryMethods {

  GetDeliveryMethods(this._repository);
  final DeliveryMethodRepository _repository;

  Future<List<DeliveryMethod>> call() async {
    return _repository.getDeliveryMethods();
  }
}
