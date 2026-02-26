import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/catalog/publication_card.dart';

class MyPublicationsGrid extends StatelessWidget {
  const MyPublicationsGrid({
    required this.publications,
    required this.onEditPublication,
    super.key,
  });

  final List<PublicationListing> publications;
  final void Function(String publicationId) onEditPublication;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header with count
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gameRust.withOpacityValue(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radius2xl),
                  ),
                  child: Text(
                    '${publications.length} publicacion${publications.length == 1 ? '' : 'es'}',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.gameRust,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Publications grid
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.35,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final publication = publications[index];
                return PublicationCard(
                  publication: publication,
                  onTap: () => onEditPublication(publication.id),
                );
              },
              childCount: publications.length,
            ),
          ),
        ),
      ],
    );
  }
}
