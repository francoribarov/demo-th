import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_publications.dart';

part 'publication_details_bloc.freezed.dart';
part 'publication_details_event.dart';
part 'publication_details_state.dart';

@injectable

/// Bloc for loading and presenting publication details.
class PublicationDetailsBloc
    extends Bloc<PublicationDetailsEvent, PublicationDetailsState> {
  /// Creates a [PublicationDetailsBloc].
  PublicationDetailsBloc({
    required GetPublications getPublications,
    required GetGames getGames,
  })  : _getPublications = getPublications,
        _getGames = getGames,
        super(const PublicationDetailsState()) {
    on<_Started>(_onStarted);
    on<_ToggleWishlist>(_onToggleWishlist);
    on<_CheckStartDateChanged>(_onCheckStartDateChanged);
    on<_CheckEndDateChanged>(_onCheckEndDateChanged);
    on<_CheckDateRangeChanged>(_onCheckDateRangeChanged);
    on<_CheckAvailabilityPressed>(_onCheckAvailabilityPressed);
  }

  final GetPublications _getPublications;
  final GetGames _getGames;

  Future<void> _onStarted(
    _Started event,
    Emitter<PublicationDetailsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final id = event.publicationId;

    try {
      final publication = await _getPublications.getById(id);

      if (publication == null) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Publicación no encontrada',
          ),
        );
        return;
      }

      // Fetch game details using gameId from publication
      final game = await _getGames.getById(
        publication.gameId,
      );

      // Load recommendations based on game categories
      final recs = await _getPublications.getRecommended(
        publication.gameId,
      );

      emit(
        state.copyWith(
          isLoading: false,
          publication: publication,
          gameDetail: game,
          recommendations: recs,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar los detalles: $e',
        ),
      );
    }
  }

  void _onToggleWishlist(
    _ToggleWishlist event,
    Emitter<PublicationDetailsState> emit,
  ) {
    emit(state.copyWith(isWishlisted: !state.isWishlisted));
  }

  void _onCheckStartDateChanged(
    _CheckStartDateChanged event,
    Emitter<PublicationDetailsState> emit,
  ) {
    emit(
      state.copyWith(
        checkStartDate: event.value,
        availabilityResult: null,
        errorMessage: null,
      ),
    );
  }

  void _onCheckEndDateChanged(
    _CheckEndDateChanged event,
    Emitter<PublicationDetailsState> emit,
  ) {
    emit(
      state.copyWith(
        checkEndDate: event.value,
        availabilityResult: null,
        errorMessage: null,
      ),
    );
  }

  void _onCheckDateRangeChanged(
    _CheckDateRangeChanged event,
    Emitter<PublicationDetailsState> emit,
  ) {
    emit(
      state.copyWith(
        checkStartDate: event.start,
        checkEndDate: event.end,
        availabilityResult: null,
        errorMessage: null,
      ),
    );
  }

  void _onCheckAvailabilityPressed(
    _CheckAvailabilityPressed event,
    Emitter<PublicationDetailsState> emit,
  ) {
    final publication = state.publication;
    if (publication == null) return;
    final startDate = state.checkStartDate;
    final endDate = state.checkEndDate;
    if (startDate.isEmpty || endDate.isEmpty) return;

    emit(
      state.copyWith(
        availabilityResult: publication.isAvailableFor(startDate, endDate),
      ),
    );
  }
}
