part of 'catalog_bloc.dart';

@freezed
abstract class CatalogEvent with _$CatalogEvent {
  const factory CatalogEvent.loadGames() = LoadGames;
  const factory CatalogEvent.search({String? query, String? startDate, String? endDate}) = SearchCatalog;
  const factory CatalogEvent.applyFilters(FiltersState filters) = ApplyFilters;
  const factory CatalogEvent.updateSort(SortOption sortOption) = UpdateSort;
  const factory CatalogEvent.selectCategory(String category) = SelectCategory;
  const factory CatalogEvent.clearSearch() = ClearSearch;
  const factory CatalogEvent.setDates({String? startDate, String? endDate}) = SetDates;
}
