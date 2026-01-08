import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

/// A unified date range selector widget for game availability.
/// Used in both Game Details and Rental Confirmation flows.
class AvailabilityDateSelector extends StatelessWidget {
  /// Creates an availability date selector.
  const AvailabilityDateSelector({
    required this.game,
    required this.onRangeChanged,
    this.startDate,
    this.endDate,
    super.key,
  });

  /// The game whose availability should be respected.
  final Game game;

  /// Currently selected start date string.
  final String? startDate;

  /// Currently selected end date string.
  final String? endDate;

  /// Callback triggered when the range is selected or cleared.
  final void Function(String? start, String? end) onRangeChanged;

  Future<void> _showRangePicker(BuildContext context) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final ranges = _normalizedRanges();

    final initialStart = DateTime.tryParse(startDate ?? '');
    final initialEnd = DateTime.tryParse(endDate ?? '');

    DateTimeRange? initialRange;
    if (initialStart != null && initialEnd != null) {
      initialRange = DateTimeRange(start: initialStart, end: initialEnd);
    }

    final firstDate = today;
    final lastDate = ranges.isNotEmpty ? ranges.last.$2 : today.add(const Duration(days: 365));

    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: initialRange,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('es', 'UY'),
      helpText: 'Seleccioná el rango (mínimo 3 días)',
      selectableDayPredicate: (day, start, end) {
        if (day.isBefore(today)) return false;
        if (ranges.isEmpty) return true;
        // Day must be in at least one available range
        return ranges.any(
          (range) => !day.isBefore(range.$1) && !day.isAfter(range.$2),
        );
      },
    );

    if (picked != null) {
      final startStr = DateFormatter.toIsoString(picked.start);
      final endStr = DateFormatter.toIsoString(picked.end);

      final duration = picked.end.difference(picked.start).inDays + 1;
      if (duration < 3) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('El alquiler mínimo es de 3 días.'),
              backgroundColor: AppColors.gameRust,
            ),
          );
        }
        return;
      }

      if (!game.isAvailableFor(startStr, endStr)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('El rango seleccionado contiene días no disponibles.'),
              backgroundColor: AppColors.gameRust,
            ),
          );
        }
        return;
      }

      onRangeChanged(startStr, endStr);
    }
  }

  List<(DateTime, DateTime)> _normalizedRanges() {
    final ranges = game.availability;
    if (ranges == null || ranges.isEmpty) return const [];

    return ranges
        .map((range) {
          final from = DateTime.tryParse(range.from);
          final to = DateTime.tryParse(range.to);
          if (from == null || to == null) return null;
          return (from, to);
        })
        .whereType<(DateTime, DateTime)>()
        .toList()
      ..sort((a, b) => a.$1.compareTo(b.$1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _DateButton(
                label: 'Inicio',
                value: startDate,
                onTap: () => _showRangePicker(context),
                onClear: () => onRangeChanged(null, null),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _DateButton(
                label: 'Fin',
                value: endDate,
                onTap: () => _showRangePicker(context),
                onClear: () => onRangeChanged(null, null),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 14,
              color: AppColors.gameBrown.withOpacityValue(0.6),
            ),
            const SizedBox(width: 6),
            Text(
              'Alquiler mínimo: 3 días. Sujeto a disponibilidad.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.6),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DateButton extends StatelessWidget {
  const _DateButton({
    required this.label,
    required this.onTap,
    required this.onClear,
    this.value,
  });
  final String label;
  final String? value;
  final VoidCallback onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.2)),
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
                if (value != null)
                  GestureDetector(
                    onTap: onClear,
                    child: Icon(
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
                      color: value != null ? AppColors.gameBrown : AppColors.gameBrown.withOpacityValue(0.5),
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
