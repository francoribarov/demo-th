import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/params/rental/confirm_rental_params.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_publication_by_id_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/rental/confirm_rental_use_case.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';

part 'rental_bloc.freezed.dart';
part 'rental_event.dart';
part 'rental_state.dart';

@injectable
/// Bloc coordinating rental confirmation state and side effects.
class RentalBloc extends Bloc<RentalEvent, RentalState> {
  /// Creates a rental bloc with required dependencies.
  RentalBloc({
    required GetPublicationByIdUseCase getPublicationById,
    required ConfirmRentalUseCase confirmRentalUseCase,
  }) : _getPublicationById = getPublicationById,
       _confirmRentalUseCase = confirmRentalUseCase,
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
  final GetPublicationByIdUseCase _getPublicationById;
  final ConfirmRentalUseCase _confirmRentalUseCase;

  Future<void> _onStarted(_Started event, Emitter<RentalState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        feedbackNotice: null,
        startDate: event.startDate,
        endDate: event.endDate,
        ownerId: event.ownerId,
        deposit: event.deposit,
      ),
    );

    final id = event.publicationId;

    final result = await _getPublicationById(id);
    result.fold(
      (error) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar el juego.: ${error.message}',
          feedbackNotice: FeedbackNotice(
            message: 'Error al cargar el juego.: ${error.message}',
            severity: FeedbackSeverity.error,
          ),
        ),
      ),
      (publication) => emit(
        _updateCalculations(
          state.copyWith(isLoading: false, publication: publication),
        ),
      ),
    );
  }

  void _onStartDateChanged(_StartDateChanged event, Emitter<RentalState> emit) {
    final newStart = event.startDate;
    var newEnd = state.endDate;

    if (newStart == null) {
      emit(state.copyWith(startDate: null, endDate: null));
      return;
    }

    final start = DateTime.tryParse(newStart);
    final end = DateTime.tryParse(newEnd ?? '');

    FeedbackNotice? feedbackNotice;

    // If start date is moved past end date, clear end date
    if (start != null && end != null && !end.isAfter(start)) {
      newEnd = null;
      feedbackNotice = const FeedbackNotice(
        message: 'Elegí una fecha de fin posterior al inicio.',
        severity: FeedbackSeverity.warning,
      );
    }

    final errorMessage = _validateDates(
      state.publication,
      newStart,
      newEnd,
    );

    // If we newly set a start date but it makes the 3-day window unavailable
    if (newEnd == null && state.publication != null) {
      final startDate = DateTime.tryParse(newStart);
      if (startDate != null) {
        final minEndDate = startDate.add(const Duration(days: 2));
        if (!state.publication!.isAvailableFor(
          newStart,
          minEndDate.toIso8601String(),
        )) {
          return emit(
            state.copyWith(
              startDate: null,
              endDate: null,
              feedbackNotice: const FeedbackNotice(
                message: 'El juego debe estar disponible por al menos 3 días.',
                severity: FeedbackSeverity.warning,
              ),
            ),
          );
        }
      }
    }

    emit(
      _updateCalculations(
        state.copyWith(
          startDate: newStart,
          endDate: errorMessage == null ? newEnd : null,
          feedbackNotice: errorMessage != null
              ? FeedbackNotice(
                  message: errorMessage,
                  severity: FeedbackSeverity.warning,
                )
              : feedbackNotice,
        ),
      ),
    );
  }

  void _onEndDateChanged(_EndDateChanged event, Emitter<RentalState> emit) {
    final newEnd = event.endDate;

    final errorMessage = _validateDates(
      state.publication,
      state.startDate,
      newEnd,
    );

    emit(
      _updateCalculations(
        state.copyWith(
          endDate: errorMessage == null ? newEnd : null,
          feedbackNotice: errorMessage == null
              ? null
              : FeedbackNotice(
                  message: errorMessage,
                  severity: FeedbackSeverity.warning,
                ),
        ),
      ),
    );
  }

  void _onDateRangeChanged(_DateRangeChanged event, Emitter<RentalState> emit) {
    final startStr = event.startDate;
    final endStr = event.endDate;

    if (startStr == null || endStr == null) {
      emit(
        state.copyWith(
          startDate: null,
          endDate: null,
          feedbackNotice: null,
        ),
      );
      return;
    }

    final errorMessage = _validateDates(
      state.publication,
      startStr,
      endStr,
    );

    emit(
      _updateCalculations(
        state.copyWith(
          startDate: errorMessage == null ? startStr : null,
          endDate: errorMessage == null ? endStr : null,
          feedbackNotice: errorMessage == null
              ? null
              : FeedbackNotice(
                  message: errorMessage,
                  severity: FeedbackSeverity.warning,
                ),
        ),
      ),
    );
  }

  void _onDeliveryChanged(_DeliveryChanged event, Emitter<RentalState> emit) {
    emit(
      _updateCalculations(
        state.copyWith(isDelivery: event.isDelivery),
      ),
    );
  }

  void _onDeliveryAddressChanged(
    _DeliveryAddressChanged event,
    Emitter<RentalState> emit,
  ) {
    emit(state.copyWith(deliveryAddress: event.address));
  }

  void _onDeliveryCommentsChanged(
    _DeliveryCommentsChanged event,
    Emitter<RentalState> emit,
  ) {
    emit(state.copyWith(deliveryComments: event.comments));
  }

  void _onPaymentMethodChanged(
    _PaymentMethodChanged event,
    Emitter<RentalState> emit,
  ) {
    emit(state.copyWith(paymentMethod: event.paymentMethod));
  }

  void _onFoodBundlesChanged(
    _FoodBundlesChanged event,
    Emitter<RentalState> emit,
  ) {
    emit(
      _updateCalculations(
        state.copyWith(selectedFoodBundles: event.foodBundles),
      ),
    );
  }

  Future<void> _onSubmitted(_Submitted event, Emitter<RentalState> emit) async {
    final start = state.startDate;
    final end = state.endDate;
    final publication = state.publication;

    if (publication == null) return;

    final ownerId = publication.ownerId;
    if (ownerId.isEmpty) {
      emit(
        state.copyWith(
          feedbackNotice: const FeedbackNotice(
            message: 'No pudimos identificar al dueño del juego.',
            severity: FeedbackSeverity.warning,
          ),
        ),
      );
      return;
    }

    if (start == null || end == null) {
      emit(
        state.copyWith(
          feedbackNotice: const FeedbackNotice(
            message: 'Seleccioná las fechas del alquiler.',
            severity: FeedbackSeverity.warning,
          ),
        ),
      );
      return;
    }

    final isValid = _validateDates(publication, start, end);

    if (isValid != null) {
      emit(
        state.copyWith(
          feedbackNotice: FeedbackNotice(
            message: isValid,
            severity: FeedbackSeverity.warning,
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        feedbackNotice: null,
      ),
    );

    // Build params for the use case
    final params = ConfirmRentalParams(
      publicationId: publication.id,
      startDate: start,
      endDate: end,
      isDelivery: state.isDelivery,
      deliveryAddress: state.deliveryAddress,
      deliveryComments: state.deliveryComments,
      paymentMethod: state.paymentMethod,
      foodBundleIds: state.selectedFoodBundles,
    );

    // Call use case and handle Either result
    final result = await _confirmRentalUseCase(params);

    result.fold(
      // Left: error case
      (error) => emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage:
              'No se pudo enviar la solicitud de alquiler.: ${error.message}',
          feedbackNotice: FeedbackNotice(
            message:
                'No se pudo enviar la solicitud de alquiler.: ${error.message}',
            severity: FeedbackSeverity.error,
          ),
        ),
      ),
      // Right: success case
      (_) => emit(state.copyWith(isSubmitting: false, success: true)),
    );
  }

  void _onMessageShown(_MessageShown event, Emitter<RentalState> emit) {
    emit(state.copyWith(feedbackNotice: null));
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
        feedbackNotice: null,
        errorMessage: null,
      ),
    );
  }

  RentalState _updateCalculations(RentalState state) {
    // If no publication yet, we can't calculate much, but we can set defaults
    // or just return as is if we rely on publication price.
    // Assuming defaults:
    final price = state.publication?.price ?? 0.0;

    final startStr = state.startDate;
    final endStr = state.endDate;
    var rentalDays = 1;
    if (startStr != null && endStr != null) {
      final start = DateTime.tryParse(startStr);
      final end = DateTime.tryParse(endStr);
      if (start != null && end != null) {
        // From Mon to Wed is 3 days. difference gives 2.
        rentalDays = end.difference(start).inDays + 1;
        if (rentalDays < 1) rentalDays = 1;
      }
    }

    final subtotal = price * rentalDays;
    final serviceFee = (subtotal * 0.1).round();
    final deliveryFee = state.isDelivery ? 150 : 0;
    final foodTotal = state.selectedFoodBundles.length * 250;
    final total = subtotal + serviceFee + deliveryFee + foodTotal;

    return state.copyWith(
      rentalDays: rentalDays,
      subtotal: subtotal,
      serviceFee: serviceFee,
      deliveryFee: deliveryFee,
      foodTotal: foodTotal,
      total: total,
    );
  }

  /// Validates rental dates. Returns error message if invalid, null if valid.
  String? _validateDates(
    PublicationListing? publication,
    String? startDate,
    String? endDate,
  ) {
    if (publication == null) {
      return 'No se pudo cargar la información del juego.';
    }

    if (startDate == null || endDate == null) {
      return null;
    }

    final start = DateTime.tryParse(startDate);
    final end = DateTime.tryParse(endDate);

    if (start == null || end == null) {
      return 'Formato de fecha inválido.';
    }

    // Check minimum duration (3 days)
    final durationInDays = end.difference(start).inDays + 1;
    if (durationInDays < 3) {
      return 'El alquiler mínimo es de 3 días (ej: Lun a Jue).';
    }

    // Check maximum duration (30 days)
    if (durationInDays > 30) {
      return 'El alquiler no puede superar los 30 días.';
    }

    // Check availability
    if (!publication.isAvailableFor(startDate, endDate)) {
      return 'Las fechas seleccionadas no están disponibles en su totalidad.';
    }

    return null;
  }
}
