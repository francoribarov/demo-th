import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';

/// A card widget to display a publication listing.
class PublicationCard extends StatelessWidget {
  /// Creates a [PublicationCard].
  const PublicationCard({
    required this.publication,
    this.onTap,
    this.onCategoryTap,
    super.key,
  });

  /// The publication to display.
  final PublicationListing publication;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// Callback when the category badge is tapped.
  final VoidCallback? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radius3xl),
          border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacityValue(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with category badge
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: publication.heroImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const ColoredBox(
                      color: AppColors.gameCream,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.gameRust,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const ColoredBox(
                      color: AppColors.gameCream,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.gameBrown,
                      ),
                    ),
                  ),
                ),
                // Category badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: GestureDetector(
                    onTap: onCategoryTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacityValue(0.9),
                        borderRadius: BorderRadius.circular(AppTheme.radius2xl),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacityValue(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        publication.categoryName,
                        style: AppTypography.categoryChip,
                      ),
                    ),
                  ),
                ),
                // Condition badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gameRust.withOpacityValue(0.9),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      publication.conditionLabel,
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    publication.title,
                    style: AppTypography.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Game info row
                  Row(
                    children: [
                      // Players
                      const Icon(
                        Icons.people_outline,
                        size: 16,
                        color: AppColors.gameBrown,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        publication.game.players,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.gameBrown.withOpacityValue(0.8),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Duration
                      const Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: AppColors.gameBrown,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${publication.game.duration} min',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.gameBrown.withOpacityValue(0.8),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        CurrencyFormatter.formatUYU(publication.price),
                        style: AppTypography.price,
                      ),
                      Text(
                        '/día',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.gameBrown.withOpacityValue(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal compact version of PublicationCard for carousels.
class PublicationCardHorizontal extends StatelessWidget {
  /// Creates a [PublicationCardHorizontal].
  const PublicationCardHorizontal({
    required this.publication,
    this.onTap,
    super.key,
  });

  /// The publication to display.
  final PublicationListing publication;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacityValue(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            // Image
            SizedBox(
              width: 100,
              height: double.infinity,
              child: CachedNetworkImage(
                imageUrl: publication.heroImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => const ColoredBox(
                  color: AppColors.gameCream,
                ),
                errorWidget: (context, url, error) => const ColoredBox(
                  color: AppColors.gameCream,
                  child: Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      publication.title,
                      style: AppTypography.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${publication.game.players} • ${publication.game.duration} min',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gameBrown.withOpacityValue(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      CurrencyFormatter.formatUYU(publication.price),
                      style: AppTypography.price.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
