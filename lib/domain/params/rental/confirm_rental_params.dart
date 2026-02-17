import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_rental_params.freezed.dart';

/// Input parameters for confirming a rental.
///
/// This class represents the data needed to create a new rental request.
/// It's passed from the presentation layer through the use case to the repository.
///
/// Example:
/// ```dart
/// final params = ConfirmRentalParams(
///   publicationId: '123',
///   startDate: '2026-03-01',
///   endDate: '2026-03-05',
///   isDelivery: true,
///   deliveryAddress: '123 Main St',
///   paymentMethod: 'mercadopago',
///   foodBundleIds: ['bundle1', 'bundle2'],
/// );
/// ```
@freezed
abstract class ConfirmRentalParams with _$ConfirmRentalParams {
  /// Creates rental confirmation parameters.
  const factory ConfirmRentalParams({
    /// ID of the publication being rented.
    required String publicationId,

    /// Start date of the rental in ISO 8601 format.
    required String startDate,

    /// End date of the rental in ISO 8601 format.
    required String endDate,

    /// Whether the rental includes delivery service.
    @Default(false) bool isDelivery,

    /// Delivery address (required if isDelivery is true).
    @Default('') String deliveryAddress,

    /// Optional delivery instructions or comments.
    @Default('') String deliveryComments,

    /// Payment method identifier (e.g., 'mercadopago', 'cash').
    @Default('mercadopago') String paymentMethod,

    /// IDs of additional food bundles to include with the rental.
    @Default([]) List<String> foodBundleIds,
  }) = _ConfirmRentalParams;
}
