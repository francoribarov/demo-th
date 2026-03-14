import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.expand = false,
    super.key,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final disabled = isLoading || onPressed == null;
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style:
          ElevatedButton.styleFrom(
            minimumSize: expand ? const Size(double.infinity, 52) : null,
            disabledBackgroundColor: AppColors.gameBrown.withOpacityValue(0.12),
            disabledForegroundColor: AppColors.gameBrown.withOpacityValue(0.35),
          ).copyWith(
            elevation: WidgetStateProperty.all(
              disabled ? 0 : null,
            ),
          ),
      child: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primaryForeground,
              ),
            )
          : child,
    );
  }
}

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
