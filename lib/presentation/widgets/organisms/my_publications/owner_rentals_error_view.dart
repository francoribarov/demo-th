import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Error state view for the Owner Rentals tab.
/// Shows an icon, an error message, and a retry button.
class OwnerRentalsErrorView extends StatelessWidget {
  const OwnerRentalsErrorView({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.gameRust,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reintentar'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.gameRust,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
