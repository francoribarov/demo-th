part of 'game_reviews_bloc.dart';

@freezed

/// Events for [GameReviewsBloc].
abstract class GameReviewsEvent with _$GameReviewsEvent {
  /// Starts loading the game reviews.
  const factory GameReviewsEvent.started({required String gameId}) = _Started;

  /// Updates the active rating filter.
  const factory GameReviewsEvent.filterRatingChanged(int? value) =
      _FilterRatingChanged;
}
