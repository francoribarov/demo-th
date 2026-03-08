import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/widgets/molecules/review_widgets.dart';

/// A card showing an overall rating, star row, review count, and per-star
/// breakdown bars.
///
/// Used on game reviews and user profile pages.
class RatingSummaryCard extends StatelessWidget {
  /// Creates a [RatingSummaryCard].
  const RatingSummaryCard({
    required this.rating,
    required this.reviewsCount,
    required this.ratingBreakdown,
    super.key,
    this.backgroundColor,
    this.border,
    this.padding = const EdgeInsets.all(AppTheme.spacingXl),
  });

  /// Overall average rating (0.0–5.0).
  final double rating;

  /// Total number of reviews.
  final int reviewsCount;

  /// Count of reviews per star level (key: 1–5, value: count).
  final Map<int, int> ratingBreakdown;

  /// Container background color. Defaults to [AppColors.gameCream] at 50% opacity.
  final Color? backgroundColor;

  /// Optional border for the container.
  final Border? border;

  /// Internal padding. Defaults to `EdgeInsets.all(20)`.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.gameCream.withOpacityValue(0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: border,
      ),
      child: Row(
        children: [
          // Overall rating column
          Column(
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: AppTypography.displayLarge,
              ),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < rating.floor() ? Icons.star : Icons.star_border,
                    color: AppColors.gameGold,
                    size: 20,
                  );
                }),
              ),
              const SizedBox(height: AppTheme.spacingXs),
              Text(
                '$reviewsCount reseñas',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppTheme.spacing3xl),
          // Per-star breakdown
          Expanded(
            child: Column(
              children: List.generate(5, (i) {
                final stars = 5 - i;
                final count = ratingBreakdown[stars] ?? 0;
                final total = ratingBreakdown.values.fold(0, (s, c) => s + c);
                final percentage = total > 0 ? count / total : 0.0;
                return ReviewRatingBar(
                  stars: stars,
                  percentage: percentage,
                  count: count,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
