import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_game_by_id_use_case.dart';

part 'game_reviews_bloc.freezed.dart';
part 'game_reviews_event.dart';
part 'game_reviews_state.dart';

@injectable

/// Bloc for loading and presenting game reviews.
class GameReviewsBloc extends Bloc<GameReviewsEvent, GameReviewsState> {
  /// Creates a [GameReviewsBloc].
  GameReviewsBloc({required GetGameByIdUseCase getGameById})
      : _getGameById = getGameById,
        super(const GameReviewsState()) {
    on<_Started>(_onStarted);
    on<_FilterRatingChanged>(_onFilterRatingChanged);
  }
  final GetGameByIdUseCase _getGameById;

  Future<void> _onStarted(
    _Started event,
    Emitter<GameReviewsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getGameById(event.gameId);
    result.fold(
      (error) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar reseñas: ${error.message}',
        ),
      ),
      (game) => emit(
        state.copyWith(
          isLoading: false,
          game: game,
          filteredReviews: _filterReviews(game, state.filterRating),
        ),
      ),
    );
  }

  void _onFilterRatingChanged(
    _FilterRatingChanged event,
    Emitter<GameReviewsState> emit,
  ) {
    emit(
      state.copyWith(
        filterRating: event.value,
        filteredReviews: _filterReviews(state.game, event.value),
      ),
    );
  }

  List<GameReview> _filterReviews(Game? game, int? rating) {
    if (game == null) return const [];
    if (rating == null) return game.reviews;
    return game.reviews.where((r) => r.rating.floor() == rating).toList();
  }
}
