part of 'rental_bloc.dart';

@freezed

/// State for the rental confirmation flow.
abstract class RentalState with _$RentalState {
  /// Creates a new rental state instance.
  const factory RentalState({
    @Default(false) bool isLoading,
    PublicationListing? publication,
    String? errorMessage,
    @Default(false) bool success,
    String? startDate,
    String? endDate,
    String? ownerId,
    double? deposit,
    @Default(false) bool isDelivery,
    @Default('') String deliveryAddress,
    @Default('') String deliveryComments,
    @Default('mercadopago') String paymentMethod,
    @Default([]) List<String> selectedFoodBundles,
    @Default(false) bool isSubmitting,
    String? snackbarMessage,
  }) = _RentalState;
  const RentalState._();

  /// Number of days between start and end dates, inclusive.
  int get rentalDays {
    final startStr = startDate;
    final endStr = endDate;
    if (startStr == null || endStr == null) return 1;

    final start = DateTime.tryParse(startStr);
    final end = DateTime.tryParse(endStr);
    if (start == null || end == null) return 1;

    // From Mon to Wed is 3 days (Mon, Tue, Wed). difference() gives 2 days.
    return end.difference(start).inDays + 1;
  }

  /// Subtotal for the rental without fees.
  double get subtotal => (publication?.price ?? 0.0) * rentalDays;

  /// Service fee applied to the subtotal.
  int get serviceFee => (subtotal * 0.1).round();

  /// Delivery fee based on delivery selection.
  int get deliveryFee => isDelivery ? 150 : 0;

  /// Total price for selected food bundles.
  int get foodTotal => selectedFoodBundles.length * 250;

  /// Total price including fees and add-ons.
  double get total => subtotal + serviceFee + deliveryFee + foodTotal;
}
