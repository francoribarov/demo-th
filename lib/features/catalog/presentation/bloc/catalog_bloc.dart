// Bloc events/states are documented at a higher level; omit per-member docs.
//

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_publications.dart';

part 'catalog_bloc.freezed.dart';
part 'catalog_event.dart';
part 'catalog_state.dart';

@injectable
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({
    required GetGames getGames,
    required GetPublications getPublications,
  })  : _getGames = getGames,
        _getPublications = getPublications,
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
  final GetPublications _getPublications;

  Future<void> _onLoadGames(LoadGames event, Emitter<CatalogState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Load publications from /api/publications
      final publications = await _getPublications();

      List<GameCategory> categories = [];
      List<FilterShortcut> shortcuts = [];
      try {
        categories = await _getGames.getCategories();
        shortcuts = await _getGames.getFilterShortcuts();
      } catch (_) {
        // Categories/shortcuts not available, continue without them
      }

      emit(
        state.copyWith(
          isLoading: false,
          allPublications: publications,
          filteredPublications: publications,
          availableTodayPublications: publications,
          categories: categories,
          filterShortcuts: shortcuts,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Error al cargar datos: $e'));
    }
  }

  void _onSearch(SearchCatalog event, Emitter<CatalogState> emit) {
    final query = event.query ?? state.query;
    final startDate = event.startDate ?? state.startDate;
    final endDate = event.endDate ?? state.endDate;

    emit(state.copyWith(
      isLoading: true,
      query: query,
      startDate: startDate,
      endDate: endDate,
      selectedCategory: null,
    ));

    _applyFilters(emit);
  }

  void _onApplyFilters(ApplyFilters event, Emitter<CatalogState> emit) {
    emit(state.copyWith(isLoading: true, filters: event.filters));
    _applyFilters(emit);
  }

  void _onUpdateSort(UpdateSort event, Emitter<CatalogState> emit) {
    emit(state.copyWith(isLoading: true, sortOption: event.sortOption));
    _applyFilters(emit);
  }

  void _onSelectCategory(SelectCategory event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      isLoading: true,
      query: event.category,
      selectedCategory: event.category,
    ));
    _applyFilters(emit);
  }

  void _onClearSearch(ClearSearch event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      query: '',
      startDate: null,
      endDate: null,
      selectedCategory: null,
      filters: const FiltersState(),
      sortOption: SortOption.availability,
      filteredPublications: state.allPublications,
    ));
  }

  void _onSetDates(SetDates event, Emitter<CatalogState> emit) {
    final startDate = event.startDate;
    final endDate = event.endDate;

    var filters = state.filters;
    if (startDate == null || endDate == null) {
      filters = filters.copyWith(onlyAvailableInDates: false);
    }

    emit(state.copyWith(
      startDate: startDate,
      endDate: endDate,
      filters: filters,
      isLoading: true,
    ));

    _applyFilters(emit);
  }

  void _applyFilters(Emitter<CatalogState> emit) {
    var filtered = state.allPublications;

    // 1. Text Query
    if (state.query.isNotEmpty) {
      final q = state.query.toLowerCase();
      filtered = filtered
          .where((p) =>
              p.title.toLowerCase().contains(q) ||
              p.game.categories.any((c) => c.name.toLowerCase().contains(q)))
          .toList();
    }

    // 2. Category
    if (state.selectedCategory != null) {
      filtered = filtered
          .where((p) =>
              p.game.categories.any((c) => c.name == state.selectedCategory))
          .toList();
    }

    // 3. Price Filter
    if (state.filters.priceMax != null) {
      filtered =
          filtered.where((p) => p.price <= state.filters.priceMax!).toList();
    }

    // 4. Players Filter (Simple approximation)
    // TODO: Implement proper players range check parsing string '2-4'

    // Sort
    // TODO: Implement sorting if needed

    emit(state.copyWith(isLoading: false, filteredPublications: filtered));
  }
}
