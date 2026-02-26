import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Shared call-to-action tile for media uploads.
class MediaUploadTile extends StatelessWidget {
  /// Creates a [MediaUploadTile].
  const MediaUploadTile({
    required this.onTap,
    required this.title,
    super.key,
    this.height = 200,
    this.subtitle,
    this.icon = Icons.add_photo_alternate_outlined,
    this.isUploading = false,
  });

  final VoidCallback? onTap;
  final String title;
  final String? subtitle;
  final IconData icon;
  final double height;
  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUploading ? null : onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.gameCream.withOpacityValue(0.5),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.3)),
        ),
        child: isUploading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.gameRust),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 48,
                    color: AppColors.gameBrown.withOpacityValue(0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.7),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gameBrown.withOpacityValue(0.5),
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
