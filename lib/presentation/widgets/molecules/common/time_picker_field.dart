import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Reusable time picker input field.
class TimePickerField extends StatelessWidget {
  /// Creates a [TimePickerField].
  const TimePickerField({
    required this.label,
    required this.onChanged,
    super.key,
    this.value,
    this.hintText = 'Seleccionar',
  });

  final String label;
  final String? value;
  final String hintText;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openTimePicker(context),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 4),
            Text(value ?? hintText, style: AppTypography.bodyMedium),
          ],
        ),
      ),
    );
  }

  Future<void> _openTimePicker(BuildContext context) async {
    final initialTime = _parseTime(value) ?? TimeOfDay.now();

    final selected = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (selected == null) {
      return;
    }

    onChanged(
      '${selected.hour.toString().padLeft(2, '0')}:${selected.minute.toString().padLeft(2, '0')}',
    );
  }

  TimeOfDay? _parseTime(String? source) {
    if (source == null || source.trim().isEmpty) {
      return null;
    }

    final parts = source.split(':');
    if (parts.length != 2) {
      return null;
    }

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) {
      return null;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }
}
