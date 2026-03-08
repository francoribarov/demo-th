import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';

class PublicationDetailsInfoHeader extends StatelessWidget {
  const PublicationDetailsInfoHeader({
    required this.publication,
    required this.gameDetail,
    required this.ownerDisplayName,
    required this.tabController,
    required this.onOwnerTap,
    super.key,
  });

  final PublicationListing publication;
  final Game gameDetail;

  /// Display name for the owner (computed by page/bloc).
  final String ownerDisplayName;

  final TabController tabController;
  final VoidCallback onOwnerTap;

  String _ownerInitial(String ownerLabel) {
    final trimmed = ownerLabel.trim();
    if (trimmed.isEmpty) return 'P';
    return trimmed.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacityValue(0.06),
            blurRadius: 16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppTheme.spacingXl,
          AppTheme.spacing2xl,
          AppTheme.spacingXl,
          AppTheme.spacingMd,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category and rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd,
                    vertical: AppTheme.spacingXs + 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gameCream,
                    borderRadius: BorderRadius.circular(
                      AppTheme.radius2xl,
                    ),
                  ),
                  child: Text(
                    publication.categoryName,
                    style: AppTypography.categoryChip,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd - 2,
                    vertical: AppTheme.spacingXs + 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(
                      AppTheme.radius2xl,
                    ),
                    border: Border.all(
                      color: AppColors.gameBrown.withOpacityValue(0.12),
                    ),
                  ),
                  child: GameRatingBadge(
                    rating: gameDetail.rating,
                    reviewCount: gameDetail.reviewsCount,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppTheme.spacingLg),

            // Title
            Text(
              publication.title,
              style: AppTypography.displaySmall,
            ),

            const SizedBox(height: AppTheme.spacingMd),

            // Owner card
            GestureDetector(
              onTap: onOwnerTap,
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                decoration: BoxDecoration(
                  color: AppColors.card.withOpacityValue(0.9),
                  borderRadius: BorderRadius.circular(
                    AppTheme.radiusLg,
                  ),
                  border: Border.all(
                    color: AppColors.gameBrown.withOpacityValue(0.08),
                  ),
                  boxShadow: AppTheme.shadowMd,
                ),
                child: Row(
                  children: [
                    Builder(
                      builder: (context) {
                        final ownerInitial = _ownerInitial(ownerDisplayName);
                        return CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.gameBrown,
                          child: Text(
                            ownerInitial,
                            style: AppTypography.titleMedium.copyWith(
                              color: AppColors.primaryForeground,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: AppTheme.spacingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ownerDisplayName,
                            style: AppTypography.titleSmall,
                          ),
                          Text(
                            publication.ownerId,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.gameBrown,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppTheme.spacingXl),

            // Tabs
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingXs),
              decoration: BoxDecoration(
                color: AppColors.gameCream.withOpacityValue(
                  0.7,
                ),
                borderRadius: BorderRadius.circular(
                  AppTheme.radius2xl,
                ),
              ),
              child: TabBar(
                controller: tabController,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingXs + 2,
                  vertical: AppTheme.spacingXs / 2,
                ),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd - 2,
                ),
                labelStyle: AppTypography.labelLarge,
                unselectedLabelStyle: AppTypography.labelLarge,
                labelColor: AppColors.primaryForeground,
                unselectedLabelColor: AppColors.gameBrown,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: AppColors.gameRust,
                  borderRadius: BorderRadius.circular(
                    AppTheme.radius2xl,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gameRust.withOpacityValue(
                        0.35,
                      ),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingXs + 2,
                  vertical: AppTheme.spacingXs / 2,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'Detalles'),
                  Tab(text: 'Reseñas'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
