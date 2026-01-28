import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/publish/data/datasources/delivery_method_data_source.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/repositories/delivery_method_repository.dart';

@LazySingleton(as: DeliveryMethodRepository)
class DeliveryMethodRepositoryImpl implements DeliveryMethodRepository {

  DeliveryMethodRepositoryImpl(this._dataSource);
  final DeliveryMethodDataSource _dataSource;

  @override
  Future<DeliveryMethod> createDeliveryMethod(DeliveryMethod method) async {
    return _dataSource.createDeliveryMethod(method);
  }

  @override
  Future<List<DeliveryMethod>> getDeliveryMethods() async {
    return _dataSource.getDeliveryMethods();
  }
}
