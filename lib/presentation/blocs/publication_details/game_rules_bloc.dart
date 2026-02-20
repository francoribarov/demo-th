import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_game_by_id_use_case.dart';

part 'game_rules_bloc.freezed.dart';
part 'game_rules_event.dart';
part 'game_rules_state.dart';

@injectable

/// Bloc for loading and presenting game rules.
class GameRulesBloc extends Bloc<GameRulesEvent, GameRulesState> {
  /// Creates a [GameRulesBloc].
  GameRulesBloc({required GetGameByIdUseCase getGameById})
      : _getGameById = getGameById,
        super(const GameRulesState()) {
    on<_Started>(_onStarted);
  }
  final GetGameByIdUseCase _getGameById;

  Future<void> _onStarted(_Started event, Emitter<GameRulesState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getGameById(event.gameId);
    result.fold(
      (error) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar reglas: ${error.message}',
        ),
      ),
      (game) => emit(state.copyWith(isLoading: false, game: game)),
    );
  }
}
