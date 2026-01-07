// Bloc events/states are documented at a higher level; omit per-member docs.
// 

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/search_games.dart';

part 'catalog_bloc.freezed.dart';
part 'catalog_event.dart';
part 'catalog_state.dart';

@injectable
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({required GetGames getGames, required SearchGames searchGames})
    : _getGames = getGames,
      _searchGames = searchGames,
      super(const CatalogState()) {
    on<LoadGames>(_onLoadGames);
    on<SearchCatalog>(_onSearch);
    on<ApplyFilters>(_onApplyFilters);
    on<UpdateSort>(_onUpdateSort);
    on<SelectCategory>(_onSelectCategory);
    on<ClearSearch>(_onClearSearch);
    on<SetDates>(_onSetDates);
  }

  final GetGames _getGames;
  final SearchGames _searchGames;

  Future<void> _onLoadGames(LoadGames event, Emitter<CatalogState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final games = await _getGames();
      final availableToday = await _getGames.getAvailableToday();
      final categories = await _getGames.getCategories();
      final shortcuts = await _getGames.getFilterShortcuts();

      emit(
        state.copyWith(
          isLoading: false,
          allGames: games,
          filteredGames: games,
          availableTodayGames: availableToday,
          categories: categories,
          filterShortcuts: shortcuts,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Error al cargar los juegos: $e'));
    }
  }

  Future<void> _onSearch(SearchCatalog event, Emitter<CatalogState> emit) async {
    final query = event.query ?? state.query;
    final startDate = event.startDate ?? state.startDate;
    final endDate = event.endDate ?? state.endDate;

    emit(state.copyWith(isLoading: true, query: query, startDate: startDate, endDate: endDate, selectedCategory: null));

    try {
      final results = await _searchGames(
        query: query,
        filters: state.filters,
        startDate: startDate,
        endDate: endDate,
        sortOption: state.sortOption,
      );

      emit(state.copyWith(isLoading: false, filteredGames: results));
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Error en la búsqueda: $e'));
    }
  }

  Future<void> _onApplyFilters(ApplyFilters event, Emitter<CatalogState> emit) async {
    emit(state.copyWith(isLoading: true, filters: event.filters));

    try {
      final results = await _searchGames(
        query: state.query,
        filters: event.filters,
        startDate: state.startDate,
        endDate: state.endDate,
        sortOption: state.sortOption,
      );

      emit(state.copyWith(isLoading: false, filteredGames: results));
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Error al aplicar filtros: $e'));
    }
  }

  Future<void> _onUpdateSort(UpdateSort event, Emitter<CatalogState> emit) async {
    emit(state.copyWith(isLoading: true, sortOption: event.sortOption));

    try {
      final results = await _searchGames(
        query: state.query,
        filters: state.filters,
        startDate: state.startDate,
        endDate: state.endDate,
        sortOption: event.sortOption,
      );

      emit(state.copyWith(isLoading: false, filteredGames: results));
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Error al ordenar: $e'));
    }
  }

  Future<void> _onSelectCategory(SelectCategory event, Emitter<CatalogState> emit) async {
    emit(state.copyWith(isLoading: true, query: event.category, selectedCategory: event.category));

    try {
      final results = await _searchGames(
        query: event.category,
        filters: state.filters,
        startDate: state.startDate,
        endDate: state.endDate,
        sortOption: state.sortOption,
      );

      emit(state.copyWith(isLoading: false, filteredGames: results));
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Error al filtrar categoría: $e'));
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<CatalogState> emit) {
    emit(
      state.copyWith(
        query: '',
        startDate: null,
        endDate: null,
        selectedCategory: null,
        filters: const FiltersState(),
        sortOption: SortOption.availability,
        filteredGames: state.allGames,
      ),
    );
  }

  Future<void> _onSetDates(SetDates event, Emitter<CatalogState> emit) async {
    final startDate = event.startDate;
    final endDate = event.endDate;

    // If clearing dates, also disable the availability filter
    var filters = state.filters;
    if (startDate == null || endDate == null) {
      filters = filters.copyWith(onlyAvailableInDates: false);
    }

    emit(state.copyWith(startDate: startDate, endDate: endDate, filters: filters, isLoading: true));

    try {
      final results = await _searchGames(
        query: state.query,
        filters: filters,
        startDate: startDate,
        endDate: endDate,
        sortOption: state.sortOption,
      );

      emit(state.copyWith(isLoading: false, filteredGames: results));
    } on Exception catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Error al filtrar por fechas: $e'));
    }
  }
}
