import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';

class PriceBreakdownCard extends StatelessWidget {
  const PriceBreakdownCard({
    required this.subtotal,
    required this.days,
    required this.pricePerDay,
    required this.serviceFee,
    required this.deliveryFee,
    required this.foodTotal,
    required this.total,
    super.key,
  });

  final num subtotal;
  final int days;
  final num pricePerDay;
  final num serviceFee;
  final num deliveryFee;
  final num foodTotal;
  final num total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppTheme.spacingLg,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(
          AppTheme.radiusLg,
        ),
        border: Border.all(
          color: AppColors.gameBrown.withOpacityValue(0.1),
        ),
      ),
      child: Column(
        children: [
          _PriceRow(
            label:
                '${CurrencyFormatter.formatUYU(pricePerDay)}'
                '/día × $days '
                '${days == 1 ? 'día' : 'días'}',
            value: subtotal,
          ),
          const SizedBox(
            height: AppTheme.spacingSm,
          ),
          _PriceRow(
            label: 'Tarifa de servicio',
            value: serviceFee,
          ),
          if (deliveryFee > 0) ...[
            const SizedBox(
              height: AppTheme.spacingSm,
            ),
            _PriceRow(
              label: 'Envío a domicilio',
              value: deliveryFee,
            ),
          ],
          if (foodTotal > 0) ...[
            const SizedBox(
              height: AppTheme.spacingSm,
            ),
            _PriceRow(
              label: 'Snacks',
              value: foodTotal,
            ),
          ],
          const Divider(
            height: AppTheme.spacing2xl,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTypography.titleMedium,
              ),
              Text(
                CurrencyFormatter.formatUYU(total),
                style: AppTypography.price,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
  });

  final String label;
  final num value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.gameBrown.withOpacityValue(0.7),
          ),
        ),
        Text(
          CurrencyFormatter.formatUYU(value),
          style: AppTypography.bodyMedium,
        ),
      ],
    );
  }
}
