import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// A row showing a single game detail with an icon.
class GameDetailRow extends StatelessWidget {
  /// Creates a [GameDetailRow].
  const GameDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  /// Icon to display.
  final IconData icon;

  /// Label for the detail.
  final String label;

  /// Value for the detail.
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.gameCream,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          child: Icon(icon, size: 18, color: AppColors.gameBrown),
        ),
        const SizedBox(width: 12),
        Text(label, style: AppTypography.bodyMedium),
        const Spacer(),
        Text(value, style: AppTypography.titleMedium),
      ],
    );
  }
}
