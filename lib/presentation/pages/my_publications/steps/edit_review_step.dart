import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/media_placeholder.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/surface_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/label_value_row.dart';

/// Final review step before submitting publication changes.
class EditReviewStep extends StatelessWidget {
  /// Creates the edit review step.
  const EditReviewStep({
    required this.description,
    required this.price,
    required this.condition,
    required this.images,
    this.selectedGame,
    super.key,
  });

  /// Selected game.
  final Game? selectedGame;

  /// Description.
  final String description;

  /// Price.
  final int price;

  /// Condition value.
  final PublicationCondition? condition;

  /// Images list.
  final List<String> images;

  String get _conditionLabel => condition?.label ?? '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Revisa tu publicación',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Verifica que toda la información sea correcta antes de guardar.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.mutedForeground,
          ),
        ),
        const SizedBox(height: 24),

        // Preview card
        SurfaceCard(
          borderColor: AppColors.border,
          boxShadow: AppTheme.shadowMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusLg),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _buildHeroImage(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Game title
                    if (selectedGame != null)
                      Text(
                        selectedGame!.title,
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 16),

                    // Info rows
                    LabelValueRow(
                      leadingIcon: Icons.sell_outlined,
                      label: 'Precio por día',
                      value: '\$$price UYU',
                      valueColor: AppColors.gameRust,
                    ),
                    const SizedBox(height: 12),
                    LabelValueRow(
                      leadingIcon: Icons.star_outline,
                      label: 'Condición',
                      value: _conditionLabel,
                    ),
                    const SizedBox(height: 12),
                    LabelValueRow(
                      leadingIcon: Icons.photo_library_outlined,
                      label: 'Fotos',
                      value: '${images.length} imagen${images.length != 1 ? 'es' : ''}',
                    ),

                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        'Descripción',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.mutedForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: AppTypography.bodyMedium,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Image thumbnails
        if (images.length > 1) ...[
          Text(
            'Galería de fotos',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.mutedForeground,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                child: _buildThumbnail(images[index]),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHeroImage() {
    if (images.isEmpty) {
      return const MediaPlaceholder(
        icon: Icons.image_outlined,
        iconSize: 48,
      );
    }

    final heroUrl = images.first;
    if (heroUrl.startsWith('http')) {
      return Image.network(
        heroUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, error, stackTrace) => const MediaPlaceholder(iconSize: 48),
      );
    } else {
      return Image.file(
        File(heroUrl),
        fit: BoxFit.cover,
        errorBuilder: (_, error, stackTrace) => const MediaPlaceholder(iconSize: 48),
      );
    }
  }

  Widget _buildThumbnail(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (_, error, stackTrace) => const MediaPlaceholder(),
      );
    } else {
      return Image.file(
        File(imageUrl),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (_, error, stackTrace) => const MediaPlaceholder(),
      );
    }
  }
}
