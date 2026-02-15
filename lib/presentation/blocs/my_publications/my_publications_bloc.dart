import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_my_publications_use_case.dart';

part 'my_publications_bloc.freezed.dart';
part 'my_publications_event.dart';
part 'my_publications_state.dart';

/// Bloc for managing user's publications.
@injectable
class MyPublicationsBloc
    extends Bloc<MyPublicationsEvent, MyPublicationsState> {
  MyPublicationsBloc({
    required GetMyPublicationsUseCase getMyPublications,
  })  : _getMyPublications = getMyPublications,
        super(const MyPublicationsState()) {
    on<_Started>(_onStarted);
    on<_Refresh>(_onRefresh);
  }

  final GetMyPublicationsUseCase _getMyPublications;

  Future<void> _onStarted(
    _Started event,
    Emitter<MyPublicationsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getMyPublications();
    result.fold(
      (error) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar tus publicaciones: ${error.message}',
        ),
      ),
      (publications) => emit(
        state.copyWith(
          isLoading: false,
          publications: publications,
        ),
      ),
    );
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<MyPublicationsState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true, errorMessage: null));

    final result = await _getMyPublications();
    result.fold(
      (error) => emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage: 'Error al actualizar: ${error.message}',
        ),
      ),
      (publications) => emit(
        state.copyWith(
          isRefreshing: false,
          publications: publications,
        ),
      ),
    );
  }
}
