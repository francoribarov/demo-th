import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

/// Shared removable photo tile with optional primary badge.
class RemovablePhotoTile extends StatelessWidget {
  /// Creates a [RemovablePhotoTile].
  const RemovablePhotoTile({
    required this.imageUrl,
    required this.onRemove,
    super.key,
    this.isPrimary = false,
    this.primaryLabel = 'Principal',
    this.borderRadius,
  });

  final String imageUrl;
  final VoidCallback onRemove;
  final bool isPrimary;
  final String primaryLabel;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius:
              borderRadius ?? BorderRadius.circular(AppTheme.radiusMd),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => MediaPlaceholder(
              borderRadius:
                  borderRadius ?? BorderRadius.circular(AppTheme.radiusMd),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.shadow.withOpacityValue(0.54),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: AppColors.primaryForeground,
              ),
            ),
          ),
        ),
        if (isPrimary)
          Positioned(
            bottom: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.gameRust,
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Text(
                primaryLabel,
                style: const TextStyle(
                  color: AppColors.primaryForeground,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
