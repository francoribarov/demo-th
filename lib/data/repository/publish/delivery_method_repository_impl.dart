import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/datasource/publish/delivery_method_data_source.dart';
import 'package:mobile_table_hopping/data/dto/publish/delivery_method_model.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/domain/repository/publish/delivery_method_repository.dart';

/// Repository implementation for delivery method operations.
///
/// This repository bridges the domain and data layers, handling:
/// - Conversion from ApiResult to Either
/// - DTO to domain model mapping
/// - Error handling and transformation
@LazySingleton(as: DeliveryMethodRepository)
class DeliveryMethodRepositoryImpl extends BaseRepository
    implements DeliveryMethodRepository {
  DeliveryMethodRepositoryImpl(this._dataSource);

  final DeliveryMethodRemoteDataSource _dataSource;

  @override
  Future<Either<DomainException, DeliveryMethod>> createDeliveryMethod(
    DeliveryMethod method,
  ) async {
    return executeDataSource<DeliveryMethodModel, DeliveryMethod>(
      function: () => _dataSource.createDeliveryMethod(
        DeliveryMethodModel.fromEntity(method),
      ),
    );
  }

  @override
  Future<Either<DomainException, List<DeliveryMethod>>>
  getDeliveryMethods() async {
    return executeDataSourceList<DeliveryMethodModel, DeliveryMethod>(
      function: _dataSource.getDeliveryMethods,
    );
  }
}
