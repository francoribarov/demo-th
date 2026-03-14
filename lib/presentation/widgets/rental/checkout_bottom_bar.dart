import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/core/widgets/app_buttons.dart';

class CheckoutBottomBar extends StatelessWidget {
  const CheckoutBottomBar({
    required this.currentStep,
    required this.totalSteps,
    required this.canAdvance,
    required this.isSubmitting,
    required this.onNext,
    required this.onSubmit,
    this.totalPrice,
    super.key,
  });

  final int currentStep;
  final int totalSteps;
  final bool canAdvance;
  final bool isSubmitting;
  final VoidCallback onNext;
  final VoidCallback onSubmit;
  final num? totalPrice;

  bool get _isLastStep => currentStep == totalSteps - 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppTheme.spacingLg,
        right: AppTheme.spacingLg,
        top: AppTheme.spacingMd,
        bottom: MediaQuery.of(context).padding.bottom + AppTheme.spacingMd,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        boxShadow: [
          BoxShadow(
            color: AppColors.foreground.withOpacityValue(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isLastStep && totalPrice != null) ...[
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppTheme.spacingMd,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: AppTypography.titleMedium,
                  ),
                  Text(
                    CurrencyFormatter.formatUYU(
                      totalPrice!,
                    ),
                    style: AppTypography.price.copyWith(
                      color: AppColors.gameRust,
                    ),
                  ),
                ],
              ),
            ),
          ],
          AppPrimaryButton(
            onPressed: canAdvance ? (_isLastStep ? onSubmit : onNext) : null,
            isLoading: isSubmitting,
            expand: true,
            child: Text(
              _isLastStep ? 'Enviar solicitud' : 'Continuar',
            ),
          ),
        ],
      ),
    );
  }
}
