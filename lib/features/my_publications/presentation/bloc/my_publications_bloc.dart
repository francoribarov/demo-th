import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/usecases/get_my_games_usecase.dart';

part 'my_publications_event.dart';
part 'my_publications_state.dart';
part 'my_publications_bloc.freezed.dart';

@injectable
class MyPublicationsBloc
    extends Bloc<MyPublicationsEvent, MyPublicationsState> {
  MyPublicationsBloc(this._getMyGames) : super(const _Initial()) {
    on<_Started>(_onStarted);
  }

  final GetMyGamesUseCase _getMyGames;

  Future<void> _onStarted(
    _Started event,
    Emitter<MyPublicationsState> emit,
  ) async {
    emit(const MyPublicationsState.loading());
    try {
      final games = await _getMyGames();
      emit(MyPublicationsState.success(games));
    } on Object catch (e) {
      emit(MyPublicationsState.failure(e.toString()));
    }
  }
}
