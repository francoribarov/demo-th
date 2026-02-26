import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/catalog/publication_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/catalog/empty_results_state.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/catalog/results_header.dart';

/// View shown when search or filter results are active.
class ResultsView extends StatelessWidget {
  /// Creates a [ResultsView].
  const ResultsView({
    required this.query,
    required this.selectedCategory,
    required this.filteredPublications,
    required this.hasDateFilter,
    required this.filters,
    required this.sortOption,
    required this.onClearSearch,
    required this.onOpenFilters,
    required this.onSortChanged,
    required this.onOpenDates,
    required this.onRefresh,
    required this.onPublicationTap,
    required this.onCategoryTap,
    super.key,
  });

  final String query;
  final String? selectedCategory;
  final List<PublicationListing> filteredPublications;
  final bool hasDateFilter;
  final FiltersState filters;
  final SortOption sortOption;
  final VoidCallback onClearSearch;
  final Future<void> Function() onOpenFilters;
  final ValueChanged<SortOption> onSortChanged;
  final Future<void> Function() onOpenDates;
  final Future<void> Function() onRefresh;
  final ValueChanged<PublicationListing> onPublicationTap;
  final ValueChanged<String> onCategoryTap;

  String get _resultsTitle {
    if (selectedCategory != null) {
      return 'Juegos de $selectedCategory';
    }
    if (query.trim().isNotEmpty) {
      return 'Resultados para "$query"';
    }
    return 'Resultados de tu búsqueda';
  }

  @override
  Widget build(BuildContext context) {
    final noResults = filteredPublications.isEmpty;

    if (noResults) {
      return EmptyResultsState(
        onChangeDates: () => unawaited(onOpenDates()),
        onClearFilters: onClearSearch,
      );
    }

    return Column(
      children: [
        // Results header
        ResultsHeader(
          title: _resultsTitle,
          count: filteredPublications.length,
          hasDateFilter: hasDateFilter,
          filters: filters,
          sortOption: sortOption,
          onBack: onClearSearch,
          onOpenFilters: () => unawaited(onOpenFilters()),
          onSortChanged: onSortChanged,
          onOpenDates: () => unawaited(onOpenDates()),
        ),

        // Results grid
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            color: AppColors.gameRust,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 0.85,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredPublications.length,
              itemBuilder: (context, index) {
                final publication = filteredPublications[index];
                return PublicationCard(
                  publication: publication,
                  onTap: () => onPublicationTap(publication),
                  onCategoryTap: () {
                    if (publication.game.categories.isNotEmpty) {
                      onCategoryTap(publication.game.categories.first.name);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
