part of 'game_details_bloc.dart';

@freezed
/// State for [GameDetailsBloc].
abstract class GameDetailsState with _$GameDetailsState {
  /// Creates a [GameDetailsState].
  const factory GameDetailsState({
    @Default(false) bool isLoading,
    Game? game,
    @Default([]) List<Game> recommendations,
    @Default(false) bool isWishlisted,
    String? errorMessage,

    // Availability check form
    String? checkStartDate,
    String? checkEndDate,
    bool? availabilityResult,
  }) = _GameDetailsState;
}
