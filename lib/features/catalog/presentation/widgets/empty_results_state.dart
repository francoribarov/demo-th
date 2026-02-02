import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

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
        padding: const EdgeInsets.all(32),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppTheme.radius3xl),
            border:
                Border.all(color: AppColors.gameBrown.withOpacityValue(0.4)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No encontramos juegos con estos filtros.',
                style: AppTypography.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Probá cambiar las fechas o borrar algunos filtros.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onChangeDates,
                child: const Text('Cambiá las fechas'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: onClearFilters,
                child: const Text('Borrá filtros'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
