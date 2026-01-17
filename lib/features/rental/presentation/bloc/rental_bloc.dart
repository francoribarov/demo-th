import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/l10n/app_strings.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_publications.dart';
import 'package:mobile_table_hopping/features/rental/domain/entities/rental_draft.dart';
import 'package:mobile_table_hopping/features/rental/domain/usecases/confirm_rental.dart';
import 'package:mobile_table_hopping/features/rental/domain/validators/rental_date_validator.dart';

part 'rental_bloc.freezed.dart';
part 'rental_event.dart';
part 'rental_state.dart';

@injectable

/// Bloc coordinating rental confirmation state and side effects.
class RentalBloc extends Bloc<RentalEvent, RentalState> {
  /// Creates a rental bloc with required dependencies.
  RentalBloc(
      {required GetPublications getPublications,
      required ConfirmRental confirmRental})
      : _getPublications = getPublications,
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
  final GetPublications _getPublications;
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

    final id = event.publicationId;

    try {
      final publication = await _getPublications.getById(id);
      if (publication == null) {
        emit(
          state.copyWith(
              isLoading: false, errorMessage: AppStrings.errorGameNotFound),
        );
        return;
      }
      emit(state.copyWith(isLoading: false, publication: publication));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: '${AppStrings.errorLoadingGame}: $e',
        ),
      );
    }
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

    String? snackbar;

    // If start date is moved past end date, clear end date
    if (start != null && end != null && !end.isAfter(start)) {
      newEnd = null;
      snackbar = AppStrings.rentalChooseLaterEnd;
    }

    final result = RentalDateValidator.validate(
      publication: state.publication,
      startDate: newStart,
      endDate: newEnd,
    );

    // If we newly set a start date but it makes the 3-day window unavailable
    if (newEnd == null && state.publication != null) {
      final startDate = DateTime.tryParse(newStart);
      if (startDate != null) {
        final minEndDate = startDate.add(const Duration(days: 2));
        if (!state.publication!
            .isAvailableFor(newStart, minEndDate.toIso8601String())) {
          return emit(
            state.copyWith(
              startDate: null,
              endDate: null,
              snackbarMessage: AppStrings.rentalMinAvailability,
            ),
          );
        }
      }
    }

    emit(
      state.copyWith(
        startDate: newStart,
        endDate: result.isValid ? newEnd : null,
        snackbarMessage: snackbar ?? (result.isValid ? null : result.message),
      ),
    );
  }

  void _onEndDateChanged(_EndDateChanged event, Emitter<RentalState> emit) {
    final newEnd = event.endDate;

    final result = RentalDateValidator.validate(
      publication: state.publication,
      startDate: state.startDate,
      endDate: newEnd,
    );

    emit(
      state.copyWith(
        endDate: result.isValid ? newEnd : null,
        snackbarMessage: result.isValid ? null : result.message,
      ),
    );
  }

  void _onDateRangeChanged(_DateRangeChanged event, Emitter<RentalState> emit) {
    final startStr = event.startDate;
    final endStr = event.endDate;

    if (startStr == null || endStr == null) {
      emit(state.copyWith(
          startDate: null, endDate: null, snackbarMessage: null));
      return;
    }

    final result = RentalDateValidator.validate(
      publication: state.publication,
      startDate: startStr,
      endDate: endStr,
    );

    emit(
      state.copyWith(
        startDate: result.isValid ? startStr : null,
        endDate: result.isValid ? endStr : null,
        snackbarMessage: result.isValid ? null : result.message,
      ),
    );
  }

  void _onDeliveryChanged(_DeliveryChanged event, Emitter<RentalState> emit) {
    emit(state.copyWith(isDelivery: event.isDelivery));
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
    emit(state.copyWith(selectedFoodBundles: event.foodBundles));
  }

  Future<void> _onSubmitted(_Submitted event, Emitter<RentalState> emit) async {
    final start = state.startDate;
    final end = state.endDate;
    final publication = state.publication;

    if (publication == null) return;

    final ownerId = publication.ownerId;
    if (ownerId.isEmpty) {
      emit(
          state.copyWith(snackbarMessage: AppStrings.rentalIdentifyOwnerError));
      return;
    }

    if (start == null || end == null) {
      emit(state.copyWith(snackbarMessage: AppStrings.rentalSelectDates));
      return;
    }

    final result = RentalDateValidator.validate(
      publication: publication,
      startDate: start,
      endDate: end,
    );

    if (!result.isValid) {
      emit(state.copyWith(snackbarMessage: result.message));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _confirmRental(
        RentalDraft(
          publicationId: publication.id,
          ownerId: ownerId,
          startDate: start,
          endDate: end,
          deposit: publication.deposit,
          isDelivery: state.isDelivery,
          deliveryAddress: state.deliveryAddress,
          deliveryComments: state.deliveryComments,
          paymentMethod: state.paymentMethod,
          foodBundleIds: state.selectedFoodBundles,
          pricePerDay: publication.price,
        ),
      );
      emit(state.copyWith(isSubmitting: false, success: true));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: '${AppStrings.rentalConfirmError}: $e',
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
}
