import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';

class DateSummaryCard extends StatelessWidget {
  const DateSummaryCard({
    required this.startDate,
    required this.endDate,
    required this.rentalDays,
    required this.pricePerDay,
    required this.subtotal,
    super.key,
  });

  final String startDate;
  final String endDate;
  final int rentalDays;
  final num pricePerDay;
  final num subtotal;

  @override
  Widget build(BuildContext context) {
    final start = DateFormatter.parseIso(startDate);
    final end = DateFormatter.parseIso(endDate);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gameCream.withOpacityValue(0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gameRust.withOpacityValue(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.date_range, color: AppColors.gameRust, size: 20),
              const SizedBox(width: 10),
              Text(
                '$rentalDays días',
                style: AppTypography.titleMedium
                    .copyWith(color: AppColors.gameRust),
              ),
            ],
          ),
          if (start != null && end != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 30),
                Expanded(
                  child: Text(
                    '${DateFormatter.formatFullDate(start)} → ${DateFormatter.formatFullDate(end)}',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${CurrencyFormatter.formatUYU(pricePerDay)}/día × $rentalDays días',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.7),
                ),
              ),
              Text(
                CurrencyFormatter.formatUYU(subtotal),
                style: AppTypography.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
