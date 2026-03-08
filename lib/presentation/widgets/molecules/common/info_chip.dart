import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Layout variants for [InfoChip].
enum InfoChipLayout {
  /// Icon and label arranged horizontally.
  row,

  /// Icon and label arranged vertically.
  column,
}

/// Shared icon + label info chip.
class InfoChip extends StatelessWidget {
  /// Creates an [InfoChip].
  const InfoChip({
    required this.icon,
    required this.label,
    super.key,
    this.layout = InfoChipLayout.row,
    this.iconColor = AppColors.gameBrown,
    this.iconSize,
    this.gap = 4,
    this.textStyle,
  });

  final IconData icon;
  final String label;
  final InfoChipLayout layout;
  final Color iconColor;
  final double? iconSize;
  final double gap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final labelWidget = Text(
      label,
      style: textStyle ?? AppTypography.labelSmall,
    );

    if (layout == InfoChipLayout.column) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: iconSize),
          SizedBox(height: gap),
          labelWidget,
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: iconSize),
        SizedBox(width: gap),
        labelWidget,
      ],
    );
  }
}
