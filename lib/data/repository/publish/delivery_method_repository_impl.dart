import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/core/resources/data_state.dart';
import 'package:mobile_table_hopping/data/datasource/publish/delivery_method_data_source.dart';
import 'package:mobile_table_hopping/data/dto/publish/delivery_method_model.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/domain/repository/publish/delivery_method_repository.dart';

/// Repository implementation for delivery method operations.
///
/// This repository bridges the domain and data layers, handling:
/// - Conversion from DataState to Either
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
    final result = await _dataSource.createDeliveryMethod(
      DeliveryMethodModel.fromEntity(method),
    );

    return toEither(
      result.when(
        success: (DeliveryMethodModel dto) =>
            DataState.success(dto.toDomainModel()),
        failed: DataState.failed,
      ),
    );
  }

  @override
  Future<Either<DomainException, List<DeliveryMethod>>>
      getDeliveryMethods() async {
    final result = await _dataSource.getDeliveryMethods();

    return toEither(
      result.when(
        success: (List<DeliveryMethodModel> dtos) => DataState.success(
          dtos.map((DeliveryMethodModel dto) => dto.toDomainModel()).toList(),
        ),
        failed: DataState.failed,
      ),
    );
  }
}
