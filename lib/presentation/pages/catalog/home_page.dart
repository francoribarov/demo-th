// UI widgets are documented at a higher level; omit per-member docs.
//

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/presentation/blocs/catalog/catalog_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/catalog/search_header.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/catalog/discovery_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/catalog/filters_bottom_sheet.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/catalog/results_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/catalog/search_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              // Search header
              SearchHeader(
                query: state.query,
                startDate: state.startDate,
                endDate: state.endDate,
                selectedCategory: state.selectedCategory,
                onTap: () => unawaited(_openSearchSheet(context, state)),
              ),

              // Border under header
              Container(height: 4, color: AppColors.gameRust),

              // Main content
              Expanded(
                child: state.isLoading && state.allGames.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.gameRust,
                        ),
                      )
                    : state.isSearchMode
                    ? ResultsView(
                        query: state.query,
                        selectedCategory: state.selectedCategory,
                        filteredPublications: state.filteredPublications,
                        hasDateFilter: state.hasDateFilter,
                        filters: state.filters,
                        sortOption: state.sortOption,
                        onClearSearch: () {
                          context.read<CatalogBloc>().add(const ClearSearch());
                        },
                        onOpenFilters: () => _openFilters(context, state),
                        onSortChanged: (option) {
                          context.read<CatalogBloc>().add(UpdateSort(option));
                        },
                        onOpenDates: () => _openSearchSheet(context, state),
                        onRefresh: () async {
                          context.read<CatalogBloc>().add(const LoadGames());
                        },
                        onPublicationTap: (publication) =>
                            context.goToPublication(publication.id),
                        onCategoryTap: (categoryName) {
                          context.read<CatalogBloc>().add(
                            SelectCategory(categoryName),
                          );
                        },
                      )
                    : DiscoveryView(
                        categories: state.categories,
                        filterShortcuts: state.filterShortcuts,
                        filteredPublications: state.filteredPublications,
                        availableTodayPublications:
                            state.availableTodayPublications,
                        onRefresh: () async {
                          context.read<CatalogBloc>().add(const LoadGames());
                        },
                        onCategorySelected: (category) {
                          context.read<CatalogBloc>().add(
                            SelectCategory(category),
                          );
                        },
                        onShortcutSelected: (shortcut) =>
                            _handleShortcut(context, shortcut),
                        onSeeMoreToday: () {
                          final today = DateFormatter.toIsoString(
                            DateTime.now(),
                          );
                          context.read<CatalogBloc>().add(
                            SetDates(startDate: today, endDate: today),
                          );
                        },
                        onPublicationTap: (publication) =>
                            context.goToPublication(publication.id),
                        onPublicationCategoryTap: (categoryName) {
                          context.read<CatalogBloc>().add(
                            SelectCategory(categoryName),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
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
            query: query,
            startDate: startDate,
            endDate: endDate,
          ),
        );
      },
      onClear: () {
        context.read<CatalogBloc>().add(const ClearSearch());
      },
      onSurprise: () {
        // Random pick from filtered publications
        final pubs = state.filteredPublications.isNotEmpty
            ? state.filteredPublications
            : state.allPublications;
        if (pubs.isNotEmpty) {
          final random = pubs[DateTime.now().millisecond % pubs.length];
          context.goToPublication(random.id);
        }
      },
    );
  }

  Future<void> _openFilters(BuildContext context, CatalogState state) async {
    final result = await FiltersBottomSheet.show(
      context: context,
      initialFilters: state.filters,
      hasDateFilter: state.hasDateFilter,
      getPreviewCount: (_) => state.filteredPublications.length,
    );

    if (result != null && context.mounted) {
      context.read<CatalogBloc>().add(ApplyFilters(result));
    }
  }

  void _handleShortcut(BuildContext context, FilterShortcut shortcut) {
    final bloc = context.read<CatalogBloc>();
    switch (shortcut.type) {
      case 'players':
        final playerOption = switch (shortcut.value) {
          '2' => PlayersRangeOption.two,
          '3-4' => PlayersRangeOption.threeToFour,
          '5-6' => PlayersRangeOption.fiveToSix,
          '7+' => PlayersRangeOption.sevenPlus,
          _ => PlayersRangeOption.any,
        };
        bloc.add(
          ApplyFilters(
            bloc.state.filters.copyWith(playersRange: playerOption),
          ),
        );
        return;
      case 'duration':
        final durationOption = switch (shortcut.value) {
          'lte30' => DurationRangeOption.lte30,
          '30-60' => DurationRangeOption.thirtyToSixty,
          '60-90' => DurationRangeOption.sixtyToNinety,
          '90+' => DurationRangeOption.ninetyPlus,
          _ => DurationRangeOption.any,
        };
        bloc.add(
          ApplyFilters(
            bloc.state.filters.copyWith(durationRange: durationOption),
          ),
        );
        return;
      case 'price':
        final max = int.tryParse(shortcut.value ?? '');
        bloc.add(ApplyFilters(bloc.state.filters.copyWith(priceMax: max)));
        return;
      case 'query':
        bloc.add(SelectCategory(shortcut.query ?? shortcut.name));
        return;
    }
  }
}
