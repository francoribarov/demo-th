import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';

part 'game_details_bloc.freezed.dart';

@freezed
/// Events for [GameDetailsBloc].
class GameDetailsEvent with _$GameDetailsEvent {
  /// Starts loading the game details.
  const factory GameDetailsEvent.started({required String gameId}) = _Started;

  /// Toggles the wishlist status.
  const factory GameDetailsEvent.toggleWishlist() = _ToggleWishlist;

  /// Updates the start date in the availability form.
  const factory GameDetailsEvent.checkStartDateChanged(String? value) = _CheckStartDateChanged;

  /// Updates the end date in the availability form.
  const factory GameDetailsEvent.checkEndDateChanged(String? value) = _CheckEndDateChanged;

  /// Triggers the availability check.
  const factory GameDetailsEvent.checkAvailabilityPressed() = _CheckAvailabilityPressed;
}

@freezed
/// State for [GameDetailsBloc].
class GameDetailsState with _$GameDetailsState {
  /// Creates a [GameDetailsState].
  const factory GameDetailsState({
    @Default(false) bool isLoading,
    Game? game,
    @Default([]) List<Game> recommendations,
    @Default(false) bool isWishlisted,
    String? errorMessage,

    // Availability check form
    String? checkStartDate,
    String? checkEndDate,
    bool? availabilityResult,
  }) = _GameDetailsState;
}

@injectable
/// Bloc for loading and presenting game details.
class GameDetailsBloc extends Bloc<GameDetailsEvent, GameDetailsState> {
  /// Creates a [GameDetailsBloc].
  GameDetailsBloc({required GetGames getGames}) : _getGames = getGames, super(const GameDetailsState()) {
    on<_Started>(_onStarted);
    on<_ToggleWishlist>(_onToggleWishlist);
    on<_CheckStartDateChanged>(_onCheckStartDateChanged);
    on<_CheckEndDateChanged>(_onCheckEndDateChanged);
    on<_CheckAvailabilityPressed>(_onCheckAvailabilityPressed);
  }
  final GetGames _getGames;

  Future<void> _onStarted(_Started event, Emitter<GameDetailsState> emit) async {
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

      final recs = await _getGames.getRecommended(id);
      emit(state.copyWith(isLoading: false, game: game, recommendations: recs));
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Error al cargar el juego: $e'));
    }
  }

  void _onToggleWishlist(_ToggleWishlist event, Emitter<GameDetailsState> emit) {
    emit(state.copyWith(isWishlisted: !state.isWishlisted));
  }

  void _onCheckStartDateChanged(_CheckStartDateChanged event, Emitter<GameDetailsState> emit) {
    emit(state.copyWith(checkStartDate: event.value, availabilityResult: null, errorMessage: null));
  }

  void _onCheckEndDateChanged(_CheckEndDateChanged event, Emitter<GameDetailsState> emit) {
    emit(state.copyWith(checkEndDate: event.value, availabilityResult: null, errorMessage: null));
  }

  void _onCheckAvailabilityPressed(_CheckAvailabilityPressed event, Emitter<GameDetailsState> emit) {
    final game = state.game;
    if (game == null) return;
    final startDate = state.checkStartDate;
    final endDate = state.checkEndDate;
    if (startDate == null || endDate == null) return;

    emit(state.copyWith(availabilityResult: game.isAvailableFor(startDate, endDate)));
  }
}
