import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

class CheckoutStepIndicator extends StatelessWidget {
  const CheckoutStepIndicator({
    required this.currentStep,
    required this.totalSteps,
    required this.labels,
    required this.icons,
    required this.onStepTapped,
    super.key,
  });

  final int currentStep;
  final int totalSteps;
  final List<String> labels;
  final List<IconData> icons;
  final ValueChanged<int> onStepTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(
          bottom: BorderSide(
            color: AppColors.gameBrown.withOpacityValue(0.1),
          ),
        ),
      ),
      child: Row(
        children: List.generate(totalSteps * 2 - 1, (index) {
          if (index.isOdd) {
            return _buildConnector(index ~/ 2);
          }
          return _buildStepDot(index ~/ 2);
        }),
      ),
    );
  }

  Widget _buildConnector(int stepBefore) {
    final isCompleted = stepBefore < currentStep;
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        color: isCompleted
            ? AppColors.gameRust
            : AppColors.gameBrown.withOpacityValue(0.15),
      ),
    );
  }

  Widget _buildStepDot(int step) {
    final isActive = step == currentStep;
    final isCompleted = step < currentStep;
    return GestureDetector(
      onTap: () => onStepTapped(step),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.gameRust
                  : isActive
                      ? AppColors.gameRust.withOpacityValue(0.12)
                      : AppColors.gameBrown.withOpacityValue(0.06),
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive || isCompleted
                    ? AppColors.gameRust
                    : AppColors.gameBrown.withOpacityValue(0.15),
                width: isActive ? 2 : 1,
              ),
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : Icon(
                      icons[step],
                      size: 16,
                      color: isActive
                          ? AppColors.gameRust
                          : AppColors.gameBrown.withOpacityValue(0.4),
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            labels[step],
            style: AppTypography.labelSmall.copyWith(
              color: isActive || isCompleted
                  ? AppColors.gameRust
                  : AppColors.gameBrown.withOpacityValue(0.4),
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
