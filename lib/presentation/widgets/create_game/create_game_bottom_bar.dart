import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

/// Bottom action bar for the create-game flow.
///
/// Shows a single primary button ("Continuar" or "Crear juego").
/// Follows the same pattern as CheckoutBottomBar from the checkout flow.
class CreateGameBottomBar extends StatelessWidget {
  const CreateGameBottomBar({
    required this.currentStep,
    required this.totalSteps,
    required this.canAdvance,
    required this.isSubmitting,
    required this.onNext,
    required this.onSubmit,
    super.key,
  });

  final int currentStep;
  final int totalSteps;
  final bool canAdvance;
  final bool isSubmitting;
  final VoidCallback onNext;
  final VoidCallback onSubmit;

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
      child: AppPrimaryButton(
        onPressed: canAdvance ? (_isLastStep ? onSubmit : onNext) : null,
        isLoading: isSubmitting,
        label: _isLastStep ? 'Crear juego' : 'Continuar',
        minimumSize: const Size(double.infinity, 52),
      ),
    );
  }
}
