part of 'publication_details_bloc.dart';

@freezed

/// Events for [PublicationDetailsBloc].
abstract class PublicationDetailsEvent with _$PublicationDetailsEvent {
  /// Starts loading the publication details.
  const factory PublicationDetailsEvent.started({
    required String publicationId,
  }) = _Started;

  /// Toggles the wishlist status.
  const factory PublicationDetailsEvent.toggleWishlist() = _ToggleWishlist;

  /// Updates the start date in the availability form.
  const factory PublicationDetailsEvent.checkStartDateChanged(String value) =
      _CheckStartDateChanged;

  /// Updates the end date in the availability form.
  const factory PublicationDetailsEvent.checkEndDateChanged(String value) =
      _CheckEndDateChanged;

  /// Updates both dates in the availability form.
  const factory PublicationDetailsEvent.checkDateRangeChanged(
    String start,
    String end,
  ) = _CheckDateRangeChanged;

  /// Triggers the availability check.
  const factory PublicationDetailsEvent.checkAvailabilityPressed() =
      _CheckAvailabilityPressed;
}
