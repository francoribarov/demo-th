import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';
import 'package:mobile_table_hopping/features/rental/domain/entities/rental_draft.dart';
import 'package:mobile_table_hopping/features/rental/domain/usecases/confirm_rental.dart';

part 'rental_bloc.freezed.dart';

@freezed
/// Events for creating and submitting a rental draft.
abstract class RentalEvent with _$RentalEvent {
  /// Loads the game and initializes dates for the rental flow.
  const factory RentalEvent.started({
    required String gameId,
    String? startDate,
    String? endDate,
    String? ownerId,
    int? deposit,
  }) = _Started;

  /// Updates the rental start date.
  const factory RentalEvent.startDateChanged(String? value) = _StartDateChanged;

  /// Updates the rental end date.
  const factory RentalEvent.endDateChanged(String? value) = _EndDateChanged;

  /// Updates both dates at once.
  const factory RentalEvent.dateRangeChanged(String? start, String? end) = _DateRangeChanged;

  /// Toggles delivery for the current rental draft.
  const factory RentalEvent.deliveryChanged({required bool isDelivery}) =
      _DeliveryChanged;

  /// Updates the delivery address.
  const factory RentalEvent.deliveryAddressChanged(String value) =
      _DeliveryAddressChanged;

  /// Updates delivery comments/notes.
  const factory RentalEvent.deliveryCommentsChanged(String value) =
      _DeliveryCommentsChanged;

  /// Updates the selected payment method.
  const factory RentalEvent.paymentMethodChanged(String value) =
      _PaymentMethodChanged;

  /// Updates the selected food bundle identifiers.
  const factory RentalEvent.foodBundlesChanged(List<String> value) =
      _FoodBundlesChanged;

  /// Submits the current rental draft.
  const factory RentalEvent.submitted() = _Submitted;

  /// Clears the last snackbar message after it is shown.
  const factory RentalEvent.messageShown() = _MessageShown;

  /// Resets the flow to publish another rental.
  const factory RentalEvent.publishAnother() = _PublishAnother;
}

@freezed
/// State for the rental confirmation flow.
abstract class RentalState with _$RentalState {
  /// Creates a new rental state instance.
  const factory RentalState({
    @Default(false) bool isLoading,
    Game? game,
    String? errorMessage,
    @Default(false) bool success,

    String? startDate,
    String? endDate,
    String? ownerId,
    int? deposit,
    @Default(false) bool isDelivery,
    @Default('') String deliveryAddress,
    @Default('') String deliveryComments,
    @Default('mercadopago') String paymentMethod,
    @Default([]) List<String> selectedFoodBundles,

    @Default(false) bool isSubmitting,
    String? snackbarMessage,
  }) = _RentalState;
  const RentalState._();

  /// Number of days between start and end dates, inclusive.
  int get rentalDays {
    final startStr = startDate;
    final endStr = endDate;
    if (startStr == null || endStr == null) return 1;

    final start = DateTime.tryParse(startStr);
    final end = DateTime.tryParse(endStr);
    if (start == null || end == null) return 1;

    return end.difference(start).inDays + 1;
  }

  /// Subtotal for the rental without fees.
  int get subtotal => (game?.price ?? 0) * rentalDays;

  /// Service fee applied to the subtotal.
  int get serviceFee => (subtotal * 0.1).round();

  /// Delivery fee based on delivery selection.
  int get deliveryFee => isDelivery ? 150 : 0;

  /// Total price for selected food bundles.
  int get foodTotal => selectedFoodBundles.length * 250;

  /// Total price including fees and add-ons.
  int get total => subtotal + serviceFee + deliveryFee + foodTotal;
}

@injectable
/// Bloc coordinating rental confirmation state and side effects.
class RentalBloc extends Bloc<RentalEvent, RentalState> {
  /// Creates a rental bloc with required dependencies.
  RentalBloc({required GetGames getGames, required ConfirmRental confirmRental})
    : _getGames = getGames,
      _confirmRental = confirmRental,
      super(const RentalState()) {
    on<_Started>(_onStarted);
    on<_StartDateChanged>(_onStartDateChanged);
    on<_EndDateChanged>(_onEndDateChanged);
    on<_DateRangeChanged>(_onDateRangeChanged);
    on<_DeliveryChanged>(_onDeliveryChanged);
    on<_DeliveryAddressChanged>(_onDeliveryAddressChanged);
    on<_DeliveryCommentsChanged>(_onDeliveryCommentsChanged);
    on<_PaymentMethodChanged>(_onPaymentMethodChanged);
    on<_FoodBundlesChanged>(_onFoodBundlesChanged);
    on<_Submitted>(_onSubmitted);
    on<_MessageShown>(_onMessageShown);
    on<_PublishAnother>(_onPublishAnother);
  }
  final GetGames _getGames;
  final ConfirmRental _confirmRental;

