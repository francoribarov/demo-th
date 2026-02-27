import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/surface_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/publication_details/game_review_card.dart';

class PublicationReviewsTabContent extends StatelessWidget {
  const PublicationReviewsTabContent({
    required this.gameDetail,
    required this.onViewAllReviews,
    super.key,
  });

  final Game gameDetail;
  final VoidCallback onViewAllReviews;

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
          SurfaceCard(
            padding: const EdgeInsets.all(16),
            borderColor: AppColors.gameBrown.withOpacityValue(0.08),
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
                          i < gameDetail.rating.floor() ? Icons.star : Icons.star_border,
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
            onPressed: onViewAllReviews,
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
