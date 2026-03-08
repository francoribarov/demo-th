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
    this.backgroundColor,
    this.iconColor,
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

  /// Optional solid background color. Overrides [backgroundOpacity] behavior.
  final Color? backgroundColor;

  /// Optional icon color.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            AppColors.muted.withOpacityValue(backgroundOpacity),
        borderRadius: radius,
      ),
      child: Center(
        child: ExcludeSemantics(
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor ?? AppColors.mutedForeground,
          ),
        ),
      ),
    );
  }
}
