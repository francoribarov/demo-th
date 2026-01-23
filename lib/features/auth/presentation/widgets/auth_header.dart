import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Header widget for authentication pages.
class AuthHeader extends StatelessWidget {
  /// Creates an auth header.
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  /// Main title text.
  final String title;

  /// Subtitle/description text.
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTypography.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.gameBrown.withOpacityValue(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
