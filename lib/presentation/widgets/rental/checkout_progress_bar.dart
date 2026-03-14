import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';

class CheckoutProgressBar extends StatelessWidget {
  const CheckoutProgressBar({
    required this.currentStep,
    required this.totalSteps,
    super.key,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0,
        end: (currentStep + 1) / totalSteps,
      ),
      duration:
          const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return LinearProgressIndicator(
          value: value,
          minHeight: 3,
          backgroundColor: AppColors.gameBrown
              .withOpacityValue(0.1),
          valueColor:
              const AlwaysStoppedAnimation(
            AppColors.gameRust,
          ),
        );
      },
    );
  }
}
