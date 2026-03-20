import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_games_use_case.dart';

part 'game_search_cubit.freezed.dart';

@freezed
/// State for the game search widget.
abstract class GameSearchState with _$GameSearchState {
  /// Creates a game search state.
  const factory GameSearchState({
    @Default([]) List<Game> allGames,
    @Default([]) List<Game> filteredGames,
    @Default(false) bool isLoading,
  }) = _GameSearchState;
}

@injectable
/// Cubit for loading and filtering the game catalog.
class GameSearchCubit extends Cubit<GameSearchState> {
  /// Creates a [GameSearchCubit] with the given use case.
  GameSearchCubit({required GetGamesUseCase getGames})
    : _getGames = getGames,
      super(const GameSearchState());

  final GetGamesUseCase _getGames;

  /// Loads all games from the catalog.
  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getGames();
    result.fold(
      (_) => emit(state.copyWith(isLoading: false)),
      (games) => emit(
        state.copyWith(
          isLoading: false,
          allGames: games,
          filteredGames: games,
        ),
      ),
    );
  }

  /// Filters games by [query]. Empty query restores the full list.
  void search(String query) {
    final q = query.toLowerCase();
    if (q.isEmpty) {
      emit(state.copyWith(filteredGames: state.allGames));
    } else {
      emit(
        state.copyWith(
          filteredGames: state.allGames
              .where((g) => g.title.toLowerCase().contains(q))
              .toList(),
        ),
      );
    }
  }
}
