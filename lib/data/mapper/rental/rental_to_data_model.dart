import 'package:mobile_table_hopping/data/dto/rental/confirm_rental_body.dart';
import 'package:mobile_table_hopping/domain/params/rental/confirm_rental_params.dart';

/// Extension for mapping rental domain models to data models.
///
/// Provides conversion methods from domain layer types (params) to data
/// layer types (DTOs) used in API requests.
extension RentalToDataModel on ConfirmRentalParams {
  /// Converts [ConfirmRentalParams] to [ConfirmRentalBody] for API requests.
  ///
  /// Transformation logic:
  /// - Converts `isDelivery` boolean to `selectedDelivery` string
  /// - Makes `deliveryAddress` null if not using delivery
  /// - Makes `foodBundleIds` null if empty
  ///
  /// Example:
  /// ```dart
  /// final params = ConfirmRentalParams(...);
  /// final body = params.toBody();
  /// await _service.createRental(body);
  /// ```
  ConfirmRentalBody toBody() {
    return ConfirmRentalBody(
      publicationId: publicationId,
      startDate: startDate,
      endDate: endDate,
      selectedDelivery: isDelivery ? 'Delivery' : 'Retiro en persona',
      paymentMethod: paymentMethod,
      deliveryAddress:
          isDelivery && deliveryAddress.isNotEmpty ? deliveryAddress : null,
      foodBundleIds: foodBundleIds.isEmpty ? null : foodBundleIds,
    );
  }
}
