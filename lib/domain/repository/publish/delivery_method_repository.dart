import 'package:dartz/dartz.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';

/// Repository for delivery method operations.
abstract class DeliveryMethodRepository {
  /// Creates a new delivery method.
  Future<Either<DomainException, DeliveryMethod>> createDeliveryMethod(
    DeliveryMethod method,
  );

  /// Gets all delivery methods for the current user.
  Future<Either<DomainException, List<DeliveryMethod>>> getDeliveryMethods();
}