  Future<void> _onStarted(_Started event, Emitter<RentalState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        startDate: event.startDate,
        endDate: event.endDate,
        ownerId: event.ownerId,
        deposit: event.deposit,
      ),
    );

    final id = int.tryParse(event.gameId);
    if (id == null) {
      emit(state.copyWith(isLoading: false, errorMessage: 'ID inválido'));
      return;
    }

    try {
      final game = await _getGames.getById(id);
      if (game == null) {
        emit(
          state.copyWith(isLoading: false, errorMessage: 'Juego no encontrado'),
        );
        return;
      }
      emit(state.copyWith(isLoading: false, game: game));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar el juego: $e',
        ),
      );
    }
  }

  void _onStartDateChanged(_StartDateChanged event, Emitter<RentalState> emit) {
    final newStart = event.value;
    var newEnd = state.endDate;
    String? snackbar;

    if (newStart == null) {
      emit(state.copyWith(startDate: null, endDate: null));
      return;
    }

    final startDate = _parseDate(newStart);
    final endDate = _parseDate(newEnd);

    // If start date is moved past end date, clear end date
    if (startDate != null && endDate != null && !endDate.isAfter(startDate)) {
      newEnd = null;
      snackbar = 'Elegí una fecha de fin posterior al inicio.';
    }

    // Check availability and minimum duration (3 days)
    if (startDate != null && state.game != null) {
      final minEndDate = startDate.add(const Duration(days: 2));
      final minEndDateStr = DateFormatter.toIsoString(minEndDate);
      
      // Check 3-day window availability
      if (!state.game!.isAvailableFor(newStart, minEndDateStr)) {
        snackbar = 'El juego debe estar disponible por al menos 3 días.';
        emit(state.copyWith(startDate: null, endDate: null, snackbarMessage: snackbar));
        return;
      }

      // If we have an end date, check if it satisfies the 3-day rule and availability
      if (newEnd != null) {
        final parsedEnd = _parseDate(newEnd)!;
        if (parsedEnd.difference(startDate).inDays < 2) {
          newEnd = null;
          snackbar = 'El alquiler mínimo es de 3 días.';
        } else if (!state.game!.isAvailableFor(newStart, newEnd)) {
          snackbar = 'Las fechas seleccionadas ya no están disponibles.';
          newEnd = null;
        } else if (_isDurationTooLong(startDate, parsedEnd)) {
          snackbar = 'El alquiler no puede superar los 30 días.';
          newEnd = null;
        }
      }
    }

    emit(
      state.copyWith(
        startDate: newStart,
        endDate: newEnd,
        snackbarMessage: snackbar,
      ),
    );
  }

  void _onEndDateChanged(_EndDateChanged event, Emitter<RentalState> emit) {
    final newEnd = event.value;
    String? snackbar;

    final startDate = _parseDate(state.startDate);
    final endDate = _parseDate(newEnd);

    if (startDate != null && endDate != null) {
      if (endDate.difference(startDate).inDays < 2) {
        snackbar = 'El alquiler mínimo es de 3 días (ej: Lun a Jue).';
      } else if (!state.game!.isAvailableFor(state.startDate, newEnd)) {
        snackbar = 'Las fechas seleccionadas no están disponibles en su totalidad.';
      } else if (_isDurationTooLong(startDate, endDate)) {
        snackbar = 'El alquiler no puede superar los 30 días.';
      }
    }

    emit(state.copyWith(endDate: snackbar == null ? newEnd : null, snackbarMessage: snackbar));
  }

  void _onDateRangeChanged(_DateRangeChanged event, Emitter<RentalState> emit) {
    final startStr = event.start;
    final endStr = event.end;
    String? snackbar;

    if (startStr == null || endStr == null) {
      emit(state.copyWith(startDate: null, endDate: null, snackbarMessage: null));
      return;
    }

    final start = _parseDate(startStr);
    final end = _parseDate(endStr);

    if (start != null && end != null) {
      if (end.difference(start).inDays < 2) {
        snackbar = 'El alquiler mínimo es de 3 días.';
      } else if (!state.game!.isAvailableFor(startStr, endStr)) {
        snackbar = 'Este rango contiene días no disponibles.';
      } else if (_isDurationTooLong(start, end)) {
        snackbar = 'El alquiler no puede superar los 30 días.';
      }
    }

    if (snackbar != null) {
      emit(state.copyWith(snackbarMessage: snackbar));
    } else {
      emit(state.copyWith(startDate: startStr, endDate: endStr, snackbarMessage: null));
    }
  }

  void _onDeliveryChanged(_DeliveryChanged event, Emitter<RentalState> emit) {
    emit(state.copyWith(isDelivery: event.isDelivery));
  }

  void _onDeliveryAddressChanged(
    _DeliveryAddressChanged event,
    Emitter<RentalState> emit,
  ) {
    emit(state.copyWith(deliveryAddress: event.value));
  }

  void _onDeliveryCommentsChanged(
    _DeliveryCommentsChanged event,
    Emitter<RentalState> emit,
  ) {
    emit(state.copyWith(deliveryComments: event.value));
  }

  void _onPaymentMethodChanged(
    _PaymentMethodChanged event,
    Emitter<RentalState> emit,
  ) {
    emit(state.copyWith(paymentMethod: event.value));
  }

  void _onFoodBundlesChanged(
    _FoodBundlesChanged event,
    Emitter<RentalState> emit,
  ) {
    emit(state.copyWith(selectedFoodBundles: event.value));
  }

  Future<void> _onSubmitted(_Submitted event, Emitter<RentalState> emit) async {
    final start = state.startDate;
    final end = state.endDate;
    final game = state.game;

    if (game == null) return;
    final ownerId = game.ownerId ?? state.ownerId;
    if (ownerId == null || ownerId.isEmpty) {
      emit(
        state.copyWith(
          snackbarMessage: 'No pudimos identificar al dueño del juego.',
        ),
      );
      return;
    }
    if (start == null || end == null) {
      emit(
        state.copyWith(snackbarMessage: 'Seleccioná las fechas del alquiler'),
      );
      return;
    }

    final startDate = _parseDate(start);
    final endDate = _parseDate(end);
    
    if (startDate != null && endDate != null) {
      if (endDate.difference(startDate).inDays < 2) {
        emit(state.copyWith(snackbarMessage: 'El alquiler mínimo es de 3 días.'));
        return;
      }
      if (!game.isAvailableFor(start, end)) {
        emit(state.copyWith(snackbarMessage: 'Las fechas seleccionadas ya no están disponibles.'));
        return;
      }
      if (_isDurationTooLong(startDate, endDate)) {
        emit(state.copyWith(snackbarMessage: 'El alquiler no puede superar los 30 días.'));
        return;
      }
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _confirmRental(
        RentalDraft(
          gameId: game.id,
          ownerId: ownerId,
          startDate: start,
          endDate: end,
          deposit: (game.deposit ?? state.deposit) ?? 0,
          isDelivery: state.isDelivery,
          deliveryAddress: state.deliveryAddress,
          deliveryComments: state.deliveryComments,
          paymentMethod: state.paymentMethod,
          foodBundleIds: state.selectedFoodBundles,
          pricePerDay: game.price,
        ),
      );
      emit(state.copyWith(isSubmitting: false, success: true));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'No se pudo confirmar el alquiler: $e',
        ),
      );
    }
  }

  void _onMessageShown(_MessageShown event, Emitter<RentalState> emit) {
    emit(state.copyWith(snackbarMessage: null));
  }

  void _onPublishAnother(_PublishAnother event, Emitter<RentalState> emit) {
    emit(
      state.copyWith(
        success: false,
        startDate: null,
        endDate: null,
        isDelivery: false,
        deliveryAddress: '',
        deliveryComments: '',
        paymentMethod: 'mercadopago',
        selectedFoodBundles: const [],
        snackbarMessage: null,
        errorMessage: null,
      ),
    );
  }

  DateTime? _parseDate(String? date) {
    if (date == null) return null;
    return DateTime.tryParse(date);
  }

  bool _isDurationTooLong(DateTime start, DateTime end) {
    return end.difference(start).inDays > 30;
  }
}
