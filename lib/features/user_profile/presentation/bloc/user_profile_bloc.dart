import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';

part 'user_profile_bloc.freezed.dart';

@freezed
/// Events for loading user profile data.
class UserProfileEvent with _$UserProfileEvent {
  /// Starts loading a profile based on the selected game id.
  const factory UserProfileEvent.started({required String gameId}) = _Started;
}

@freezed
/// State for the user profile screen.
class UserProfileState with _$UserProfileState {
  /// Creates the user profile state.
  const factory UserProfileState({@Default(false) bool isLoading, Game? game, String? errorMessage}) =
      _UserProfileState;
}

@injectable
/// BLoC that loads game data to drive the user profile screen.
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  /// Creates a [UserProfileBloc].
  UserProfileBloc({required GetGames getGames}) : _getGames = getGames, super(const UserProfileState()) {
    on<_Started>(_onStarted);
  }

  final GetGames _getGames;

  Future<void> _onStarted(_Started event, Emitter<UserProfileState> emit) async {
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
      emit(state.copyWith(isLoading: false, errorMessage: 'Error al cargar perfil: $e'));
    }
  }
}
