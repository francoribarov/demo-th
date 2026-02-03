import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';

/// Repository for delivery method operations.
abstract class DeliveryMethodRepository {
  /// Creates a new delivery method.
  Future<DeliveryMethod> createDeliveryMethod(DeliveryMethod method);

  /// Gets all delivery methods for the current user.
  Future<List<DeliveryMethod>> getDeliveryMethods();
}
