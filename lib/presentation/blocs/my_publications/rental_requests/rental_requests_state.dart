part of 'rental_requests_bloc.dart';

@freezed
class RentalRequestsState with _$RentalRequestsState {
  const factory RentalRequestsState.initial() = _Initial;
  const factory RentalRequestsState.loading() = _Loading;
  const factory RentalRequestsState.success(
    List<RentalRequest> requests, {
    @Default(null) String? processingRequestId,
    @Default(null) String? feedbackMessage,
  }) = _Success;
  const factory RentalRequestsState.failure(String message) = _Failure;
}
