import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/get_delivery_methods.dart';

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
    required CreateDeliveryMethod createDeliveryMethod,
    required GetDeliveryMethods getDeliveryMethods,
  })  : _createDeliveryMethod = createDeliveryMethod,
        _getDeliveryMethods = getDeliveryMethods,
        super(const DeliveryMethodState()) {
    on<_Started>(_onStarted);
    on<_MethodToggled>(_onMethodToggled);
    on<_MethodCreated>(_onMethodCreated);
    on<_Reset>(_onReset);
  }

  final CreateDeliveryMethod _createDeliveryMethod;
  final GetDeliveryMethods _getDeliveryMethods;

  Future<void> _onStarted(
    _Started event,
    Emitter<DeliveryMethodState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final methods = await _getDeliveryMethods();
      emit(
        state.copyWith(
          isLoading: false,
          availableMethods: methods,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar métodos de entrega: $e',
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
      final newMethod = await _createDeliveryMethod(event.method);
      emit(
        state.copyWith(
          isCreating: false,
          availableMethods: [...state.availableMethods, newMethod],
          selectedMethods: [...state.selectedMethods, newMethod],
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          isCreating: false,
          errorMessage: 'Error al crear método de entrega: $e',
        ),
      );
    }
  }

  void _onReset(_Reset event, Emitter<DeliveryMethodState> emit) {
    emit(const DeliveryMethodState());
  }
}
