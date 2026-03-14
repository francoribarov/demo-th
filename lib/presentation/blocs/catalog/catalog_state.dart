part of 'catalog_bloc.dart';

/// State for the Catalog BLoC.
@freezed
abstract class CatalogState with _$CatalogState {
  /// Creates a CatalogState.
  const factory CatalogState({
    /// All publications available in the system.
    @Default([]) List<PublicationListing> allPublications,

    /// Publications filtered by the current search/filters.
    @Default([]) List<PublicationListing> filteredPublications,

    /// Publications available for rental today.
    @Default([]) List<PublicationListing> availableTodayPublications,

    /// All games available in the system (legacy, for detail views).
    @Default([]) List<Game> allGames,

    /// List of game categories.
    @Default([]) List<GameCategory> categories,

    /// Recommended filter shortcuts.
    @Default([]) List<FilterShortcut> filterShortcuts,

    /// Current search query string.
    @Default('') String query,

    /// Current search start date.
    String? startDate,

    /// Current search end date.
    String? endDate,

    /// Currently selected category name.
    String? selectedCategory,

    /// Detailed filters state.
    @Default(FiltersState()) FiltersState filters,

    /// Current sorting option.
    @Default(SortOption.availability) SortOption sortOption,

    /// Whether data is currently loading.
    @Default(false) bool isLoading,

    /// Error message if loading failed.
    String? errorMessage,
  }) = _CatalogState;

  const CatalogState._();

  /// Whether the BLoC is currently in search mode (filters or query active).
  bool get isSearchMode =>
      query.trim().isNotEmpty ||
      (startDate != null && endDate != null) ||
      selectedCategory != null ||
      filters.hasActiveFilters;

  /// Whether a date filter is active.
  bool get hasDateFilter => startDate != null && endDate != null;

  /// Publications in the cooperative category (up to 4).
  List<PublicationListing> get cooperativePublications => filteredPublications
      .where(
        (p) => p.game.categories.any(
          (c) => c.name.toLowerCase().contains('cooper'),
        ),
      )
      .take(4)
      .toList();

  /// Publications in the family category (up to 4).
  List<PublicationListing> get familyPublications => filteredPublications
      .where(
        (p) => p.game.categories.any(
          (c) => c.name.toLowerCase().contains('familiar'),
        ),
      )
      .take(4)
      .toList();

  /// Publications in the party / fiesta category (up to 4).
  List<PublicationListing> get partyPublications => filteredPublications
      .where(
        (p) => p.game.categories.any(
          (c) => c.name.toLowerCase().contains('fiesta'),
        ),
      )
      .take(4)
      .toList();

  /// Publications in the strategy / expert / deck-builder category (up to 4).
  List<PublicationListing> get strategyPublications => filteredPublications
      .where(
        (p) => p.game.categories.any(
          (c) => ['estrategia', 'experto', 'deck'].any(
            (tag) => c.name.toLowerCase().contains(tag),
          ),
        ),
      )
      .take(4)
      .toList();
}
