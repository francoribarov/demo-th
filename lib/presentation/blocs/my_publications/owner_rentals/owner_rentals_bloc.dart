import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/data/dto/rental/rental_drop_off_response.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/usecase/rental/drop_off_response_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/rental/get_drop_off_ticket_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/rental/get_owner_rentals_use_case.dart';

part 'owner_rentals_bloc.freezed.dart';
part 'owner_rentals_event.dart';
part 'owner_rentals_state.dart';

@injectable
class OwnerRentalsBloc extends Bloc<OwnerRentalsEvent, OwnerRentalsState> {
  OwnerRentalsBloc({
    required GetOwnerRentalsUseCase getOwnerRentals,
    required DropOffResponseUseCase dropOffResponse,
    required GetDropOffTicketUseCase getDropOffTicket,
  }) : _getOwnerRentals = getOwnerRentals,
       _dropOffResponse = dropOffResponse,
       _getDropOffTicket = getDropOffTicket,
       super(const OwnerRentalsState()) {
    _registerEventHandlers();
  }

  final GetOwnerRentalsUseCase _getOwnerRentals;
  final DropOffResponseUseCase _dropOffResponse;
  final GetDropOffTicketUseCase _getDropOffTicket;

  void _registerEventHandlers() {
    on<_Started>(_onStarted);
    on<_Refresh>(_onRefresh);
    on<_ConfirmReturn>(_onConfirmReturn);
    on<_MessageDismissed>(_onMessageDismissed);
  }

  Future<void> _loadRentals(Emitter<OwnerRentalsState> emit) async {
    final result = await _getOwnerRentals();
    await result.fold<Future<void>>(
      (error) async {
        emit(state.copyWith(isLoading: false, errorMessage: error.message));
      },
      (tuple) async {
        final returnedRentals = tuple.value1;
        // Fetch drop-off tickets for returned rentals concurrently
        final ticketFutures = returnedRentals
            .where((r) => r.dropOffTicketId != null)
            .map((r) => _getDropOffTicket(r.id));
        final ticketResults = await Future.wait(ticketFutures);

        final tickets = <String, RentalDropOffResponse>{};
        final returnedList = returnedRentals.toList();
        var i = 0;
        for (final rental in returnedRentals.where(
          (r) => r.dropOffTicketId != null,
        )) {
          ticketResults[i].fold(
            (_) {},
            (ticket) => tickets[rental.id] = ticket,
          );
          i++;
        }

        emit(
          state.copyWith(
            isLoading: false,
            returnedRentals: returnedList,
            activeRentals: tuple.value2,
            upcomingRentals: tuple.value3,
            dropOffTickets: tickets,
          ),
        );
      },
    );
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<OwnerRentalsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await _loadRentals(emit);
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<OwnerRentalsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await _loadRentals(emit);
  }

  Future<void> _onConfirmReturn(
    _ConfirmReturn event,
    Emitter<OwnerRentalsState> emit,
  ) async {
    emit(state.copyWith(isConfirming: true, errorMessage: null));

    // First retrieve the drop-off ticket
    final ticketResult = await _getDropOffTicket(event.rentalId);

    String? ticketId;
    await ticketResult.fold(
      (error) {
        emit(
          state.copyWith(
            isConfirming: false,
            errorMessage: 'Error al obtener el ticket: ${error.message}',
          ),
        );
      },
      (ticket) async {
        ticketId = ticket.id;
      },
    );

    if (ticketId == null) return; // Exit if ticket fetch failed

    // Then respond to the drop-off ticket
    final result = await _dropOffResponse(
      event.rentalId,
      'ACCEPTED',
      ticketId!,
    );

    await result.fold(
      (error) async {
        emit(
          state.copyWith(
            isConfirming: false,
            errorMessage: error.message,
          ),
        );
      },
      (_) async {
        emit(
          state.copyWith(
            isConfirming: false,
            successMessage: 'Alquiler completado exitosamente',
          ),
        );
        await _onStarted(const _Started(), emit);
      },
    );
  }

  void _onMessageDismissed(
    _MessageDismissed event,
    Emitter<OwnerRentalsState> emit,
  ) {
    emit(state.copyWith(successMessage: null, errorMessage: null));
  }
}
