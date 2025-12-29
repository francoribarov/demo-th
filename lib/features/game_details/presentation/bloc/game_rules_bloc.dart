import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';

part 'game_rules_bloc.freezed.dart';

@freezed
/// Events for [GameRulesBloc].
class GameRulesEvent with _$GameRulesEvent {
  /// Starts loading the game rules.
  const factory GameRulesEvent.started({required String gameId}) = _Started;
}

@freezed
/// State for [GameRulesBloc].
class GameRulesState with _$GameRulesState {
  /// Creates a [GameRulesState].
  const factory GameRulesState({@Default(false) bool isLoading, Game? game, String? errorMessage}) = _GameRulesState;
}

@injectable
/// Bloc for loading and presenting game rules.
class GameRulesBloc extends Bloc<GameRulesEvent, GameRulesState> {
  /// Creates a [GameRulesBloc].
  GameRulesBloc({required GetGames getGames}) : _getGames = getGames, super(const GameRulesState()) {
    on<_Started>(_onStarted);
  }
  final GetGames _getGames;

  Future<void> _onStarted(_Started event, Emitter<GameRulesState> emit) async {
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
      emit(state.copyWith(isLoading: false, errorMessage: 'Error al cargar reglas: $e'));
    }
  }
}
