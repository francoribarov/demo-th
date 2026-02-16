// UI widgets are documented at a higher level; omit per-member docs.
//

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/blocs/catalog/catalog_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/catalog/discovery_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/catalog/results_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/catalog/search_header.dart';

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
                        ? ResultsView(state: state)
                        : const DiscoveryView(),
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
}
