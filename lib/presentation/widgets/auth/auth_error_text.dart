import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Error text widget for authentication forms.
class AuthErrorText extends StatelessWidget {
  /// Creates an auth error text widget.
  const AuthErrorText({
    required this.message,
    super.key,
  });

  /// The error message to display.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        message,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.destructive,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
