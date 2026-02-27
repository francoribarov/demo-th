import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/catalog/available_today_section.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/catalog/category_chips.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/catalog/publication_section.dart';

/// Discovery view shown when no search or filters are active.
class DiscoveryView extends StatelessWidget {
  /// Creates a [DiscoveryView].
  const DiscoveryView({
    required this.categories,
    required this.filterShortcuts,
    required this.filteredPublications,
    required this.availableTodayPublications,
    required this.cooperativePublications,
    required this.familyPublications,
    required this.partyPublications,
    required this.strategyPublications,
    required this.onRefresh,
    required this.onCategorySelected,
    required this.onShortcutSelected,
    required this.onSeeMoreToday,
    required this.onPublicationTap,
    required this.onPublicationCategoryTap,
    super.key,
  });

  final List<GameCategory> categories;
  final List<FilterShortcut> filterShortcuts;
  final List<PublicationListing> filteredPublications;
  final List<PublicationListing> availableTodayPublications;

  /// Pre-filtered cooperative games (curated in CatalogBloc state).
  final List<PublicationListing> cooperativePublications;

  /// Pre-filtered family games (curated in CatalogBloc state).
  final List<PublicationListing> familyPublications;

  /// Pre-filtered party / fiesta games (curated in CatalogBloc state).
  final List<PublicationListing> partyPublications;

  /// Pre-filtered strategy / expert / deck-builder games (curated in CatalogBloc state).
  final List<PublicationListing> strategyPublications;

  final Future<void> Function() onRefresh;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<FilterShortcut> onShortcutSelected;
  final VoidCallback onSeeMoreToday;
  final ValueChanged<PublicationListing> onPublicationTap;
  final ValueChanged<String> onPublicationCategoryTap;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.gameRust,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'DESCUBRÍ TU PRÓXIMO JUEGO',
              style: AppTypography.sectionHeader,
            ),
          ),

          const SizedBox(height: 24),

          // Category chips
          CategoryChips(
            categories: categories,
            filterShortcuts: filterShortcuts,
            onCategorySelected: onCategorySelected,
            onShortcutSelected: onShortcutSelected,
          ),

          const SizedBox(height: 32),

          // Recommended section
          if (filteredPublications.isNotEmpty) ...[
            PublicationSection(
              title: 'Recomendados para vos',
              description: 'Nuestra mezcla favorita de clásicos y estrenos recientes.',
              publications: filteredPublications.take(6).toList(),
              variant: PublicationSectionVariant.carousel,
              onPublicationTap: onPublicationTap,
            ),
            const SizedBox(height: 32),
          ],
          if (availableTodayPublications.isNotEmpty) ...[
            AvailableTodaySection(
              publications: availableTodayPublications,
              onSeeMore: onSeeMoreToday,
              onPublicationTap: onPublicationTap,
            ),
            const SizedBox(height: 32),
          ],

          // Cooperative games
          _buildCategorySection(
            context,
            title: 'Cooperativos populares',
            description: 'Perfectos para ganar (o perder) todos juntos.',
            publications: cooperativePublications,
            variant: PublicationSectionVariant.carousel,
          ),

          // Family games
          _buildCategorySection(
            context,
            title: 'Para jugar en familia',
            description: 'Reglas simples y partidas ágiles para todas las edades.',
            publications: familyPublications,
            variant: PublicationSectionVariant.grid,
          ),

          // Party games
          _buildCategorySection(
            context,
            title: 'Fiesta y party games',
            description: 'Animá tu reunión con risas y creatividad.',
            publications: partyPublications,
            variant: PublicationSectionVariant.carousel,
          ),

          // Strategy games
          _buildCategorySection(
            context,
            title: 'Noches estratégicas',
            description: 'Opciones para quienes buscan desafíos bien profundos.',
            publications: strategyPublications,
            variant: PublicationSectionVariant.grid,
          ),

          // Full catalog
          PublicationSection(
            title: 'Catálogo completo',
            description: 'Todo lo que podés alquilar hoy mismo.',
            publications: filteredPublications,
            variant: PublicationSectionVariant.grid,
            onPublicationTap: onPublicationTap,
            onCategoryTap: (pub) {
              if (pub.game.categories.isNotEmpty) {
                onPublicationCategoryTap(pub.game.categories.first.name);
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
        onPublicationTap: onPublicationTap,
        onCategoryTap: (pub) {
          if (pub.game.categories.isNotEmpty) {
            onPublicationCategoryTap(pub.game.categories.first.name);
          }
        },
      ),
    );
  }
}
