part of 'game_details_bloc.dart';

@freezed
/// Events for [GameDetailsBloc].
abstract class GameDetailsEvent with _$GameDetailsEvent {
  /// Starts loading the game details.
  const factory GameDetailsEvent.started({required String gameId}) = _Started;

  /// Toggles the wishlist status.
  const factory GameDetailsEvent.toggleWishlist() = _ToggleWishlist;

  /// Updates the start date in the availability form.
  const factory GameDetailsEvent.checkStartDateChanged(String? value) =
      _CheckStartDateChanged;

  /// Updates the end date in the availability form.
  const factory GameDetailsEvent.checkEndDateChanged(String? value) =
      _CheckEndDateChanged;

  /// Updates both dates in the availability form.
  const factory GameDetailsEvent.checkDateRangeChanged(
    String? start,
    String? end,
  ) = _CheckDateRangeChanged;

  /// Triggers the availability check.
  const factory GameDetailsEvent.checkAvailabilityPressed() =
      _CheckAvailabilityPressed;
}
