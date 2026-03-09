import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_games_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/publish/create_publication_use_case.dart';
import 'package:mobile_table_hopping/domain/validators/publication/publication_validator.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/validators/publication_validation_error_mapper.dart';

part 'publish_bloc.freezed.dart';
part 'publish_event.dart';
part 'publish_state.dart';

@injectable
/// Coordinates publish flow actions and side effects.
class PublishBloc extends Bloc<PublishEvent, PublishState> {
  /// Creates a publish bloc wired to the create publication use case.
  PublishBloc({
    required CreatePublicationUseCase createPublication,
    required AuthBloc authBloc,
    required GetGamesUseCase getGames,
  }) : _createPublication = createPublication,
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

  final CreatePublicationUseCase _createPublication;
  final AuthBloc _authBloc;
  final GetGamesUseCase _getGames;

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

    try {
      final result = await _createPublication(draft, ownerId: userId);

      result.fold(
        (error) => emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: error.message,
          ),
        ),
        (_) => emit(
          state.copyWith(
            isSubmitting: false,
            success: true,
          ),
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Ocurrio un error inesperado al publicar.',
        ),
      );
    }
  }

  void _onGameIdChanged(_GameIdChanged event, Emitter<PublishState> emit) {
    emit(
      state.copyWith(
        gameId: event.value,
        filteredGames: state.allGames,
        conditionError: PublicationValidationErrorMapper.mapConditionError(
          PublicationValidator.validateCondition(state.condition),
        ),
        isStepValid: _validateStep(
          state.currentStep,
          event.value,
          state.description,
          state.condition,
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
        descriptionError: PublicationValidationErrorMapper.mapDescriptionError(
          PublicationValidator.validateDescription(event.value),
        ),
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
        priceError: PublicationValidationErrorMapper.mapPriceError(
          PublicationValidator.validatePricing(event.value),
        ),
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
        conditionError: PublicationValidationErrorMapper.mapConditionError(
          PublicationValidator.validateCondition(event.value),
        ),
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
    final result = await _getGames();
    result.fold(
      (_) => emit(state.copyWith(isLoadingGames: false)),
      (games) => emit(
        state.copyWith(
          isLoadingGames: false,
          allGames: games,
          filteredGames: games,
        ),
      ),
    );
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
            PublicationValidator.validateDescription(description) == null &&
            PublicationValidator.validateCondition(condition) == null;
      case 1: // Photos step: no validation required (optional)
        return true;
      case 2: // Price step: price must be valid
        return PublicationValidator.validatePricing(price) == null;
      case 3: // Review step: ready to submit
        return gameId.isNotEmpty &&
            PublicationValidator.validateDescription(description) == null &&
            PublicationValidator.validatePricing(price) == null &&
            PublicationValidator.validateCondition(condition) == null;
      default:
        return false;
    }
  }
}
