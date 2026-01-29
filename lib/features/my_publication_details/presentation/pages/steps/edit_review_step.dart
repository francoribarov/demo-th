import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

/// Final review step before submitting publication changes.
class EditReviewStep extends StatelessWidget {
  /// Creates the edit review step.
  const EditReviewStep({
    required this.description,
    required this.price,
    required this.condition,
    required this.images,
    required this.conditions,
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
  final String condition;

  /// Images list.
  final List<String> images;

  /// Condition options for display.
  final List<(String, String, String)> conditions;

  String get _conditionLabel {
    final found = conditions.where((c) => c.$1 == condition);
    return found.isNotEmpty ? found.first.$2 : condition;
  }

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
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacityValue(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image
              ClipRRect(
                borderRadius: BorderRadius.vertical(
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
                    _InfoRow(
                      icon: Icons.sell_outlined,
                      label: 'Precio por día',
                      value: '\$$price UYU',
                      valueColor: AppColors.gameRust,
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(
                      icon: Icons.star_outline,
                      label: 'Condición',
                      value: _conditionLabel,
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(
                      icon: Icons.photo_library_outlined,
                      label: 'Fotos',
                      value:
                          '${images.length} imagen${images.length != 1 ? 'es' : ''}',
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
              separatorBuilder: (_, __) => const SizedBox(width: 8),
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
      return Container(
        color: AppColors.muted.withOpacityValue(0.2),
        child: Center(
          child: Icon(
            Icons.image_outlined,
            size: 48,
            color: AppColors.mutedForeground,
          ),
        ),
      );
    }

    final heroUrl = images.first;
    if (heroUrl.startsWith('http')) {
      return Image.network(
        heroUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _ImagePlaceholder(),
      );
    } else {
      return Image.file(
        File(heroUrl),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _ImagePlaceholder(),
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
        errorBuilder: (_, __, ___) => _SmallPlaceholder(),
      );
    } else {
      return Image.file(
        File(imageUrl),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _SmallPlaceholder(),
      );
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.mutedForeground,
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.mutedForeground,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.foreground,
          ),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.muted.withOpacityValue(0.2),
      child: Center(
        child: Icon(
          Icons.broken_image,
          size: 48,
          color: AppColors.mutedForeground,
        ),
      ),
    );
  }
}

class _SmallPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      color: AppColors.muted.withOpacityValue(0.2),
      child: Icon(
        Icons.broken_image,
        color: AppColors.mutedForeground,
      ),
    );
  }
}
