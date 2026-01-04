import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/filters.dart';

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
    required this.onSortChanged,
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

  /// Callback when the sort option changes.
  final void Function(SortOption) onSortChanged;

  /// Callback to open the date picker.
  final VoidCallback onOpenDates;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              const SizedBox(width: 12),
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
                        const SizedBox(width: 8),
                        Text(
                          '$count ${count == 1 ? 'juego' : 'juegos'}',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.gameBrown.withOpacityValue(0.6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (hasDateFilter)
                      Text(
                        'Ordenamos primero los disponibles en tus fechas.',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.gameBrown.withOpacityValue(0.7),
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

          const SizedBox(height: 16),

          // Filter/sort row
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onOpenFilters,
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: Text(
                    filters.hasActiveFilters
                        ? 'Filtros (${filters.activeFiltersCount})'
                        : 'Filtros',
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: filters.hasActiveFilters
                        ? AppColors.gameRust
                        : AppColors.gameBrown,
                    side: BorderSide(
                      color: filters.hasActiveFilters
                          ? AppColors.gameRust
                          : AppColors.gameBrown.withOpacityValue(0.2),
                    ),
                    backgroundColor: AppColors.card,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _showSortMenu(context),
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

  void _showSortMenu(BuildContext context) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: SortOption.values.map((option) {
              return ListTile(
                leading: sortOption == option
                    ? const Icon(Icons.check, color: AppColors.gameRust)
                    : const SizedBox(width: 24),
                title: Text(option.label),
                onTap: () {
                  onSortChanged(option);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
