import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/usecase/rental/get_owner_rentals_use_case.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/owner_rentals/owner_rentals_event.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/owner_rentals/owner_rentals_state.dart';

@injectable
class OwnerRentalsBloc extends Bloc<OwnerRentalsEvent, OwnerRentalsState> {
  OwnerRentalsBloc(this._getOwnerRentals) : super(const OwnerRentalsState()) {
    on<OwnerRentalsEvent>((event, emit) async {
      await event.map(
        started: (_) => _onStarted(emit),
        refresh: (_) => _onStarted(emit),
      );
    });
  }

  final GetOwnerRentalsUseCase _getOwnerRentals;

  Future<void> _onStarted(Emitter<OwnerRentalsState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getOwnerRentals();

    result.fold(
      (error) {
        emit(state.copyWith(isLoading: false, errorMessage: error.message));
      },
      (tuple) {
        emit(state.copyWith(
          isLoading: false, 
          activeRentals: tuple.value1,
          upcomingRentals: tuple.value2,
        ));
      },
    );
  }
}
