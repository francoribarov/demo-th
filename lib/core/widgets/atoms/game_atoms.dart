import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';

/// A consistent badge for showing game ratings.
class GameRatingBadge extends StatelessWidget {
  /// Creates a rating badge.
  const GameRatingBadge({required this.rating, this.reviewCount, super.key});

  /// The rating value (0-5).
  final double rating;

  /// Optional review count to display next to the rating.
  final int? reviewCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, color: AppColors.gameGold, size: 16),
        const SizedBox(width: AppTheme.spacingXs),
        Text(rating.toStringAsFixed(1), style: AppTypography.labelLarge),
        if (reviewCount != null) ...[
          const SizedBox(width: AppTheme.spacingXs),
          Text(
            '($reviewCount)',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}

/// A consistent label for showing prices. Generic atom; domain copy is passed via [leadingLabel] and [perUnit].
class GamePriceLabel extends StatelessWidget {
  /// Creates a price label.
  const GamePriceLabel({
    required this.price,
    this.leadingLabel = 'Desde',
    this.perUnit = '/ día',
    super.key,
  });

  /// The price value.
  final num price;

  /// Leading label above the price (e.g., "Desde" for rental).
  final String leadingLabel;

  /// The unit of the price (e.g., '/ día').
  final String perUnit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          leadingLabel,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textMuted,
            letterSpacing: 1,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              CurrencyFormatter.formatUYU(price),
              style: AppTypography.price,
            ),
            const SizedBox(width: AppTheme.spacingXs),
            Text(
              perUnit,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
