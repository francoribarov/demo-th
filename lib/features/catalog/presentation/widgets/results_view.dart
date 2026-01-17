import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/empty_results_state.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/filters_bottom_sheet.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/publication_card.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/results_header.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/search_header.dart';

/// View shown when search or filter results are active.
class ResultsView extends StatelessWidget {
  /// Creates a [ResultsView].
  const ResultsView({required this.state, super.key});

  /// Current catalog state.
  final CatalogState state;

  String get _resultsTitle {
    if (state.selectedCategory != null) {
      return 'Juegos de ${state.selectedCategory}';
    }
    if (state.query.trim().isNotEmpty) {
      return 'Resultados para "${state.query}"';
    }
    return 'Resultados de tu búsqueda';
  }

  @override
  Widget build(BuildContext context) {
    final noResults = state.filteredPublications.isEmpty;

    if (noResults) {
      return EmptyResultsState(
        onChangeDates: () => unawaited(_openSearchSheet(context, state)),
        onClearFilters: () {
          context.read<CatalogBloc>().add(const ClearSearch());
        },
      );
    }

    return Column(
      children: [
        // Results header
        ResultsHeader(
          title: _resultsTitle,
          count: state.filteredPublications.length,
          hasDateFilter: state.hasDateFilter,
          filters: state.filters,
          sortOption: state.sortOption,
          onBack: () => context.read<CatalogBloc>().add(const ClearSearch()),
          onOpenFilters: () => unawaited(_openFilters(context, state)),
          onSortChanged: (option) {
            context.read<CatalogBloc>().add(UpdateSort(option));
          },
          onOpenDates: () => unawaited(_openSearchSheet(context, state)),
        ),

        // Results grid
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<CatalogBloc>().add(const LoadGames());
            },
            color: AppColors.gameRust,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 0.85,
                mainAxisSpacing: 16,
              ),
              itemCount: state.filteredPublications.length,
              itemBuilder: (context, index) {
                final publication = state.filteredPublications[index];
                return PublicationCard(
                  publication: publication,
                  onTap: () => context.goToPublication(publication.id),
                  onCategoryTap: () {
                    if (publication.game.categories.isNotEmpty) {
                      context.read<CatalogBloc>().add(
                            SelectCategory(
                                publication.game.categories.first.name),
                          );
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

  Future<void> _openSearchSheet(BuildContext context, CatalogState state) {
    return SearchSheet.show(
      context: context,
      initialQuery: state.query,
      initialStartDate: state.startDate,
      initialEndDate: state.endDate,
      onSearch: (query, startDate, endDate) {
        context.read<CatalogBloc>().add(
              SearchCatalog(
                  query: query, startDate: startDate, endDate: endDate),
            );
      },
      onClear: () {
        context.read<CatalogBloc>().add(const ClearSearch());
      },
    );
  }

  Future<void> _openFilters(BuildContext context, CatalogState state) async {
    final result = await FiltersBottomSheet.show(
      context: context,
      initialFilters: state.filters,
      hasDateFilter: state.hasDateFilter,
      getPreviewCount: (filters) {
        return state.filteredPublications
            .length; // TODO: Implement filtering logic preview for publications
      },
    );

    if (result != null && context.mounted) {
      context.read<CatalogBloc>().add(ApplyFilters(result));
    }
  }
}
