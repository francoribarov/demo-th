import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';

/// Animated linear progress bar for the create-game flow.
///
/// Follows the same pattern as CheckoutProgressBar from the checkout flow.
class CreateGameProgressBar extends StatelessWidget {
  const CreateGameProgressBar({
    required this.currentStep,
    required this.totalSteps,
    super.key,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final progress = (currentStep + 1) / totalSteps;
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    if (reduceMotion) {
      return LinearProgressIndicator(
        value: progress,
        minHeight: 3,
        backgroundColor: AppColors.gameBrown.withOpacityValue(0.1),
        valueColor: const AlwaysStoppedAnimation(AppColors.gameRust),
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return LinearProgressIndicator(
          value: value,
          minHeight: 3,
          backgroundColor: AppColors.gameBrown.withOpacityValue(0.1),
          valueColor: const AlwaysStoppedAnimation(AppColors.gameRust),
        );
      },
    );
  }
}
