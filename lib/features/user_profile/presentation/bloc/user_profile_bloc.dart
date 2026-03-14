import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_game_by_id_use_case.dart';

part 'user_profile_bloc.freezed.dart';
part 'user_profile_event.dart';
part 'user_profile_state.dart';

@injectable
/// BLoC that loads game data to drive the user profile screen.
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  /// Creates a [UserProfileBloc].
  UserProfileBloc({required GetGameByIdUseCase getGameById})
    : _getGameById = getGameById,
      super(const UserProfileState()) {
    on<_Started>(_onStarted);
  }

  final GetGameByIdUseCase _getGameById;

  Future<void> _onStarted(
    _Started event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getGameById(event.gameId);
    result.fold(
      (error) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar perfil: ${error.message}',
        ),
      ),
      (game) => emit(state.copyWith(isLoading: false, game: game)),
    );
  }
}
