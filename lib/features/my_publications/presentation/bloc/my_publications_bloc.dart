import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_publications.dart';

part 'my_publications_bloc.freezed.dart';
part 'my_publications_event.dart';
part 'my_publications_state.dart';

/// Bloc for managing user's publications.
@injectable
class MyPublicationsBloc
    extends Bloc<MyPublicationsEvent, MyPublicationsState> {
  MyPublicationsBloc({
    required GetPublications getPublications,
  })  : _getPublications = getPublications,
        super(const MyPublicationsState()) {
    on<_Started>(_onStarted);
    on<_Refresh>(_onRefresh);
  }

  final GetPublications _getPublications;

  Future<void> _onStarted(
    _Started event,
    Emitter<MyPublicationsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final publications = await _getPublications.getMyPublications();
      emit(state.copyWith(
        isLoading: false,
        publications: publications,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cargar tus publicaciones: $e',
      ));
    }
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<MyPublicationsState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true, errorMessage: null));

    try {
      final publications = await _getPublications.getMyPublications();
      emit(state.copyWith(
        isRefreshing: false,
        publications: publications,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        isRefreshing: false,
        errorMessage: 'Error al actualizar: $e',
      ));
    }
  }
}
