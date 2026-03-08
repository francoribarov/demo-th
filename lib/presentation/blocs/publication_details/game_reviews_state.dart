part of 'game_reviews_bloc.dart';

@freezed
/// State for [GameReviewsBloc].
abstract class GameReviewsState with _$GameReviewsState {
  /// Creates a [GameReviewsState].
  const factory GameReviewsState({
    @Default(false) bool isLoading,
    Game? game,
    String? errorMessage,
    int? filterRating,
    @Default([]) List<GameReview> filteredReviews,
  }) = _GameReviewsState;
  const GameReviewsState._();
}
