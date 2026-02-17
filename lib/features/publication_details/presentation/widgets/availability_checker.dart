import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/availability_date_selector.dart';

/// Widget to check game availability for a date range.
class AvailabilityChecker extends StatelessWidget {
  /// Creates an [AvailabilityChecker].
  const AvailabilityChecker({
    required this.publication,
    required this.onRangeSelected,
    required this.onCheck,
    required this.startDate,
    required this.endDate,
    this.result,
    super.key,
  });

  /// The publication to check availability for.
  final PublicationListing publication;

  /// Start date in ISO string format.
  final String startDate;

  /// End date in ISO string format.
  final String endDate;

  /// Result of the availability check.
  final bool? result;

  /// Callback when a date range is selected.
  final void Function(String?, String?) onRangeSelected;

  /// Callback when the check button is pressed.
  final VoidCallback onCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gameCream.withOpacityValue(0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.event_available, color: AppColors.gameRust),
              const SizedBox(width: 8),
              Text('Consultá disponibilidad', style: AppTypography.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          AvailabilityDateSelector(
            publication: publication,
            startDate: startDate,
            endDate: endDate,
            onRangeChanged: onRangeSelected,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onCheck,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Verificar disponibilidad'),
          ),
          if (result != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: result! ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    result! ? Icons.check_circle : Icons.cancel,
                    color: result! ? Colors.green[700] : Colors.red[600],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      result!
                          ? '¡Disponible para esas fechas!'
                          : 'No disponible para esas fechas',
                      style: AppTypography.bodyMedium.copyWith(
                        color: result! ? Colors.green[700] : Colors.red[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
