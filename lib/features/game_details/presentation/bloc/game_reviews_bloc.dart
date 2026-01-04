import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';

part 'game_reviews_bloc.freezed.dart';

@freezed
/// Events for [GameReviewsBloc].
abstract class GameReviewsEvent with _$GameReviewsEvent {
  /// Starts loading the game reviews.
  const factory GameReviewsEvent.started({required String gameId}) = _Started;

  /// Updates the active rating filter.
  const factory GameReviewsEvent.filterRatingChanged(int? value) = _FilterRatingChanged;
}

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
    if (rating == null) return game.reviewsList;
    return game.reviewsList.where((r) => r.rating.floor() == rating).toList();
  }
}

@injectable
/// Bloc for loading and presenting game reviews.
class GameReviewsBloc extends Bloc<GameReviewsEvent, GameReviewsState> {
  /// Creates a [GameReviewsBloc].
  GameReviewsBloc({required GetGames getGames}) : _getGames = getGames, super(const GameReviewsState()) {
    on<_Started>(_onStarted);
    on<_FilterRatingChanged>(_onFilterRatingChanged);
  }
  final GetGames _getGames;

  Future<void> _onStarted(_Started event, Emitter<GameReviewsState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final id = int.tryParse(event.gameId);
    if (id == null) {
      emit(state.copyWith(isLoading: false, errorMessage: 'ID inválido'));
      return;
    }

    try {
      final game = await _getGames.getById(id);
      if (game == null) {
        emit(state.copyWith(isLoading: false, errorMessage: 'Juego no encontrado'));
        return;
      }
      emit(state.copyWith(isLoading: false, game: game));
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Error al cargar reseñas: $e'));
    }
  }

  void _onFilterRatingChanged(_FilterRatingChanged event, Emitter<GameReviewsState> emit) {
    emit(state.copyWith(filterRating: event.value));
  }
}
