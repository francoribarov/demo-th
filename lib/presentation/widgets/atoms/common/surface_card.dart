import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';

/// Visual variants for [SurfaceCard].
enum SurfaceCardVariant {
  /// Neutral card background.
  base,

  /// Soft cream background for highlighted info.
  subtle,

  /// Highlighted card with stronger border emphasis.
  highlight,
}

/// Shared card surface wrapper used by templates and organisms.
class SurfaceCard extends StatelessWidget {
  /// Creates a [SurfaceCard].
  const SurfaceCard({
    required this.child,
    super.key,
    this.variant = SurfaceCardVariant.base,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
  });

  final Widget child;
  final SurfaceCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final resolvedBackground = switch (variant) {
      SurfaceCardVariant.base => AppColors.card,
      SurfaceCardVariant.subtle => AppColors.gameCream.withOpacityValue(0.5),
      SurfaceCardVariant.highlight => AppColors.gameCream,
    };

    final resolvedBorder = switch (variant) {
      SurfaceCardVariant.base => AppColors.gameBrown.withOpacityValue(0.1),
      SurfaceCardVariant.subtle => AppColors.gameBrown.withOpacityValue(0.2),
      SurfaceCardVariant.highlight => AppColors.gameGold.withOpacityValue(0.3),
    };

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? resolvedBackground,
        borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: borderColor ?? resolvedBorder,
          width: borderWidth ?? 1,
        ),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
