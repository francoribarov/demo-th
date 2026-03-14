import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Visual variants for [SelectableChip].
enum SelectableChipVariant {
  /// Default chip with solid fill when unselected.
  solid,

  /// Chip with outline border when unselected.
  outline,

  /// Gold-accent chip for search shortcuts (icon optional).
  suggestion,
}

/// A reusable tappable chip with selected/unselected or suggestion styles.
class SelectableChip extends StatelessWidget {
  /// Creates a [SelectableChip].
  const SelectableChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
    this.variant = SelectableChipVariant.solid,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppTheme.spacingLg,
      vertical: AppTheme.spacingSm,
    ),
    this.icon,
  });

  /// Text label shown inside the chip.
  final String label;

  /// Whether the chip is selected. Ignored when [variant] is [SelectableChipVariant.suggestion].
  final bool isSelected;

  /// Called when the chip is tapped.
  final VoidCallback onTap;

  /// Visual variant.
  final SelectableChipVariant variant;

  /// Internal content padding.
  final EdgeInsetsGeometry padding;

  /// Optional leading icon. Used with [SelectableChipVariant.suggestion].
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isSuggestion = variant == SelectableChipVariant.suggestion;
    final isOutline = variant == SelectableChipVariant.outline && !isSuggestion;

    Color color;
    Color borderColor;
    double borderWidth;
    TextStyle textStyle;

    if (isSuggestion) {
      color = AppColors.gameCream;
      borderColor = AppColors.goldBorder;
      borderWidth = 1;
      textStyle = AppTypography.labelSmall;
    } else if (isSelected) {
      color = AppColors.gameCream;
      borderColor = AppColors.gameRust;
      borderWidth = 2;
      textStyle = AppTypography.labelMedium.copyWith(
        color: AppColors.gameBrown,
      );
    } else {
      color = AppColors.card;
      borderColor = isOutline
          ? AppColors.gameBrown.withOpacityValue(0.3)
          : AppColors.gameBrown.withOpacityValue(0.2);
      borderWidth = 1;
      textStyle = AppTypography.labelMedium.copyWith(
        color: AppColors.textTertiary,
      );
    }

    final contentPadding = isSuggestion
        ? const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMd,
            vertical: AppTheme.spacingSm,
          )
        : padding;

    final radius = BorderRadius.circular(AppTheme.radius2xl);

    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: borderColor, width: borderWidth),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: contentPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 14,
                    color: isSuggestion ? AppColors.gameGold : null,
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                ],
                Text(label, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
