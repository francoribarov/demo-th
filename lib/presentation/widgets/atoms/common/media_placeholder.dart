import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';

/// Generic placeholder for missing or broken media.
class MediaPlaceholder extends StatelessWidget {
  /// Creates a [MediaPlaceholder].
  const MediaPlaceholder({
    this.icon = Icons.broken_image,
    this.iconSize,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundOpacity = 0.2,
    super.key,
  });

  /// Icon shown in the placeholder.
  final IconData icon;

  /// Optional icon size.
  final double? iconSize;

  /// Optional width constraint.
  final double? width;

  /// Optional height constraint.
  final double? height;

  /// Optional border radius.
  final BorderRadiusGeometry? borderRadius;

  /// Placeholder background opacity over [AppColors.muted].
  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.muted.withOpacityValue(backgroundOpacity),
        borderRadius: radius,
      ),
      child: Center(
        child: ExcludeSemantics(
          child: Icon(
            icon,
            size: iconSize,
            color: AppColors.mutedForeground,
          ),
        ),
      ),
    );
  }
}
