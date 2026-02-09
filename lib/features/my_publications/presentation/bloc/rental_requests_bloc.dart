import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/rental_request.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/usecases/accept_rental_request_usecase.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/usecases/get_rental_requests_usecase.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/usecases/reject_rental_request_usecase.dart';

part 'rental_requests_event.dart';
part 'rental_requests_state.dart';
part 'rental_requests_bloc.freezed.dart';

@injectable
class RentalRequestsBloc
    extends Bloc<RentalRequestsEvent, RentalRequestsState> {
  RentalRequestsBloc(
    this._getRentalRequests,
    this._acceptRentalRequest,
    this._rejectRentalRequest,
  ) : super(const _Initial()) {
    on<_Started>(_onStarted);
    on<_RequestAccepted>(_onAccepted);
    on<_RequestRejected>(_onRejected);
    on<_MessageDismissed>(_onMessageDismissed);
  }

  final GetRentalRequestsUseCase _getRentalRequests;
  final AcceptRentalRequestUseCase _acceptRentalRequest;
  final RejectRentalRequestUseCase _rejectRentalRequest;

  Future<void> _onStarted(
    _Started event,
    Emitter<RentalRequestsState> emit,
  ) async {
    emit(const RentalRequestsState.loading());
    try {
      final requests = await _getRentalRequests();
      emit(RentalRequestsState.success(requests));
    } on Object catch (e) {
      emit(RentalRequestsState.failure(e.toString()));
    }
  }

  Future<void> _onAccepted(
    _RequestAccepted event,
    Emitter<RentalRequestsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Success) return;

    emit(currentState.copyWith(processingRequestId: event.requestId));

    try {
      await _acceptRentalRequest(event.requestId);
      final updatedRequests = currentState.requests.map((r) {
        if (r.id == event.requestId) {
          return r.copyWith(status: RentalRequestStatus.accepted);
        }
        return r;
      }).toList();
      emit(
        RentalRequestsState.success(
          updatedRequests,
          feedbackMessage: 'Solicitud aceptada',
        ),
      );
    } on Object {
      emit(
        currentState.copyWith(
          processingRequestId: null,
          feedbackMessage: 'Error al procesar la solicitud',
        ),
      );
    }
  }

  Future<void> _onRejected(
    _RequestRejected event,
    Emitter<RentalRequestsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Success) return;

    emit(currentState.copyWith(processingRequestId: event.requestId));

    try {
      await _rejectRentalRequest(event.requestId);
      final updatedRequests = currentState.requests.map((r) {
        if (r.id == event.requestId) {
          return r.copyWith(status: RentalRequestStatus.rejected);
        }
        return r;
      }).toList();
      emit(
        RentalRequestsState.success(
          updatedRequests,
          feedbackMessage: 'Solicitud rechazada',
        ),
      );
    } on Object {
      emit(
        currentState.copyWith(
          processingRequestId: null,
          feedbackMessage: 'Error al procesar la solicitud',
        ),
      );
    }
  }

  void _onMessageDismissed(
    _MessageDismissed event,
    Emitter<RentalRequestsState> emit,
  ) {
    final currentState = state;
    if (currentState is! _Success) return;
    emit(currentState.copyWith(feedbackMessage: null));
  }
}
