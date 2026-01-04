part of 'catalog_bloc.dart';

@freezed
abstract class CatalogState with _$CatalogState {
  const factory CatalogState({
    @Default([]) List<Game> allGames,
    @Default([]) List<Game> filteredGames,
    @Default([]) List<Game> availableTodayGames,
    @Default([]) List<GameCategory> categories,
    @Default([]) List<FilterShortcut> filterShortcuts,
    @Default('') String query,
    String? startDate,
    String? endDate,
    String? selectedCategory,
    @Default(FiltersState()) FiltersState filters,
    @Default(SortOption.availability) SortOption sortOption,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _CatalogState;

  const CatalogState._();

  bool get isSearchMode =>
      query.trim().isNotEmpty ||
      (startDate != null && endDate != null) ||
      selectedCategory != null ||
      filters.hasActiveFilters;

  bool get hasDateFilter => startDate != null && endDate != null;
}
