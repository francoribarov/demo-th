import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_game_by_id_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_publication_by_id_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_recommended_publications_use_case.dart';

part 'publication_details_bloc.freezed.dart';
part 'publication_details_event.dart';
part 'publication_details_state.dart';

@injectable
/// Bloc for loading and presenting publication details.
class PublicationDetailsBloc
    extends Bloc<PublicationDetailsEvent, PublicationDetailsState> {
  /// Creates a [PublicationDetailsBloc].
  PublicationDetailsBloc({
    required GetPublicationByIdUseCase getPublicationById,
    required GetGameByIdUseCase getGameById,
    required GetRecommendedPublicationsUseCase getRecommendedPublications,
  }) : _getPublicationById = getPublicationById,
       _getGameById = getGameById,
       _getRecommendedPublications = getRecommendedPublications,
       super(const PublicationDetailsState()) {
    on<_Started>(_onStarted);
    on<_ToggleWishlist>(_onToggleWishlist);
    on<_CheckStartDateChanged>(_onCheckStartDateChanged);
    on<_CheckEndDateChanged>(_onCheckEndDateChanged);
    on<_CheckDateRangeChanged>(_onCheckDateRangeChanged);
    on<_CheckAvailabilityPressed>(_onCheckAvailabilityPressed);
  }

  final GetPublicationByIdUseCase _getPublicationById;
  final GetGameByIdUseCase _getGameById;
  final GetRecommendedPublicationsUseCase _getRecommendedPublications;

  Future<void> _onStarted(
    _Started event,
    Emitter<PublicationDetailsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final id = event.publicationId;

    final publicationResult = await _getPublicationById(id);
    await publicationResult.fold(
      (error) async {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Error al cargar los detalles: ${error.message}',
          ),
        );
      },
      (publication) async {
        final gameResult = await _getGameById(publication.gameId);
        final game = gameResult.fold((_) => null, (value) => value);

        final recommendedResult = await _getRecommendedPublications(
          publication.gameId,
        );
        final recommendations = recommendedResult.fold(
          (_) => const <PublicationListing>[],
          (v) => v,
        );

        emit(
          state.copyWith(
            isLoading: false,
            publication: publication,
            gameDetail: game,
            recommendations: recommendations,
          ),
        );
      },
    );
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
