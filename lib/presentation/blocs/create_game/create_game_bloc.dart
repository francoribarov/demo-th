import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game_draft.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/create_game_use_case.dart';
import 'package:mobile_table_hopping/domain/validators/game/game_validator.dart';
import 'package:mobile_table_hopping/presentation/validators/game_validation_error_mapper.dart';

part 'create_game_bloc.freezed.dart';
part 'create_game_event.dart';
part 'create_game_state.dart';

@injectable
/// BLoC coordinating the create-game wizard flow.
class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  CreateGameBloc({required CreateGameUseCase createGame})
      : _createGame = createGame,
        super(const CreateGameState()) {
    on<_TitleChanged>(_onTitleChanged);
    on<_DescriptionChanged>(_onDescriptionChanged);
    on<_DurationChanged>(_onDurationChanged);
    on<_PlayersChanged>(_onPlayersChanged);
    on<_DifficultyChanged>(_onDifficultyChanged);
    on<_NextStep>(_onNextStep);
    on<_PreviousStep>(_onPreviousStep);
    on<_Submit>(_onSubmit);
  }

  static const int maxStep = 1;

  final CreateGameUseCase _createGame;

  void _onTitleChanged(_TitleChanged event, Emitter<CreateGameState> emit) {
    final titleError = GameValidationErrorMapper.mapTitleError(
      GameValidator.validateTitle(event.value),
    );
    emit(
      state.copyWith(
        title: event.value,
        titleError: titleError,
        isStepValid: _validateStep(
          state.currentStep,
          title: event.value,
          description: state.description,
          duration: state.duration,
          players: state.players,
        ),
      ),
    );
  }

  void _onDescriptionChanged(
    _DescriptionChanged event,
    Emitter<CreateGameState> emit,
  ) {
    final descError = GameValidationErrorMapper.mapDescriptionError(
      GameValidator.validateDescription(event.value),
    );
    emit(
      state.copyWith(
        description: event.value,
        descriptionError: descError,
        isStepValid: _validateStep(
          state.currentStep,
          title: state.title,
          description: event.value,
          duration: state.duration,
          players: state.players,
        ),
      ),
    );
  }

  void _onDurationChanged(
    _DurationChanged event,
    Emitter<CreateGameState> emit,
  ) {
    final durError = GameValidationErrorMapper.mapDurationError(
      GameValidator.validateDuration(event.value),
    );
    emit(
      state.copyWith(
        duration: event.value,
        durationError: durError,
        isStepValid: _validateStep(
          state.currentStep,
          title: state.title,
          description: state.description,
          duration: event.value,
          players: state.players,
        ),
      ),
    );
  }

  void _onPlayersChanged(
    _PlayersChanged event,
    Emitter<CreateGameState> emit,
  ) {
    final playersError = GameValidationErrorMapper.mapPlayersError(
      GameValidator.validatePlayers(event.value),
    );
    emit(
      state.copyWith(
        players: event.value,
        playersError: playersError,
        isStepValid: _validateStep(
          state.currentStep,
          title: state.title,
          description: state.description,
          duration: state.duration,
          players: event.value,
        ),
      ),
    );
  }

  void _onDifficultyChanged(
    _DifficultyChanged event,
    Emitter<CreateGameState> emit,
  ) {
    emit(
      state.copyWith(
        difficulty: event.value,
        isStepValid: _validateStep(
          state.currentStep,
          title: state.title,
          description: state.description,
          duration: state.duration,
          players: state.players,
        ),
      ),
    );
  }

  void _onNextStep(_NextStep event, Emitter<CreateGameState> emit) {
    if (!state.isStepValid || state.currentStep >= maxStep) return;
    final nextStep = state.currentStep + 1;
    emit(
      state.copyWith(
        currentStep: nextStep,
        isStepValid: _validateStep(
          nextStep,
          title: state.title,
          description: state.description,
          duration: state.duration,
          players: state.players,
        ),
      ),
    );
  }

  void _onPreviousStep(_PreviousStep event, Emitter<CreateGameState> emit) {
    if (state.currentStep <= 0) return;
    final prevStep = state.currentStep - 1;
    emit(
      state.copyWith(
        currentStep: prevStep,
        isStepValid: _validateStep(
          prevStep,
          title: state.title,
          description: state.description,
          duration: state.duration,
          players: state.players,
        ),
      ),
    );
  }

  Future<void> _onSubmit(_Submit event, Emitter<CreateGameState> emit) async {
    if (!state.isStepValid) return;

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final draft = GameDraft(
      title: state.title,
      description: state.description,
      duration: state.duration,
      players: state.players,
      difficulty: state.difficulty,
    );

    try {
      final result = await _createGame(draft);
      result.fold(
        (error) => emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: error.message,
          ),
        ),
        (game) => emit(
          state.copyWith(
            isSubmitting: false,
            createdGame: game,
          ),
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Ocurrió un error inesperado al crear el juego.',
        ),
      );
    }
  }

  bool _validateStep(
    int step, {
    required String title,
    required String description,
    required int duration,
    required String players,
  }) {
    switch (step) {
      case 0:
        return GameValidator.validateTitle(title) == null &&
            GameValidator.validateDescription(description) == null;
      case 1:
        return GameValidator.validateDuration(duration) == null &&
            GameValidator.validatePlayers(players) == null &&
            GameValidator.validateTitle(title) == null &&
            GameValidator.validateDescription(description) == null;
      default:
        return false;
    }
  }
}
