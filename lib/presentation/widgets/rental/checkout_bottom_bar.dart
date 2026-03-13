import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

class CheckoutBottomBar extends StatelessWidget {
  const CheckoutBottomBar({
    required this.currentStep,
    required this.totalSteps,
    required this.canAdvance,
    required this.isSubmitting,
    required this.onNext,
    required this.onBack,
    required this.onSubmit,
    this.errorMessage,
    super.key,
  });

  final int currentStep;
  final int totalSteps;
  final bool canAdvance;
  final bool isSubmitting;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final String? errorMessage;

  bool get _isLastStep => currentStep == totalSteps - 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacityValue(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (errorMessage != null) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                errorMessage!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.destructive,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          Row(
            children: [
              if (currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: onBack,
                    child: const Text('Atrás'),
                  ),
                ),
              if (currentStep > 0) const SizedBox(width: 12),
              Expanded(
                flex: currentStep > 0 ? 2 : 1,
                child: ElevatedButton(
                  onPressed: (canAdvance && !isSubmitting)
                      ? (_isLastStep ? onSubmit : onNext)
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    disabledBackgroundColor:
                        AppColors.gameBrown.withOpacityValue(0.12),
                    disabledForegroundColor:
                        AppColors.gameBrown.withOpacityValue(0.35),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(_isLastStep ? 'Enviar solicitud' : 'Continuar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
