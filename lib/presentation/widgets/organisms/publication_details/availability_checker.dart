import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/app_primary_button.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/surface_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/rental/availability_date_selector.dart';

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
    return SurfaceCard(
      variant: SurfaceCardVariant.subtle,
      borderColor: AppColors.gameBrown.withOpacityValue(0.1),
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.event_available, color: AppColors.gameRust),
              const SizedBox(width: AppTheme.spacingSm),
              Text('Consultá disponibilidad', style: AppTypography.titleMedium),
            ],
          ),
          const SizedBox(height: AppTheme.spacingLg),
          AvailabilityDateSelector(
            publication: publication,
            startDate: startDate,
            endDate: endDate,
            onRangeChanged: onRangeSelected,
          ),
          const SizedBox(height: AppTheme.spacingMd),
          AppPrimaryButton(
            label: 'Verificar disponibilidad',
            onPressed: onCheck,
            minimumSize: const Size(double.infinity, 48),
          ),
          if (result != null) ...[
            const SizedBox(height: AppTheme.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: BoxDecoration(
                color: result! ? AppColors.successSurface : AppColors.errorSurface,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    result! ? Icons.check_circle : Icons.cancel,
                    color: result! ? AppColors.gameSage : AppColors.destructive,
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  Expanded(
                    child: Text(
                      result! ? '¡Disponible para esas fechas!' : 'No disponible para esas fechas',
                      style: AppTypography.bodyMedium.copyWith(
                        color: result! ? AppColors.gameSage : AppColors.destructive,
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
