import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';

/// Compact running total shown on intermediate
/// checkout steps so the user always knows what
/// they're paying for.
class CheckoutOrderSummary extends StatelessWidget {
  const CheckoutOrderSummary({
    required this.state,
    super.key,
  });

  final RentalState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppTheme.spacingLg,
      ),
      decoration: BoxDecoration(
        color: AppColors.gameCream
            .withOpacityValue(0.35),
        borderRadius: BorderRadius.circular(
          AppTheme.radiusLg,
        ),
      ),
      child: Column(
        children: [
          if (state.startDate != null &&
              state.endDate != null)
            _row(
              '${CurrencyFormatter.formatUYU(
                state.publication?.price ?? 0,
              )}/día × ${state.rentalDays} '
              '${state.rentalDays == 1 ? 'día' : 'días'}',
              CurrencyFormatter.formatUYU(
                state.subtotal,
              ),
            ),
          if (state.serviceFee > 0) ...[
            const SizedBox(
              height: AppTheme.spacingXs,
            ),
            _row(
              'Tarifa de servicio',
              CurrencyFormatter.formatUYU(
                state.serviceFee,
              ),
            ),
          ],
          if (state.foodTotal > 0) ...[
            const SizedBox(
              height: AppTheme.spacingXs,
            ),
            _row(
              'Snacks',
              CurrencyFormatter.formatUYU(
                state.foodTotal,
              ),
            ),
          ],
          const Divider(
            height: AppTheme.spacingXl,
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: AppTypography.titleSmall,
              ),
              Text(
                CurrencyFormatter.formatUYU(
                  state.total,
                ),
                style:
                    AppTypography.titleSmall.copyWith(
                  color: AppColors.gameRust,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              AppTypography.bodySmall.copyWith(
            color: AppColors.gameBrown
                .withOpacityValue(0.6),
          ),
        ),
        Text(
          value,
          style: AppTypography.bodySmall,
        ),
      ],
    );
  }
}
