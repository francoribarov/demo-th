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
    @Default('cash') String paymentMethod,
    @Default([]) List<String> selectedFoodBundles,
    @Default(false) bool isSubmitting,
    FeedbackNotice? feedbackNotice,
  }) = _RentalState;

  const RentalState._();

  /// Computed pricing totals derived from current state.
  RentalPricingTotals get pricing => RentalPricingCalculator.calculate(
    pricePerDay: publication?.price ?? 0,
    startDate: startDate,
    endDate: endDate,
    isDelivery: isDelivery,
    foodBundlesCount: selectedFoodBundles.length,
  );

  int get rentalDays => pricing.rentalDays;
  double get subtotal => pricing.subtotal;
  int get serviceFee => pricing.serviceFee;
  int get deliveryFee => pricing.deliveryFee;
  int get foodTotal => pricing.foodTotal;
  double get total => pricing.total;
}
