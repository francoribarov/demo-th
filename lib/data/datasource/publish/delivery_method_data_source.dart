import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/core/resources/data_state.dart';
import 'package:mobile_table_hopping/data/dto/publish/delivery_method_model.dart';
import 'package:mobile_table_hopping/data/services/publish/publish_service.dart';

/// Remote datasource for delivery method operations.
abstract class DeliveryMethodRemoteDataSource {
  /// Creates a delivery method.
  Future<DataState<DeliveryMethodModel>> createDeliveryMethod(
    DeliveryMethodModel model,
  );

  /// Gets all delivery methods for the current user.
  Future<DataState<List<DeliveryMethodModel>>> getDeliveryMethods();
}

/// Remote datasource implementation using [PublishService].
@LazySingleton(as: DeliveryMethodRemoteDataSource)
class DeliveryMethodRemoteDataSourceImpl extends BaseDataSource
    implements DeliveryMethodRemoteDataSource {
  DeliveryMethodRemoteDataSourceImpl(this._service);

  final PublishService _service;

  @override
  Future<DataState<DeliveryMethodModel>> createDeliveryMethod(
    DeliveryMethodModel model,
  ) {
    return getStateOf<DeliveryMethodModel>(
      request: () => _service.createDeliveryMethod(model.toJson()),
    );
  }

  @override
  Future<DataState<List<DeliveryMethodModel>>> getDeliveryMethods() {
    return getStateOf<List<DeliveryMethodModel>>(
      request: _service.getDeliveryMethods,
    );
  }
}
