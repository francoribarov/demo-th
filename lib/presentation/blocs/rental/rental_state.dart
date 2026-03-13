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
    String? snackbarMessage,
    @Default(1) int rentalDays,
    @Default(0.0) double subtotal,
    @Default(0) int serviceFee,
    @Default(0) int deliveryFee,
    @Default(0) int foodTotal,
    @Default(0.0) double total,
  }) = _RentalState;
  const RentalState._();
}
