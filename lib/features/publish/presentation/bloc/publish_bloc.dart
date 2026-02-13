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

part 'publish_bloc.freezed.dart';
part 'publish_event.dart';
part 'publish_state.dart';

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
    on<_LoadGames>(_onLoadGames);
    on<_SearchGames>(_onSearchGames);
  }

  final CreatePublication _createPublication;
  final AuthBloc _authBloc;
  final GetGames _getGames;

  void _onStarted(_Started event, Emitter<PublishState> emit) {
    emit(const PublishState());
    add(const PublishEvent.loadGames());
  }

  void _onNextStep(_NextStep event, Emitter<PublishState> emit) {
    if (state.isStepValid) {
      if (state.currentStep == 3) {
        add(const PublishEvent.submit());
      } else {
        final nextStep = state.currentStep + 1;
        emit(
          state.copyWith(
            currentStep: nextStep,
            isStepValid: _validateStep(
              nextStep,
              state.gameId,
              state.description,
              state.condition,
              state.price,
            ),
          ),
        );
      }
    }
  }

  void _onPreviousStep(_PreviousStep event, Emitter<PublishState> emit) {
    if (state.currentStep > 0) {
      final prevStep = state.currentStep - 1;
      emit(
        state.copyWith(
          currentStep: prevStep,
          isStepValid: _validateStep(
            prevStep,
            state.gameId,
            state.description,
            state.condition,
            state.price,
          ),
        ),
      );
    }
  }

  void _onPublishAnother(_PublishAnother event, Emitter<PublishState> emit) {
    emit(PublishState(formVersion: state.formVersion + 1));
  }

  /// Submits the publication. Images and delivery methods are passed in.
  Future<void> _onSubmit(_Submit event, Emitter<PublishState> emit) async {
    if (!state.isStepValid) return;

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
        condition: state.condition!,
        images: event.images
            .map(
              (url) => PublicationImage(
                url: url,
                type: 'image',
              ),
            )
            .toList(),
        deliveryMethods: event.deliveryMethods,
      );

      await _createPublication(draft, ownerId: userId);

      emit(
        state.copyWith(
          isSubmitting: false,
          success: true,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onGameIdChanged(_GameIdChanged event, Emitter<PublishState> emit) {
    emit(
      state.copyWith(
        gameId: event.value,
        condition: null,
        isStepValid: _validateStep(
          state.currentStep,
          event.value,
          state.description,
          null,
          state.price,
        ),
      ),
    );
  }

  void _onDescriptionChanged(
    _DescriptionChanged event,
    Emitter<PublishState> emit,
  ) {
    emit(
      state.copyWith(
        description: event.value,
        isStepValid: _validateStep(
          state.currentStep,
          state.gameId,
          event.value,
          state.condition,
          state.price,
        ),
      ),
    );
  }

  void _onPriceChanged(_PriceChanged event, Emitter<PublishState> emit) {
    emit(
      state.copyWith(
        price: event.value,
        isStepValid: _validateStep(
          state.currentStep,
          state.gameId,
          state.description,
          state.condition,
          event.value,
        ),
      ),
    );
  }

  void _onConditionChanged(
    _ConditionChanged event,
    Emitter<PublishState> emit,
  ) {
    emit(
      state.copyWith(
        condition: event.value,
        isStepValid: _validateStep(
          state.currentStep,
          state.gameId,
          state.description,
          event.value,
          state.price,
        ),
      ),
    );
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
    } on Object catch (_) {
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

  bool _validateStep(
    int step,
    String gameId,
    String description,
    PublicationCondition? condition,
    int price,
  ) {
    switch (step) {
      case 0: // Data step: game and description and condition
        return gameId.isNotEmpty &&
            PublicationValidator.validateDescription(description).isValid &&
            condition != null;
      case 1: // Photos step: no validation required (optional)
        return true;
      case 2: // Price step: price must be valid
        return PublicationValidator.validatePricing(price).isValid;
      case 3: // Review step: ready to submit
        return gameId.isNotEmpty &&
            PublicationValidator.validateDescription(description).isValid &&
            PublicationValidator.validatePricing(price).isValid &&
            condition != null;
      default:
        return false;
    }
  }
}
