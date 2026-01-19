import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/available_today_section.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/category_chips.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/game_section.dart';

/// Discovery view shown when no search or filters are active.
class DiscoveryView extends StatelessWidget {
  /// Creates a [DiscoveryView].
  const DiscoveryView({required this.state, super.key});

  /// Current catalog state.
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
              style: AppTypography.sectionHeader.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.9),
              ),
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
            GameSection(
              title: 'Recomendados para vos',
              description:
                  'Nuestra mezcla favorita de clásicos y estrenos recientes.',
              games: state.filteredGames.take(6).toList(),
              variant: GameSectionVariant.carousel,
              onGameTap: (game) => context.goToGame(game.id),
            ),
            const SizedBox(height: 32),
          ],

          // Available today section
          if (state.availableTodayGames.isNotEmpty) ...[
            AvailableTodaySection(
              games: state.availableTodayGames,
              onSeeMore: () {
                final today = DateFormatter.toIsoString(DateTime.now());
                context.read<CatalogBloc>().add(
                  SetDates(startDate: today, endDate: today),
                );
              },
              onGameTap: (game) => context.goToGame(game.id),
            ),
            const SizedBox(height: 32),
          ],

          // Cooperative games
          _buildCategorySection(
            context,
            title: 'Cooperativos populares',
            description: 'Perfectos para ganar (o perder) todos juntos.',
            games: state.filteredGames
                .where(
                  (g) => g.categories.any(
                    (c) => c.name.toLowerCase().contains('cooper'),
                  ),
                )
                .take(4)
                .toList(),
            variant: GameSectionVariant.carousel,
          ),

          // Family games
          _buildCategorySection(
            context,
            title: 'Para jugar en familia',
            description:
                'Reglas simples y partidas ágiles para todas las edades.',
            games: state.filteredGames
                .where(
                  (g) => g.categories.any(
                    (c) => c.name.toLowerCase().contains('familiar'),
                  ),
                )
                .take(4)
                .toList(),
            variant: GameSectionVariant.grid,
          ),

          // Party games
          _buildCategorySection(
            context,
            title: 'Fiesta y party games',
            description: 'Animá tu reunión con risas y creatividad.',
            games: state.filteredGames
                .where(
                  (g) => g.categories.any(
                    (c) => c.name.toLowerCase().contains('fiesta'),
                  ),
                )
                .take(4)
                .toList(),
            variant: GameSectionVariant.carousel,
          ),

          // Strategy games
          _buildCategorySection(
            context,
            title: 'Noches estratégicas',
            description:
                'Opciones para quienes buscan desafíos bien profundos.',
            games: state.filteredGames
                .where(
                  (g) => g.categories.any(
                    (c) => [
                      'estrategia',
                      'experto',
                      'deck',
                    ].any((tag) => c.name.toLowerCase().contains(tag)),
                  ),
                )
                .take(4)
                .toList(),
            variant: GameSectionVariant.grid,
          ),

          // Full catalog
          GameSection(
            title: 'Catálogo completo',
            description: 'Todo lo que podés alquilar hoy mismo.',
            games: state.filteredGames,
            variant: GameSectionVariant.grid,
            onGameTap: (game) => context.goToGame(game.id),
            onCategoryTap: (game) {
              if (game.categories.isNotEmpty) {
                context.read<CatalogBloc>().add(
                  SelectCategory(game.categories.first.name),
                );
              }
            },
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
    required GameSectionVariant variant,
  }) {
    if (games.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: GameSection(
        title: title,
        description: description,
        games: games,
        variant: variant,
        onGameTap: (game) => context.goToGame(game.id),
        onCategoryTap: (game) {
          if (game.categories.isNotEmpty) {
            context.read<CatalogBloc>().add(
              SelectCategory(game.categories.first.name),
            );
          }
        },
      ),
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
        bloc.add(
          ApplyFilters(bloc.state.filters.copyWith(playersRange: playerOption)),
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
