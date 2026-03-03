// Bloc events/states are documented at a higher level; omit per-member docs.
//

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/filter_publications_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_categories_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_filter_shortcuts_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_publications_use_case.dart';

part 'catalog_bloc.freezed.dart';
part 'catalog_event.dart';
part 'catalog_state.dart';

@injectable
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({
    required GetPublicationsUseCase getPublications,
    required GetCategoriesUseCase getCategories,
    required GetFilterShortcutsUseCase getFilterShortcuts,
    required FilterPublicationsUseCase filterPublications,
  })  : _getPublications = getPublications,
        _getCategories = getCategories,
        _getFilterShortcuts = getFilterShortcuts,
        _filterPublications = filterPublications,
        super(const CatalogState()) {
    on<LoadGames>(_onLoadGames);
    on<SearchCatalog>(_onSearch);
    on<ApplyFilters>(_onApplyFilters);
    on<UpdateSort>(_onUpdateSort);
    on<SelectCategory>(_onSelectCategory);
    on<ClearSearch>(_onClearSearch);
    on<SetDates>(_onSetDates);
  }

  final GetPublicationsUseCase _getPublications;
  final GetCategoriesUseCase _getCategories;
  final GetFilterShortcutsUseCase _getFilterShortcuts;
  final FilterPublicationsUseCase _filterPublications;

  Future<void> _onLoadGames(LoadGames event, Emitter<CatalogState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Load publications
    final publicationsResult = await _getPublications();

    await publicationsResult.fold<Future<void>>(
      (error) async {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Error al cargar publicaciones: ${error.message}',
          ),
        );
      },
      (publications) async {
        // Load categories and shortcuts (non-blocking)
        var categories = <GameCategory>[];
        var shortcuts = <FilterShortcut>[];

        final categoriesResult = await _getCategories();
        categoriesResult.fold(
          (_) {}, // Ignore category errors
          (data) => categories = data,
        );

        final shortcutsResult = await _getFilterShortcuts();
        shortcutsResult.fold(
          (_) {}, // Ignore shortcuts errors
          (data) => shortcuts = data,
        );

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
      },
    );
  }

  void _onSearch(SearchCatalog event, Emitter<CatalogState> emit) {
    final query = event.query ?? state.query;
    final startDate = event.startDate ?? state.startDate;
    final endDate = event.endDate ?? state.endDate;

    emit(
      state.copyWith(
        isLoading: true,
        query: query,
        startDate: startDate,
        endDate: endDate,
        selectedCategory: null,
      ),
    );

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
    emit(
      state.copyWith(
        isLoading: true,
        query: event.category,
        selectedCategory: event.category,
      ),
    );
    _applyFilters(emit);
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
        filteredPublications: state.allPublications,
      ),
    );
  }

  void _onSetDates(SetDates event, Emitter<CatalogState> emit) {
    final startDate = event.startDate;
    final endDate = event.endDate;

    var filters = state.filters;
    if (startDate == null || endDate == null) {
      filters = filters.copyWith(onlyAvailableInDates: false);
    }

    emit(
      state.copyWith(
        startDate: startDate,
        endDate: endDate,
        filters: filters,
        isLoading: true,
      ),
    );

    _applyFilters(emit);
  }

  void _applyFilters(Emitter<CatalogState> emit) {
    final filtered = _filterPublications(
      FilterPublicationsParams(
        publications: state.allPublications,
        query: state.query,
        selectedCategory: state.selectedCategory,
        filters: state.filters,
        sortOption: state.sortOption,
        startDate: state.startDate,
        endDate: state.endDate,
      ),
    );

    emit(state.copyWith(isLoading: false, filteredPublications: filtered));
  }
}
