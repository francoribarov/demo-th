import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/accept_rental_request_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/get_rental_requests_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/reject_rental_request_use_case.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';

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

    final result = await _getRentalRequests();

    result.fold(
      // Error case
      (error) {
        emit(RentalRequestsState.failure(error.message));
      },
      // Success case
      (requests) {
        emit(RentalRequestsState.success(requests));
      },
    );
  }

  Future<void> _onAccepted(
    _RequestAccepted event,
    Emitter<RentalRequestsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Success) return;

    emit(currentState.copyWith(processingRequestId: event.requestId));

    final result = await _acceptRentalRequest(event.requestId);

    result.fold(
      // Error case
      (error) {
        emit(
          currentState.copyWith(
            processingRequestId: null,
            feedbackNotice: const FeedbackNotice(
              message: 'Error al procesar la solicitud',
              severity: FeedbackSeverity.error,
            ),
          ),
        );
      },
      // Success case
      (_) {
        final accepted =
            currentState.requests.cast<RentalRequest?>().firstWhere(
                  (r) => r!.id == event.requestId,
                  orElse: () => null,
                );
        if (accepted == null) return;
        var rejectedCount = 0;
        final updatedRequests = currentState.requests.map((r) {
          if (r.id == event.requestId) {
            return r.copyWith(status: RentalRequestStatus.accepted);
          }
          if (r.status == RentalRequestStatus.pending &&
              accepted.overlapsWith(r)) {
            rejectedCount++;
            return r.copyWith(status: RentalRequestStatus.rejected);
          }
          return r;
        }).toList();

        final message = rejectedCount > 0
            ? 'Solicitud aceptada · $rejectedCount '
                '${rejectedCount == 1
                    ? 'solicitud rechazada'
                    : 'solicitudes rechazadas'} '
                'automáticamente'
            : 'Solicitud aceptada';

        emit(
          RentalRequestsState.success(
            updatedRequests,
            feedbackNotice: FeedbackNotice(
              message: message,
              severity: FeedbackSeverity.success,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onRejected(
    _RequestRejected event,
    Emitter<RentalRequestsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Success) return;

    emit(currentState.copyWith(processingRequestId: event.requestId));

    final result = await _rejectRentalRequest(event.requestId);

    result.fold(
      // Error case
      (error) {
        emit(
          currentState.copyWith(
            processingRequestId: null,
            feedbackNotice: const FeedbackNotice(
              message: 'Error al procesar la solicitud',
              severity: FeedbackSeverity.error,
            ),
          ),
        );
      },
      // Success case
      (_) {
        final updatedRequests = currentState.requests.map((r) {
          if (r.id == event.requestId) {
            return r.copyWith(status: RentalRequestStatus.rejected);
          }
          return r;
        }).toList();
        emit(
          RentalRequestsState.success(
            updatedRequests,
            feedbackNotice: const FeedbackNotice(
              message: 'Solicitud rechazada',
              severity: FeedbackSeverity.success,
            ),
          ),
        );
      },
    );
  }

  void _onMessageDismissed(
    _MessageDismissed event,
    Emitter<RentalRequestsState> emit,
  ) {
    final currentState = state;
    if (currentState is! _Success) return;
    emit(currentState.copyWith(feedbackNotice: null));
  }
}
