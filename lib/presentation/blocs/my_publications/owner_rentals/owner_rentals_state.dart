import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';

part 'owner_rentals_state.freezed.dart';

@freezed
abstract class OwnerRentalsState with _$OwnerRentalsState {
  const factory OwnerRentalsState({
    @Default([]) List<RentalRequest> activeRentals,
    @Default([]) List<RentalRequest> upcomingRentals,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _OwnerRentalsState;
}
