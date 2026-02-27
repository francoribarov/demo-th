import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    required this.onTap,
    this.query,
    this.startDate,
    this.endDate,
    this.selectedCategory,
    super.key,
  });

  final String? query;
  final String? startDate;
  final String? endDate;
  final String? selectedCategory;
  final VoidCallback onTap;

  String get _dateLabel {
    if (startDate != null && endDate != null) {
      return DateFormatter.formatRange(startDate!, endDate!);
    }
    return 'Fechas flexibles';
  }

  String get _querySummary {
    if (selectedCategory != null) return selectedCategory!;
    if (query != null && query!.trim().isNotEmpty) return '"$query"';
    return '';
  }

  String get _pillSecondaryText {
    final parts = <String>[];
    if (_querySummary.isNotEmpty) parts.add(_querySummary);
    parts.add(_dateLabel);
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.card,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + AppTheme.spacingLg,
        bottom: AppTheme.spacingLg,
        left: AppTheme.spacingLg,
        right: AppTheme.spacingLg,
      ),
      child: Row(
        children: [
          // Logo
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            child: Image.asset(
              'assets/images/dice_logo.png',
              height: 40,
              width: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.gameRust,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: const Icon(
                  Icons.casino,
                  color: AppColors.primaryForeground,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),

          // Search pill
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg,
                  vertical: AppTheme.spacingMd,
                ),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(AppTheme.radius3xl),
                  border: Border.all(
                    color: AppColors.gameBrown.withOpacityValue(0.2),
                  ),
                  boxShadow: AppTheme.shadowSm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Buscá un juego de mesa',
                            style: AppTypography.labelLarge,
                          ),
                          const SizedBox(height: AppTheme.spacingXs / 2),
                          Text(
                            _pillSecondaryText,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textTertiary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppColors.gameRust,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: AppColors.primaryForeground,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
