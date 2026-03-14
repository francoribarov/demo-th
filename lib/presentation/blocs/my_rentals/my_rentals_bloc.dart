import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/usecase/rental/get_my_rentals_use_case.dart';

part 'my_rentals_event.dart';
part 'my_rentals_state.dart';
part 'my_rentals_bloc.freezed.dart';

@injectable
class MyRentalsBloc extends Bloc<MyRentalsEvent, MyRentalsState> {
  MyRentalsBloc(this._getMyRentals) : super(const _Initial()) {
    on<_Started>(_onStarted);
    on<_Refresh>(_onRefresh);
    on<_DropOffSuccess>(_onDropOffSuccess);
    on<_MessageDismissed>(_onMessageDismissed);
  }

  final GetMyRentalsUseCase _getMyRentals;

  Future<void> _onStarted(
    _Started event,
    Emitter<MyRentalsState> emit,
  ) async {
    emit(const MyRentalsState.loading());
    await _fetchRentals(emit);
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<MyRentalsState> emit,
  ) async {
    await _fetchRentals(emit);
  }

  Future<void> _fetchRentals(Emitter<MyRentalsState> emit) async {
    final result = await _getMyRentals();

    result.fold(
      (error) => emit(MyRentalsState.failure(error.message)),
      (rentals) => emit(MyRentalsState.success(rentals)),
    );
  }

  void _onDropOffSuccess(
    _DropOffSuccess event,
    Emitter<MyRentalsState> emit,
  ) {
    if (state is! _Success) return;
    final currentState = state as _Success;

    final updatedRentals = currentState.rentals.map((rental) {
      if (rental.id == event.rentalId) {
        return rental.copyWith(status: RentalRequestStatus.returned);
      }
      return rental;
    }).toList();

    emit(
      currentState.copyWith(
        rentals: updatedRentals,
        feedbackMessage: 'Juego devuelto con éxito.',
      ),
    );
  }

  void _onMessageDismissed(
    _MessageDismissed event,
    Emitter<MyRentalsState> emit,
  ) {
    final currentState = state;
    if (currentState is! _Success) return;
    emit(currentState.copyWith(feedbackMessage: null));
  }
}
