import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/app_secondary_button.dart';

/// Header for the search results view.
class ResultsHeader extends StatelessWidget {
  /// Creates a [ResultsHeader].
  const ResultsHeader({
    required this.title,
    required this.count,
    required this.hasDateFilter,
    required this.filters,
    required this.sortOption,
    required this.onBack,
    required this.onOpenFilters,
    required this.onSortTap,
    required this.onOpenDates,
    super.key,
  });

  /// Title of the results view.
  final String title;

  /// Number of results found.
  final int count;

  /// Whether a date filter is active.
  final bool hasDateFilter;

  /// Current filters state.
  final FiltersState filters;

  /// Current sort option.
  final SortOption sortOption;

  /// Callback to go back (clear search).
  final VoidCallback onBack;

  /// Callback to open the filters sheet.
  final VoidCallback onOpenFilters;

  /// Callback when the sort button is tapped (parent shows sort menu).
  final VoidCallback onSortTap;

  /// Callback to open the date picker.
  final VoidCallback onOpenDates;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.card,
                  side: BorderSide(
                    color: AppColors.gameBrown.withOpacityValue(0.3),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: AppTypography.headlineMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacingSm),
                        Text(
                          '$count ${count == 1 ? 'juego' : 'juegos'}',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingXs),
                    if (hasDateFilter)
                      Text(
                        'Ordenamos primero los disponibles en tus fechas.',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: onOpenDates,
                        child: Text(
                          'Agregá fechas para ver disponibilidad exacta',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.destructive,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dotted,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingLg),

          // Filter/sort row
          Row(
            children: [
              Expanded(
                child: AppSecondaryButton(
                  label: filters.hasActiveFilters ? 'Filtros (${filters.activeFiltersCount})' : 'Filtros',
                  icon: Icons.filter_list,
                  onPressed: onOpenFilters,
                ),
              ),
              const SizedBox(width: AppTheme.spacingSm),
              IconButton(
                onPressed: onSortTap,
                icon: const Icon(Icons.swap_vert),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.card,
                  side: BorderSide(
                    color: sortOption != SortOption.availability
                        ? AppColors.gameRust
                        : AppColors.gameBrown.withOpacityValue(0.2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
