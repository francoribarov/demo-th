import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/date_picker_field.dart';

/// A unified date range selector widget for game availability.
/// Used in both Game Details and Rental Confirmation flows.
///
/// This widget is purely presentational: it shows the date picker and calls
/// [onRangeChanged] with the selected range. Validation (minimum duration,
/// availability) is the caller's responsibility (typically a BLoC).
class AvailabilityDateSelector extends StatelessWidget {
  /// Creates an availability date selector.
  const AvailabilityDateSelector({
    required this.publication,
    required this.onRangeChanged,
    this.startDate,
    this.endDate,
    super.key,
  });

  /// The publication whose booked dates are used to disable days in the picker.
  final PublicationListing publication;

  /// Currently selected start date string.
  final String? startDate;

  /// Currently selected end date string.
  final String? endDate;

  /// Callback triggered when the range is selected or cleared.
  final void Function(String? start, String? end) onRangeChanged;

  Future<void> _showRangePicker(BuildContext context) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final booked = _normalizedBookedDates();

    final initialStart = DateTime.tryParse(startDate ?? '');
    final initialEnd = DateTime.tryParse(endDate ?? '');

    DateTimeRange? initialRange;
    if (initialStart != null && initialEnd != null) {
      initialRange = DateTimeRange(start: initialStart, end: initialEnd);
    }

    final lastDate = today.add(const Duration(days: 365));

    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: initialRange,
      firstDate: today,
      lastDate: lastDate,
      locale: const Locale('es', 'UY'),
      helpText: 'Seleccioná el rango (mínimo 3 días)',
      selectableDayPredicate: (day, start, end) {
        if (day.isBefore(today)) return false;
        return !booked.any(
          (range) => !day.isBefore(range.$1) && !day.isAfter(range.$2),
        );
      },
    );

    if (picked != null && context.mounted) {
      onRangeChanged(
        DateFormatter.toIsoString(picked.start),
        DateFormatter.toIsoString(picked.end),
      );
    }
  }

  List<(DateTime, DateTime)> _normalizedBookedDates() {
    return publication.bookedDates
        .map((range) {
          final from = DateTime.tryParse(range.from);
          final to = DateTime.tryParse(range.to);
          if (from == null || to == null) return null;
          return (from, to);
        })
        .whereType<(DateTime, DateTime)>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DatePickerField(
                label: 'Inicio',
                value: startDate,
                onTap: () => _showRangePicker(context),
                onClear: () => onRangeChanged(null, null),
              ),
            ),
            const SizedBox(width: AppTheme.spacingLg),
            Expanded(
              child: DatePickerField(
                label: 'Fin',
                value: endDate,
                onTap: () => _showRangePicker(context),
                onClear: () => onRangeChanged(null, null),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingSm),
        Row(
          children: [
            const Icon(
              Icons.info_outline,
              size: 14,
              color: AppColors.textMuted,
            ),
            const SizedBox(width: AppTheme.spacingXs + 2),
            Text(
              'Alquiler mínimo: 3 días. Sujeto a disponibilidad.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textMuted,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
