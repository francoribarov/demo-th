part of 'publication_details_bloc.dart';

@freezed

/// State for [PublicationDetailsBloc].
abstract class PublicationDetailsState with _$PublicationDetailsState {
  /// Creates a [PublicationDetailsState].
  const factory PublicationDetailsState({
    @Default(false) bool isLoading,
    PublicationListing? publication,
    Game? gameDetail,
    @Default([]) List<PublicationListing> recommendations,
    @Default(false) bool isWishlisted,
    String? errorMessage,

    // Availability check form
    @Default('') String checkStartDate,
    @Default('') String checkEndDate,
    bool? availabilityResult,
  }) = _PublicationDetailsState;
}
