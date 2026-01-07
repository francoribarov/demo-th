// UI widgets are documented at a higher level; omit per-member docs.
// 

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/widgets/game_atoms.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

/// Game card widget matching the Vite.js prototype GameCard component
class GameCard extends StatelessWidget {
  const GameCard({
    required this.game,
    this.highlightAvailability = false,
    this.startDate,
    this.endDate,
    this.onTap,
    this.onCategoryTap,
    super.key,
  });

  final Game game;
  final bool highlightAvailability;
  final String? startDate;
  final String? endDate;
  final VoidCallback? onTap;
  final VoidCallback? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    final showRangeMessage = highlightAvailability && startDate != null && endDate != null;
    final availableForRange = showRangeMessage ? game.isAvailableFor(startDate, endDate) : null;
    final isAvailableForRange = availableForRange ?? false;
    final rangeInfo = game.getAvailabilityLabel(searchStart: startDate, searchEnd: endDate);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radius3xl),
          border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacityValue(0.05), blurRadius: 10, offset: const Offset(0, 4)),
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
                  aspectRatio: 16 / 10,
                  child: CachedNetworkImage(
                    imageUrl: game.images.isNotEmpty ? game.images.first : '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const ColoredBox(
                      color: AppColors.gameCream,
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.gameRust)),
                    ),
                    errorWidget: (context, url, error) => const ColoredBox(
                      color: AppColors.gameCream,
                      child: Icon(Icons.image_not_supported_outlined, color: AppColors.gameBrown),
                    ),
                  ),
                ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: GestureDetector(
                      onTap: onCategoryTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacityValue(0.9),
                          borderRadius: BorderRadius.circular(AppTheme.radius2xl),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacityValue(0.1), blurRadius: 4)],
                        ),
                        child: Text(
                          game.categories.isNotEmpty ? game.categories.first.name : 'Varios',
                          style: AppTypography.categoryChip,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and rating row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                game.title,
                                style: AppTypography.titleLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                game.description,
                                style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            GameRatingBadge(rating: game.rating),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Game info (players, duration, difficulty)
                    Wrap(
                      spacing: 8,
                      children: [
                        Text(
                          game.players,
                          style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                        ),
                        Text(
                          '•',
                          style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                        ),
                        Text(
                          '${game.duration} min',
                          style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                        ),
                      Text(
                        '•',
                        style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                      ),
                      Text(
                        game.difficulty,
                        style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Price and CTA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GamePriceLabel(price: game.price),
                      Row(
                        children: [
                          Text(
                            'Ver detalles y alquilar',
                            style: AppTypography.labelMedium.copyWith(color: AppColors.gameRust),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right, size: 16, color: AppColors.gameRust),
                        ],
                      ),
                    ],
                  ),

                  // Availability status (when filtering by dates)
                  if (showRangeMessage) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isAvailableForRange ? Colors.green[50] : Colors.red[50],
                        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isAvailableForRange ? Icons.check_circle : Icons.cancel,
                                size: 16,
                                color: isAvailableForRange ? Colors.green[700] : Colors.red[600],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isAvailableForRange ? 'Disponible en tus fechas' : 'No disponible en tus fechas',
                                style: AppTypography.labelMedium.copyWith(
                                  color: isAvailableForRange ? Colors.green[700] : Colors.red[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rangeInfo,
                            style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 8),
                    Text(
                      rangeInfo,
                      style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.6)),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact horizontal game card for carousels
class GameCardHorizontal extends StatelessWidget {
  const GameCardHorizontal({required this.game, this.onTap, super.key});

  final Game game;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.15)),
        ),
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  child: CachedNetworkImage(
                    imageUrl: game.images.isNotEmpty ? game.images.first : '',
                    width: 110,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(
                      width: 110,
                      height: 150,
                      child: ColoredBox(color: AppColors.gameCream),
                    ),
                    errorWidget: (context, url, error) => const SizedBox(
                      width: 110,
                      height: 150,
                      child: ColoredBox(
                        color: AppColors.gameCream,
                        child: Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(game.title, style: AppTypography.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(
                        game.categories.isNotEmpty ? game.categories.first.name : 'Varios',
                        style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: AppColors.gameGold),
                          const SizedBox(width: 4),
                          Text(game.rating.toStringAsFixed(1), style: AppTypography.labelSmall),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              '· ${game.players}',
                              style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.6)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
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
