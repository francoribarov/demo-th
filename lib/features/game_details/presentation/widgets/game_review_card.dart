import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

/// A card displaying a single game review.
class GameReviewCard extends StatelessWidget {
  /// Creates a [GameReviewCard].
  const GameReviewCard({required this.review, super.key});

  /// The review to display.
  final GameReview review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacityValue(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.gameCream,
                child: Text(review.name[0], style: AppTypography.labelMedium),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.name, style: AppTypography.titleSmall),
                    Text(
                      review.role,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gameBrown.withOpacityValue(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < review.rating ? Icons.star : Icons.star_border,
                    color: AppColors.gameGold,
                    size: 14,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(review.comment, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}
