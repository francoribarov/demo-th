import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Reusable date picker field with optional clear action.
class DatePickerField extends StatelessWidget {
  /// Creates a [DatePickerField].
  const DatePickerField({
    required this.label,
    required this.onTap,
    super.key,
    this.value,
    this.onClear,
  });

  /// Field label.
  final String label;

  /// Selected value text.
  final String? value;

  /// Called when the field is tapped.
  final VoidCallback onTap;

  /// Called when the clear icon is tapped.
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final canClear = value != null && onClear != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: AppColors.gameBrown.withOpacityValue(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.6),
                  ),
                ),
                if (canClear)
                  IconButton(
                    onPressed: onClear,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(
                      width: 20,
                      height: 20,
                    ),
                    splashRadius: 14,
                    icon: Icon(
                      Icons.close,
                      size: 16,
                      color: AppColors.gameBrown.withOpacityValue(0.4),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? 'Seleccionar',
                    style: AppTypography.bodyMedium.copyWith(
                      color: value != null
                          ? AppColors.gameBrown
                          : AppColors.gameBrown.withOpacityValue(0.5),
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.gameBrown.withOpacityValue(0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
