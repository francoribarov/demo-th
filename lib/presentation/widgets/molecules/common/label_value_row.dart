import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Shared label/value row with optional leading icon.
class LabelValueRow extends StatelessWidget {
  /// Creates a [LabelValueRow].
  const LabelValueRow({
    required this.label,
    required this.value,
    super.key,
    this.leadingIcon,
    this.labelStyle,
    this.valueStyle,
    this.labelColor,
    this.valueColor,
    this.iconColor,
    this.iconSize = 20,
    this.spacing = 12,
  });

  final String label;
  final String value;
  final IconData? leadingIcon;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final Color? labelColor;
  final Color? valueColor;
  final Color? iconColor;
  final double iconSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leadingIcon != null) ...[
          Icon(
            leadingIcon,
            size: iconSize,
            color: iconColor ?? AppColors.mutedForeground,
          ),
          SizedBox(width: spacing),
        ],
        Text(
          label,
          style:
              labelStyle ??
              AppTypography.bodyMedium.copyWith(
                color: labelColor ?? AppColors.mutedForeground,
              ),
        ),
        const Spacer(),
        Text(
          value,
          style:
              valueStyle ??
              AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: valueColor ?? AppColors.foreground,
              ),
        ),
      ],
    );
  }
}
