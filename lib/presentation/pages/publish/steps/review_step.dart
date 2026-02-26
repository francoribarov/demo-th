import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';

/// Final step in the publish flow for reviewing the listing before submission.
class ReviewStep extends StatelessWidget {
  /// Creates a [ReviewStep].
  const ReviewStep({
    required this.gameId,
    required this.description,
    required this.price,
    required this.condition,
    required this.images,
    super.key,
  });

  /// The game ID.
  final String gameId;

  /// The game description.
  final String description;

  /// The price.
  final int price;

  /// The game condition.
  final PublicationCondition? condition;

  /// List of image URLs.
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Revisión', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Revisá que todo esté correcto antes de publicar',
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
        ),
        const SizedBox(height: 24),

        // Preview card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border:
                Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.gameCream,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image,
                    size: 48,
                    color: AppColors.gameBrown,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text('Juego ID: $gameId', style: AppTypography.headlineMedium),
              const SizedBox(height: 8),
              Text(
                description.isEmpty ? 'Sin descripción' : description,
                style: AppTypography.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              if (condition != null)
                _InfoChip(icon: Icons.grade, label: condition!.label),

              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Precio',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.gameBrown.withOpacityValue(0.6),
                        ),
                      ),
                      Text(
                        CurrencyFormatter.formatUYU(price),
                        style: AppTypography.price,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.gameBrown),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.labelSmall),
      ],
    );
  }
}
