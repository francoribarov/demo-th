import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/info_chip.dart';

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
        const SizedBox(height: AppTheme.spacingSm),
        Text(
          'Revisá que todo esté correcto antes de publicar',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing2xl),

        // Preview card
        SurfaceCard(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
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
              const SizedBox(height: AppTheme.spacingLg),

              Text('Juego ID: $gameId', style: AppTypography.headlineMedium),
              const SizedBox(height: AppTheme.spacingSm),
              Text(
                description.isEmpty ? 'Sin descripción' : description,
                style: AppTypography.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppTheme.spacingLg),
              if (condition != null)
                InfoChip(icon: Icons.grade, label: condition!.label),

              const Divider(height: AppTheme.spacing3xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Precio',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textMuted,
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

        const SizedBox(height: AppTheme.spacingScrollBottom),
      ],
    );
  }
}
