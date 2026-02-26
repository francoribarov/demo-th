import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/state_feedback_view.dart';

class MyPublicationsErrorView extends StatelessWidget {
  const MyPublicationsErrorView({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return StateFeedbackView(
      variant: StateFeedbackVariant.error,
      leading: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacityValue(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.error_outline,
          size: 48,
          color: AppColors.error,
        ),
      ),
      title: 'Oops! Algo salió mal',
      message: message,
      titleStyle: AppTypography.titleLarge.copyWith(
        color: AppColors.foreground,
      ),
      messageStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.mutedForeground,
      ),
      primaryActionLabel: 'Reintentar',
      onPrimaryAction: onRetry,
      primaryActionStyle: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gameRust,
        foregroundColor: AppColors.primaryForeground,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
      ),
    );
  }
}
