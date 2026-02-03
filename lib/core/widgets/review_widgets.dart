import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// A consistent rating bar showing stars and a progress indicator.
class ReviewRatingBar extends StatelessWidget {
  /// Creates a rating bar.
  const ReviewRatingBar({
    required this.stars,
    required this.percentage,
    required this.count,
    super.key,
  });

  /// Number of stars (1-5).
  final int stars;

  /// Percentage of total reviews (0.0 - 1.0).
  final double percentage;

  /// Total count of reviews for this rating.
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$stars', style: AppTypography.labelSmall),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.gameBrown.withOpacityValue(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.gameGold,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 24,
            child: Text(
              '$count',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A standard card for displaying user reviews.
class ReviewCard extends StatelessWidget {
  /// Creates a review card.
  const ReviewCard({
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
    super.key,
  });

  /// Name of the reviewer.
  final String name;

  /// Numerical rating (0-5).
  final double rating;

  /// Content of the review.
  final String comment;

  /// A secondary label, usually the date or the user's role.
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: AppTypography.labelMedium,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTypography.titleSmall),
                    Text(
                      date,
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
                    i < rating ? Icons.star : Icons.star_border,
                    color: AppColors.gameGold,
                    size: 14,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(comment, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}
