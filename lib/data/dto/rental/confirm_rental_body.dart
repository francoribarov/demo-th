import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_rental_body.freezed.dart';
part 'confirm_rental_body.g.dart';

/// Request body for confirming a rental.
///
/// This DTO (Data Transfer Object) represents the structure sent to the
/// rental API endpoint. It uses JSON serialization for HTTP requests.
///
/// Example JSON:
/// ```json
/// {
///   "publicationId": "123",
///   "startDate": "2026-03-01",
///   "endDate": "2026-03-05",
///   "selectedDelivery": "Delivery",
///   "paymentMethod": "mercadopago",
///   "deliveryAddress": "123 Main St",
///   "foodBundleIds": ["bundle1", "bundle2"]
/// }
/// ```
@freezed
abstract class ConfirmRentalBody with _$ConfirmRentalBody {
  /// Creates a rental confirmation request body.
  const factory ConfirmRentalBody({
    /// ID of the publication being rented.
    required String publicationId,

    /// Start date in ISO 8601 format.
    required String startDate,

    /// End date in ISO 8601 format.
    required String endDate,

    /// Delivery method: 'Delivery' or 'Retiro en persona'.
    @JsonKey(name: 'selectedDelivery') required String selectedDelivery,

    /// Payment method identifier.
    required String paymentMethod,

    /// Delivery address (null if not delivery).
    String? deliveryAddress,

    /// List of food bundle IDs (null if none).
    List<String>? foodBundleIds,
  }) = _ConfirmRentalBody;

  /// Creates a [ConfirmRentalBody] from JSON.
  factory ConfirmRentalBody.fromJson(Map<String, dynamic> json) =>
      _$ConfirmRentalBodyFromJson(json);
}
