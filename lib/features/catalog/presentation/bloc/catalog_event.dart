part of 'catalog_bloc.dart';

/// Events for the Catalog BLoC.
@freezed
abstract class CatalogEvent with _$CatalogEvent {
  /// Loads all games and categories.
  const factory CatalogEvent.loadGames() = LoadGames;

  /// Performs a search with optional query and dates.
  const factory CatalogEvent.search(
      {String? query, String? startDate, String? endDate}) = SearchCatalog;

  /// Applies specific filters to the list.
  const factory CatalogEvent.applyFilters(FiltersState filters) = ApplyFilters;

  /// Updates the sorting option.
  const factory CatalogEvent.updateSort(SortOption sortOption) = UpdateSort;

  /// Selects a specific category to filter.
  const factory CatalogEvent.selectCategory(String category) = SelectCategory;

  /// Clears all active search and filters.
  const factory CatalogEvent.clearSearch() = ClearSearch;

  /// Sets the start and end dates for availability filtering.
  const factory CatalogEvent.setDates({String? startDate, String? endDate}) =
      SetDates;
}
