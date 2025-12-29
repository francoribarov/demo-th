// UI widgets are documented at a higher level; omit per-member docs.
// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/category_chips.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/filters_bottom_sheet.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/game_card.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/search_header.dart';

/// Home page matching the Vite.js Home component
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
                    ? const Center(child: CircularProgressIndicator(color: AppColors.gameRust))
                    : state.isSearchMode
                    ? _ResultsView(state: state)
                    : _DiscoveryView(state: state),
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
        context.read<CatalogBloc>().add(SearchCatalog(query: query, startDate: startDate, endDate: endDate));
      },
      onClear: () {
        context.read<CatalogBloc>().add(const ClearSearch());
      },
      onSurprise: () {
        // Random pick from filtered games
        final games = state.filteredGames.isNotEmpty ? state.filteredGames : state.allGames;
        if (games.isNotEmpty) {
          final random = games[DateTime.now().millisecond % games.length];
          context.goToGame(random.id.toString());
        }
      },
    );
  }
}

/// Discovery view (shown when no search/filters active)
class _DiscoveryView extends StatelessWidget {
  const _DiscoveryView({required this.state});
  final CatalogState state;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CatalogBloc>().add(const LoadGames());
      },
      color: AppColors.gameRust,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'DESCUBRÍ TU PRÓXIMO JUEGO',
              style: AppTypography.sectionHeader.copyWith(color: AppColors.gameBrown.withOpacityValue(0.9)),
            ),
          ),

          const SizedBox(height: 24),

          // Category chips
          CategoryChips(
            categories: state.categories,
            filterShortcuts: state.filterShortcuts,
            onCategorySelected: (category) {
              context.read<CatalogBloc>().add(SelectCategory(category));
            },
            onShortcutSelected: (shortcut) {
              _handleShortcut(context, shortcut);
            },
          ),

          const SizedBox(height: 32),

          // Recommended section
          if (state.filteredGames.isNotEmpty) ...[
            _GameSection(
              title: 'Recomendados para vos',
              description: 'Nuestra mezcla favorita de clásicos y estrenos recientes.',
              games: state.filteredGames.take(6).toList(),
              variant: _SectionVariant.carousel,
            ),

            const SizedBox(height: 32),
          ],

          // Available today section
          if (state.availableTodayGames.isNotEmpty) ...[
            _AvailableTodaySection(games: state.availableTodayGames),
            const SizedBox(height: 32),
          ],

          // Cooperative games
          _buildCategorySection(
            context,
            title: 'Cooperativos populares',
            description: 'Perfectos para ganar (o perder) todos juntos.',
            games: state.filteredGames.where((g) => g.category.toLowerCase().contains('cooper')).take(4).toList(),
            variant: _SectionVariant.carousel,
          ),

          // Family games
          _buildCategorySection(
            context,
            title: 'Para jugar en familia',
            description: 'Reglas simples y partidas ágiles para todas las edades.',
            games: state.filteredGames.where((g) => g.category.toLowerCase().contains('familiar')).take(4).toList(),
            variant: _SectionVariant.grid,
          ),

          // Party games
          _buildCategorySection(
            context,
            title: 'Fiesta y party games',
            description: 'Animá tu reunión con risas y creatividad.',
            games: state.filteredGames.where((g) => g.category.toLowerCase().contains('fiesta')).take(4).toList(),
            variant: _SectionVariant.carousel,
          ),

          // Strategy games
          _buildCategorySection(
            context,
            title: 'Noches estratégicas',
            description: 'Opciones para quienes buscan desafíos bien profundos.',
            games: state.filteredGames
                .where((g) => ['estrategia', 'experto', 'deck'].any((tag) => g.category.toLowerCase().contains(tag)))
                .take(4)
                .toList(),
            variant: _SectionVariant.grid,
          ),

          // Full catalog
          _GameSection(
            title: 'Catálogo completo',
            description: 'Todo lo que podés alquilar hoy mismo.',
            games: state.filteredGames,
            variant: _SectionVariant.grid,
          ),

          const SizedBox(height: 100), // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildCategorySection(
    BuildContext context, {
    required String title,
    required String description,
    required List<Game> games,
    required _SectionVariant variant,
  }) {
    if (games.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: _GameSection(title: title, description: description, games: games, variant: variant),
    );
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
        bloc.add(ApplyFilters(bloc.state.filters.copyWith(playersRange: playerOption)));
        return;
      case 'duration':
        final durationOption = switch (shortcut.value) {
          'lte30' => DurationRangeOption.lte30,
          '30-60' => DurationRangeOption.thirtyToSixty,
          '60-90' => DurationRangeOption.sixtyToNinety,
          '90+' => DurationRangeOption.ninetyPlus,
          _ => DurationRangeOption.any,
        };
        bloc.add(ApplyFilters(bloc.state.filters.copyWith(durationRange: durationOption)));
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

/// Results view (shown when search/filters are active)
class _ResultsView extends StatelessWidget {
  const _ResultsView({required this.state});
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
    final noResults = state.filteredGames.isEmpty;

    if (noResults) {
      return _EmptyResultsState(
        onChangeDates: () => unawaited(_openSearchSheet(context, state)),
        onClearFilters: () {
          context.read<CatalogBloc>().add(const ApplyFilters(FiltersState()));
        },
      );
    }

    return Column(
      children: [
        // Results header
        _ResultsHeader(
          title: _resultsTitle,
          count: state.filteredGames.length,
          hasDateFilter: state.hasDateFilter,
          filters: state.filters,
          sortOption: state.sortOption,
          onBack: () => context.read<CatalogBloc>().add(const ClearSearch()),
          onOpenFilters: () => unawaited(_openFilters(context, state)),
          onSortChanged: (option) => context.read<CatalogBloc>().add(UpdateSort(option)),
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
              itemCount: state.filteredGames.length,
              itemBuilder: (context, index) {
                final game = state.filteredGames[index];
                return GameCard(
                  game: game,
                  highlightAvailability: state.hasDateFilter,
                  startDate: state.startDate,
                  endDate: state.endDate,
                  onTap: () => context.goToGame(game.id.toString()),
                  onCategoryTap: () {
                    context.read<CatalogBloc>().add(SelectCategory(game.category));
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
        context.read<CatalogBloc>().add(SearchCatalog(query: query, startDate: startDate, endDate: endDate));
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
        // This is a simplified preview - in production you might want
        // to call the repository directly
        return state.filteredGames.length;
      },
    );

    if (result != null && context.mounted) {
      context.read<CatalogBloc>().add(ApplyFilters(result));
    }
  }
}

class _ResultsHeader extends StatelessWidget {
  const _ResultsHeader({
    required this.title,
    required this.count,
    required this.hasDateFilter,
    required this.filters,
    required this.sortOption,
    required this.onBack,
    required this.onOpenFilters,
    required this.onSortChanged,
    required this.onOpenDates,
  });
  final String title;
  final int count;
  final bool hasDateFilter;
  final FiltersState filters;
  final SortOption sortOption;
  final VoidCallback onBack;
  final VoidCallback onOpenFilters;
  final void Function(SortOption) onSortChanged;
  final VoidCallback onOpenDates;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.card,
                  side: BorderSide(color: AppColors.gameBrown.withOpacityValue(0.3)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: AppTypography.headlineMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$count ${count == 1 ? 'juego' : 'juegos'}',
                          style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.6)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (hasDateFilter)
                      Text(
                        'Ordenamos primero los disponibles en tus fechas.',
                        style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                      )
                    else
                      GestureDetector(
                        onTap: onOpenDates,
                        child: Text(
                          'Agregá fechas para ver disponibilidad exacta',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.destructive,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dotted,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Filter/sort row
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onOpenFilters,
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: Text(filters.hasActiveFilters ? 'Filtros (${filters.activeFiltersCount})' : 'Filtros'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: filters.hasActiveFilters ? AppColors.gameRust : AppColors.gameBrown,
                    side: BorderSide(
                      color: filters.hasActiveFilters ? AppColors.gameRust : AppColors.gameBrown.withOpacityValue(0.2),
                    ),
                    backgroundColor: AppColors.card,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _showSortMenu(context),
                icon: const Icon(Icons.swap_vert),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.card,
                  side: BorderSide(
                    color: sortOption != SortOption.availability
                        ? AppColors.gameRust
                        : AppColors.gameBrown.withOpacityValue(0.2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSortMenu(BuildContext context) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: SortOption.values.map((option) {
              return ListTile(
                leading: sortOption == option
                    ? const Icon(Icons.check, color: AppColors.gameRust)
                    : const SizedBox(width: 24),
                title: Text(option.label),
                onTap: () {
                  onSortChanged(option);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _EmptyResultsState extends StatelessWidget {
  const _EmptyResultsState({required this.onChangeDates, required this.onClearFilters});
  final VoidCallback onChangeDates;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppTheme.radius3xl),
            border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.4)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No encontramos juegos con estos filtros.',
                style: AppTypography.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Probá cambiar las fechas o borrar algunos filtros.',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: onChangeDates, child: const Text('Cambiá las fechas')),
              const SizedBox(height: 12),
              OutlinedButton(onPressed: onClearFilters, child: const Text('Borrá filtros')),
            ],
          ),
        ),
      ),
    );
  }
}

/// Available today section
class _AvailableTodaySection extends StatelessWidget {
  const _AvailableTodaySection({required this.games});
  final List<Game> games;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayLabel = DateFormatter.formatFullDate(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('¡Alquilá para hoy!', style: AppTypography.headlineMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Listos para $todayLabel.',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () {
                  final today = DateFormatter.toIsoString(now);
                  context.read<CatalogBloc>().add(SetDates(startDate: today, endDate: today));
                },
                icon: const Icon(Icons.chevron_right, size: 18),
                label: const Text('Ver más'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: games.take(8).length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final game = games[index];
              return SizedBox(
                width: 280,
                child: GameCardHorizontal(game: game, onTap: () => context.goToGame(game.id.toString())),
              );
            },
          ),
        ),
      ],
    );
  }
}

enum _SectionVariant { grid, carousel }

class _GameSection extends StatelessWidget {
  const _GameSection({required this.title, required this.description, required this.games, required this.variant});
  final String title;
  final String description;
  final List<Game> games;
  final _SectionVariant variant;

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.headlineMedium),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (variant == _SectionVariant.carousel)
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: games.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final game = games[index];
                return SizedBox(
                  width: 280,
                  child: GameCardHorizontal(game: game, onTap: () => context.goToGame(game.id.toString())),
                );
              },
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: games.map((game) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GameCard(
                    game: game,
                    onTap: () => context.goToGame(game.id.toString()),
                    onCategoryTap: () {
                      context.read<CatalogBloc>().add(SelectCategory(game.category));
                    },
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
