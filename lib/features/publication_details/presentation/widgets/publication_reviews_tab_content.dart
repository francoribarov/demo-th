import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/publication_details/presentation/widgets/game_review_card.dart';

class PublicationReviewsTabContent extends StatelessWidget {
  const PublicationReviewsTabContent({
    required this.gameDetail,
    required this.publicationId,
    super.key,
  });

  final Game gameDetail;
  final String publicationId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(
                AppTheme.radiusLg,
              ),
              border: Border.all(
                color: AppColors.gameBrown.withOpacityValue(0.08),
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gameDetail.rating.toStringAsFixed(1),
                      style: AppTypography.displayMedium,
                    ),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < gameDetail.rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: AppColors.gameGold,
                          size: 16,
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${gameDetail.reviewsCount} reseñas',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gameBrown.withOpacityValue(
                          0.7,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Reviews list
          ...gameDetail.reviews.map((review) {
            return GameReviewCard(review: review);
          }),

          // See all reviews
          OutlinedButton(
            onPressed: () => context.goToGameReviews(
              publicationId,
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                48,
              ),
            ),
            child: const Text(
              'Ver todas las reseñas',
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
