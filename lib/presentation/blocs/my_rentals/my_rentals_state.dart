part of 'my_rentals_bloc.dart';

@freezed
class MyRentalsState with _$MyRentalsState {
  const factory MyRentalsState.initial() = _Initial;
  const factory MyRentalsState.loading() = _Loading;
  const factory MyRentalsState.success(
    List<RentalRequest> rentals, {
    String? processingRentalId,
    String? feedbackMessage,
  }) = _Success;
  const factory MyRentalsState.failure(String message) = _Failure;
}
