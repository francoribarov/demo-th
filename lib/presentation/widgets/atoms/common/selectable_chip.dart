import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Visual variants for [SelectableChip].
enum SelectableChipVariant { solid, outline }

/// A reusable tappable chip with selected/unselected states.
class SelectableChip extends StatelessWidget {
  /// Creates a [SelectableChip].
  const SelectableChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
    this.variant = SelectableChipVariant.solid,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  /// Text label shown inside the chip.
  final String label;

  /// Whether the chip is selected.
  final bool isSelected;

  /// Called when the chip is tapped.
  final VoidCallback onTap;

  /// Visual variant for the unselected state.
  final SelectableChipVariant variant;

  /// Internal content padding.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isOutline = variant == SelectableChipVariant.outline;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gameCream : AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radius2xl),
          border: Border.all(
            color: isSelected
                ? AppColors.gameRust
                : isOutline
                ? AppColors.gameBrown.withOpacityValue(0.3)
                : AppColors.gameBrown.withOpacityValue(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected
                ? AppColors.gameBrown
                : AppColors.gameBrown.withOpacityValue(0.7),
          ),
        ),
      ),
    );
  }
}
