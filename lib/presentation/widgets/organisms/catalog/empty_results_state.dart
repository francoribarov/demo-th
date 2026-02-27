import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/surface_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/state_feedback_view.dart';

/// View shown when search or filter results are empty.
class EmptyResultsState extends StatelessWidget {
  /// Creates an [EmptyResultsState].
  const EmptyResultsState({
    required this.onChangeDates,
    required this.onClearFilters,
    super.key,
  });

  /// Callback to change search dates.
  final VoidCallback onChangeDates;

  /// Callback to clear all filters.
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing3xl),
        child: SurfaceCard(
          borderRadius: BorderRadius.circular(AppTheme.radius3xl),
          borderColor: AppColors.gameBrown.withOpacityValue(0.4),
          padding: const EdgeInsets.all(AppTheme.spacing3xl),
          child: Semantics(
            label:
                'Sin resultados. No encontramos juegos con estos filtros. Probá cambiar las fechas o borrar algunos filtros.',
            child: StateFeedbackView(
              variant: StateFeedbackVariant.empty,
              padding: EdgeInsets.zero,
              leading: const SizedBox.shrink(),
              title: 'No encontramos juegos con estos filtros.',
              message: 'Probá cambiar las fechas o borrar algunos filtros.',
              primaryActionLabel: 'Cambiá las fechas',
              onPrimaryAction: onChangeDates,
              secondaryActionLabel: 'Borrá filtros',
              onSecondaryAction: onClearFilters,
            ),
          ),
        ),
      ),
    );
  }
}
