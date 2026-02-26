import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/domain/usecase/publish/create_delivery_method_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/publish/get_delivery_methods_use_case.dart';

part 'delivery_method_bloc.freezed.dart';

/// Events for [DeliveryMethodBloc].
@freezed
abstract class DeliveryMethodEvent with _$DeliveryMethodEvent {
  /// Load available delivery methods.
  const factory DeliveryMethodEvent.started() = _Started;

  /// Toggle selection of a delivery method.
  const factory DeliveryMethodEvent.methodToggled(DeliveryMethod method) =
      _MethodToggled;

  /// Create a new delivery method.
  const factory DeliveryMethodEvent.methodCreated(DeliveryMethod method) =
      _MethodCreated;

  /// Reset state (for new publish flow).
  const factory DeliveryMethodEvent.reset() = _Reset;
}

/// State for [DeliveryMethodBloc].
@freezed
abstract class DeliveryMethodState with _$DeliveryMethodState {
  const factory DeliveryMethodState({
    @Default([]) List<DeliveryMethod> availableMethods,
    @Default([]) List<DeliveryMethod> selectedMethods,
    @Default(false) bool isLoading,
    @Default(false) bool isCreating,
    String? errorMessage,
  }) = _DeliveryMethodState;
}

@injectable

/// Bloc for managing delivery methods.
class DeliveryMethodBloc
    extends Bloc<DeliveryMethodEvent, DeliveryMethodState> {
  /// Creates a [DeliveryMethodBloc].
  DeliveryMethodBloc({
    required CreateDeliveryMethodUseCase createDeliveryMethod,
    required GetDeliveryMethodsUseCase getDeliveryMethods,
  })  : _createDeliveryMethod = createDeliveryMethod,
        _getDeliveryMethods = getDeliveryMethods,
        super(const DeliveryMethodState()) {
    on<_Started>(_onStarted);
    on<_MethodToggled>(_onMethodToggled);
    on<_MethodCreated>(_onMethodCreated);
    on<_Reset>(_onReset);
  }

  final CreateDeliveryMethodUseCase _createDeliveryMethod;
  final GetDeliveryMethodsUseCase _getDeliveryMethods;

  Future<void> _onStarted(
    _Started event,
    Emitter<DeliveryMethodState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final result = await _getDeliveryMethods();

      result.fold(
        (error) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage:
                'Error al cargar metodos de entrega: ${error.message}',
          ),
        ),
        (methods) => emit(
          state.copyWith(
            isLoading: false,
            availableMethods: methods,
          ),
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error inesperado al cargar metodos de entrega.',
        ),
      );
    }
  }

  void _onMethodToggled(
    _MethodToggled event,
    Emitter<DeliveryMethodState> emit,
  ) {
    final exists = state.selectedMethods
        .any((m) => m.id == event.method.id && m.id != null);

    List<DeliveryMethod> updated;
    if (exists) {
      updated =
          state.selectedMethods.where((m) => m.id != event.method.id).toList();
    } else {
      updated = [...state.selectedMethods, event.method];
    }
    emit(state.copyWith(selectedMethods: updated));
  }

  Future<void> _onMethodCreated(
    _MethodCreated event,
    Emitter<DeliveryMethodState> emit,
  ) async {
    emit(state.copyWith(isCreating: true, errorMessage: null));

    try {
      final result = await _createDeliveryMethod(event.method);

      result.fold(
        (error) => emit(
          state.copyWith(
            isCreating: false,
            errorMessage: 'Error al crear metodo de entrega: ${error.message}',
          ),
        ),
        (newMethod) => emit(
          state.copyWith(
            isCreating: false,
            availableMethods: [...state.availableMethods, newMethod],
            selectedMethods: [...state.selectedMethods, newMethod],
          ),
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          isCreating: false,
          errorMessage: 'Error inesperado al crear metodo de entrega.',
        ),
      );
    }
  }

  void _onReset(_Reset event, Emitter<DeliveryMethodState> emit) {
    emit(const DeliveryMethodState());
  }
}
