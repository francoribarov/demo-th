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
  }) = _GameReviewsState;
  const GameReviewsState._();

  /// Reviews filtered by the current rating filter.
  List<GameReview> get filteredReviews {
    final game = this.game;
    if (game == null) return const [];
    final rating = filterRating;
    if (rating == null) return game.reviews;
    return game.reviews.where((r) => r.rating.floor() == rating).toList();
  }
}
