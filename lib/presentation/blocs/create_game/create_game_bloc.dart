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
///
/// Steps:
/// 0 - Title, description, images
/// 1 - Game characteristics (duration, players, difficulty)
/// 2 - PDF rules (optional)
class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  CreateGameBloc({required CreateGameUseCase createGame})
      : _createGame = createGame,
        super(const CreateGameState()) {
    on<_TitleChanged>(_onTitleChanged);
    on<_DescriptionChanged>(_onDescriptionChanged);
    on<_ImagesChanged>(_onImagesChanged);
    on<_DurationChanged>(_onDurationChanged);
    on<_PlayersChanged>(_onPlayersChanged);
    on<_DifficultyChanged>(_onDifficultyChanged);
    on<_RulesUrlChanged>(_onRulesUrlChanged);
    on<_NextStep>(_onNextStep);
    on<_PreviousStep>(_onPreviousStep);
    on<_GoToStep>(_onGoToStep);
    on<_Submit>(_onSubmit);
  }

  static const int totalSteps = 3;
  static const int maxStep = totalSteps - 1;

  static const stepLabels = ['Información', 'Detalles', 'Reglas'];
  static const stepIcons = [
    0xe3ab, // Icons.edit_outlined (int value for serialization)
    0xe55d, // Icons.tune
    0xe229, // Icons.description_outlined
  ];

  final CreateGameUseCase _createGame;

  // --- Field change handlers ---

  void _onTitleChanged(_TitleChanged event, Emitter<CreateGameState> emit) {
    final titleError = GameValidationErrorMapper.mapTitleError(
      GameValidator.validateTitle(event.value),
    );
    emit(
      state.copyWith(
        title: event.value,
        titleError: titleError,
        isStepValid: _validateStep(state.currentStep, state, title: event.value),
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
          state,
          description: event.value,
        ),
      ),
    );
  }

  void _onImagesChanged(
    _ImagesChanged event,
    Emitter<CreateGameState> emit,
  ) {
    emit(state.copyWith(images: event.value));
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
          state,
          duration: event.value,
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
          state,
          players: event.value,
        ),
      ),
    );
  }

  void _onDifficultyChanged(
    _DifficultyChanged event,
    Emitter<CreateGameState> emit,
  ) {
    emit(state.copyWith(difficulty: event.value));
  }

  void _onRulesUrlChanged(
    _RulesUrlChanged event,
    Emitter<CreateGameState> emit,
  ) {
    emit(state.copyWith(rulesUrl: event.value));
  }

  // --- Navigation ---

  void _onNextStep(_NextStep event, Emitter<CreateGameState> emit) {
    if (!state.isStepValid || state.currentStep >= maxStep) return;
    final nextStep = state.currentStep + 1;
    emit(
      state.copyWith(
        currentStep: nextStep,
        isStepValid: _validateStep(nextStep, state),
      ),
    );
  }

  void _onPreviousStep(_PreviousStep event, Emitter<CreateGameState> emit) {
    if (state.currentStep <= 0) return;
    final prevStep = state.currentStep - 1;
    emit(
      state.copyWith(
        currentStep: prevStep,
        isStepValid: _validateStep(prevStep, state),
      ),
    );
  }

  void _onGoToStep(_GoToStep event, Emitter<CreateGameState> emit) {
    final step = event.step;
    if (step < 0 || step >= totalSteps) return;
    final maxReachable = _maxReachableStep(state);
    if (step > maxReachable) return;
    emit(
      state.copyWith(
        currentStep: step,
        isStepValid: _validateStep(step, state),
      ),
    );
  }

  // --- Submit ---

  Future<void> _onSubmit(_Submit event, Emitter<CreateGameState> emit) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final draft = GameDraft(
      title: state.title,
      description: state.description,
      duration: state.duration,
      players: state.players,
      difficulty: state.difficulty,
      images: event.images,
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

  // --- Validation ---

  int _maxReachableStep(CreateGameState s) {
    for (var i = 0; i < totalSteps - 1; i++) {
      if (!_validateStep(i, s)) return i;
    }
    return totalSteps - 1;
  }

  bool _validateStep(
    int step,
    CreateGameState s, {
    String? title,
    String? description,
    int? duration,
    String? players,
  }) {
    final t = title ?? s.title;
    final d = description ?? s.description;
    final dur = duration ?? s.duration;
    final p = players ?? s.players;

    switch (step) {
      case 0:
        return GameValidator.validateTitle(t) == null &&
            GameValidator.validateDescription(d) == null;
      case 1:
        return GameValidator.validateDuration(dur) == null &&
            GameValidator.validatePlayers(p) == null;
      case 2:
        return true;
      default:
        return false;
    }
  }
}
