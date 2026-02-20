import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/widgets/game_atoms.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';

class PublicationDetailsInfoHeader extends StatelessWidget {
  const PublicationDetailsInfoHeader({
    required this.publication,
    required this.gameDetail,
    required this.tabController,
    super.key,
  });

  final PublicationListing publication;
  final Game gameDetail;
  final TabController tabController;

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
            color: Colors.black.withOpacityValue(0.06),
            blurRadius: 16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category and rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
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
                    horizontal: 10,
                    vertical: 6,
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

            const SizedBox(height: 16),

            // Title
            Text(
              publication.title,
              style: AppTypography.displaySmall,
            ),

            const SizedBox(height: 12),

            // Owner card
            GestureDetector(
              onTap: () => context.goToGameOwner(publication.id),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.card.withOpacityValue(0.9),
                  borderRadius: BorderRadius.circular(
                    AppTheme.radiusLg,
                  ),
                  border: Border.all(
                    color: AppColors.gameBrown.withOpacityValue(0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacityValue(
                        0.04,
                      ),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.gameBrown,
                      child: Text(
                        'M',
                        style: AppTypography.titleMedium
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Martín R.',
                            style: AppTypography.titleSmall,
                          ),
                          Text(
                            'Montevideo • Responde en menos de 1h',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gameBrown.withOpacityValue(0.7),
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

            const SizedBox(height: 20),

            // Tabs
            Container(
              padding: const EdgeInsets.all(4),
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
                  horizontal: 6,
                  vertical: 2,
                ),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                labelStyle: AppTypography.labelLarge,
                unselectedLabelStyle: AppTypography.labelLarge,
                labelColor: Colors.white,
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
                  horizontal: 6,
                  vertical: 2,
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
