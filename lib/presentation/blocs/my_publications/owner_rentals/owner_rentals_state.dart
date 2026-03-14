part of 'owner_rentals_bloc.dart';

@freezed
abstract class OwnerRentalsState with _$OwnerRentalsState {
  const factory OwnerRentalsState({
    @Default([]) List<RentalRequest> returnedRentals,
    @Default([]) List<RentalRequest> activeRentals,
    @Default([]) List<RentalRequest> upcomingRentals,
    @Default({}) Map<String, RentalDropOffResponse> dropOffTickets,
    @Default(false) bool isLoading,
    @Default(false) bool isConfirming,
    String? errorMessage,
    String? successMessage,
  }) = _OwnerRentalsState;
}
