import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// A progress indicator showing steps in a wizard flow.
class StepIndicator extends StatelessWidget {
  /// Creates a [StepIndicator].
  const StepIndicator({required this.currentStep, required this.steps, super.key});

  /// The 0-based index of the currently active step.
  final int currentStep;

  /// Labels for each step in the flow.
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: AppColors.gameCream.withOpacityValue(0.5)),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Expanded(
              child: Container(
                height: 2,
                color: index ~/ 2 < currentStep ? AppColors.gameRust : AppColors.gameBrown.withOpacityValue(0.2),
              ),
            );
          }

          final stepIndex = index ~/ 2;
          final isActive = stepIndex <= currentStep;

          return Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isActive ? AppColors.gameRust : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? AppColors.gameRust : AppColors.gameBrown.withOpacityValue(0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                '${stepIndex + 1}',
                style: AppTypography.labelMedium.copyWith(color: isActive ? Colors.white : AppColors.gameBrown),
              ),
            ),
          );
        }),
      ),
    );
  }
}
