import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';

/// Inline prompt + tappable action for switching between login and register.
class AuthSwitchRow extends StatelessWidget {
  /// Creates an auth switch row.
  const AuthSwitchRow({
    required this.prompt,
    required this.actionLabel,
    required this.onAction,
    super.key,
  });

  /// Non-interactive prompt text (e.g. "No tenés cuenta? ").
  final String prompt;

  /// Tappable action text (e.g. "Registrate").
  final String actionLabel;

  /// Callback when the action text is tapped.
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prompt,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.mutedForeground,
          ),
        ),
        GestureDetector(
          onTap: onAction,
          child: Text(
            actionLabel,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.gameRust,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.gameRust,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
