import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/available_today_section.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/category_chips.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/publication_section.dart';

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
          if (state.filteredPublications.isNotEmpty) ...[
            PublicationSection(
              title: 'Recomendados para vos',
              description:
                  'Nuestra mezcla favorita de clásicos y estrenos recientes.',
              publications: state.filteredPublications.take(6).toList(),
              variant: PublicationSectionVariant.carousel,
              onPublicationTap: (pub) => context.goToPublication(pub.id),
            ),
            const SizedBox(height: 32),
          ],
          if (state.availableTodayPublications.isNotEmpty) ...[
            AvailableTodaySection(
              publications: state.availableTodayPublications,
              onSeeMore: () {
                final today = DateFormatter.toIsoString(DateTime.now());
                context
                    .read<CatalogBloc>()
                    .add(SetDates(startDate: today, endDate: today));
              },
              onPublicationTap: (publication) =>
                  context.goToPublication(publication.id),
            ),
            const SizedBox(height: 32),
          ],

          // Cooperative games
          _buildCategorySection(
            context,
            title: 'Cooperativos populares',
            description: 'Perfectos para ganar (o perder) todos juntos.',
            publications: state.filteredPublications
                .where(
                  (p) => p.game.categories
                      .any((c) => c.name.toLowerCase().contains('cooper')),
                )
                .take(4)
                .toList(),
            variant: PublicationSectionVariant.carousel,
          ),

          // Family games
          _buildCategorySection(
            context,
            title: 'Para jugar en familia',
            description:
                'Reglas simples y partidas ágiles para todas las edades.',
            publications: state.filteredPublications
                .where(
                  (p) => p.game.categories
                      .any((c) => c.name.toLowerCase().contains('familiar')),
                )
                .take(4)
                .toList(),
            variant: PublicationSectionVariant.grid,
          ),

          // Party games
          _buildCategorySection(
            context,
            title: 'Fiesta y party games',
            description: 'Animá tu reunión con risas y creatividad.',
            publications: state.filteredPublications
                .where(
                  (p) => p.game.categories
                      .any((c) => c.name.toLowerCase().contains('fiesta')),
                )
                .take(4)
                .toList(),
            variant: PublicationSectionVariant.carousel,
          ),

          // Strategy games
          _buildCategorySection(
            context,
            title: 'Noches estratégicas',
            description:
                'Opciones para quienes buscan desafíos bien profundos.',
            publications: state.filteredPublications
                .where(
                  (p) => p.game.categories.any(
                    (c) => ['estrategia', 'experto', 'deck']
                        .any((tag) => c.name.toLowerCase().contains(tag)),
                  ),
                )
                .take(4)
                .toList(),
            variant: PublicationSectionVariant.grid,
          ),

          // Full catalog
          PublicationSection(
            title: 'Catálogo completo',
            description: 'Todo lo que podés alquilar hoy mismo.',
            publications: state.filteredPublications,
            variant: PublicationSectionVariant.grid,
            onPublicationTap: (pub) => context.goToPublication(pub.id),
            onCategoryTap: (pub) {
              if (pub.game.categories.isNotEmpty) {
                context
                    .read<CatalogBloc>()
                    .add(SelectCategory(pub.game.categories.first.name));
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
    required List<PublicationListing> publications,
    required PublicationSectionVariant variant,
  }) {
    if (publications.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: PublicationSection(
        title: title,
        description: description,
        publications: publications,
        variant: variant,
        onPublicationTap: (pub) => context.goToPublication(pub.id),
        onCategoryTap: (pub) {
          if (pub.game.categories.isNotEmpty) {
            context
                .read<CatalogBloc>()
                .add(SelectCategory(pub.game.categories.first.name));
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
