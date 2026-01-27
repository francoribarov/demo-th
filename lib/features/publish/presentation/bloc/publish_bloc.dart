import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_publication.dart';
import 'package:mobile_table_hopping/features/publish/domain/validators/publication_validator.dart';

part 'publish_event.dart';
part 'publish_state.dart';
part 'publish_bloc.freezed.dart';

@injectable

/// Coordinates publish flow actions and side effects.
class PublishBloc extends Bloc<PublishEvent, PublishState> {
  /// Creates a publish bloc wired to the create publication use case.
  PublishBloc({
    required CreatePublication createPublication,
    required AuthBloc authBloc,
    required GetGames getGames,
  })  : _createPublication = createPublication,
        _authBloc = authBloc,
        _getGames = getGames,
        super(const PublishState()) {
    on<_Started>(_onStarted);
    on<_NextStep>(_onNextStep);
    on<_PreviousStep>(_onPreviousStep);
    on<_Submit>(_onSubmit);
    on<_PublishAnother>(_onPublishAnother);
    on<_GameIdChanged>(_onGameIdChanged);
    on<_DescriptionChanged>(_onDescriptionChanged);
    on<_PriceChanged>(_onPriceChanged);
    on<_ConditionChanged>(_onConditionChanged);
    on<_ImagesChanged>(_onImagesChanged);
    on<_LoadGames>(_onLoadGames);
    on<_SearchGames>(_onSearchGames);
    on<_DeliveryMethodsChanged>(_onDeliveryMethodsChanged);
  }

  final CreatePublication _createPublication;
  final AuthBloc _authBloc;
  final GetGames _getGames;

  void _onStarted(_Started event, Emitter<PublishState> emit) {
    emit(const PublishState());
    add(const PublishEvent.loadGames());
  }

  void _onNextStep(_NextStep event, Emitter<PublishState> emit) {
    if (state.canProceed) {
      if (state.currentStep == 3) {
        add(const PublishEvent.submit());
      } else {
        emit(state.copyWith(currentStep: state.currentStep + 1));
      }
    }
  }

  void _onPreviousStep(_PreviousStep event, Emitter<PublishState> emit) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void _onPublishAnother(_PublishAnother event, Emitter<PublishState> emit) {
    emit(PublishState(formVersion: state.formVersion + 1));
  }

  Future<void> _onSubmit(_Submit event, Emitter<PublishState> emit) async {
    if (!state.canProceed) return;

    final userId = _authBloc.state.session?.user?.id;
    if (userId == null) {
      emit(state.copyWith(errorMessage: 'Debes iniciar sesión para publicar.'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final draft = PublicationDraft(
        gameId: state.gameId,
        description: state.description,
        price: state.price,
        condition: state.condition,
        images: state.images
            .map(
              (url) => PublicationImage(
                url: url,
                type: 'image',
              ),
            )
            .toList(),
        deliveryMethods: state.deliveryMethods,
      );

      await _createPublication(draft, ownerId: userId);

      emit(
        state.copyWith(
          isSubmitting: false,
          success: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onGameIdChanged(_GameIdChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(gameId: event.value));
  }

  void _onDescriptionChanged(
    _DescriptionChanged event,
    Emitter<PublishState> emit,
  ) {
    emit(state.copyWith(description: event.value));
  }

  void _onPriceChanged(_PriceChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(price: event.value));
  }

  void _onConditionChanged(
    _ConditionChanged event,
    Emitter<PublishState> emit,
  ) {
    emit(state.copyWith(condition: event.value));
  }

  void _onImagesChanged(_ImagesChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(images: event.value));
  }

  void _onDeliveryMethodsChanged(
    _DeliveryMethodsChanged event,
    Emitter<PublishState> emit,
  ) {
    emit(state.copyWith(deliveryMethods: event.value));
  }

  Future<void> _onLoadGames(
    _LoadGames event,
    Emitter<PublishState> emit,
  ) async {
    emit(state.copyWith(isLoadingGames: true));
    try {
      final games = await _getGames();
      emit(
        state.copyWith(
          isLoadingGames: false,
          allGames: games,
          filteredGames: games,
        ),
      );
    } catch (_) {
      // Silently fail or handling error depending on UX requirements
      emit(state.copyWith(isLoadingGames: false));
    }
  }

  void _onSearchGames(_SearchGames event, Emitter<PublishState> emit) {
    final query = event.query.toLowerCase();
    if (query.isEmpty) {
      emit(state.copyWith(filteredGames: state.allGames));
    } else {
      final filtered = state.allGames.where((game) {
        return game.title.toLowerCase().contains(query);
      }).toList();
      emit(state.copyWith(filteredGames: filtered));
    }
  }

  // ... (rest of the file if any)
}
