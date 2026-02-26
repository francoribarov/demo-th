import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Suggestion style chip for search shortcuts.
class SuggestionChip extends StatelessWidget {
  /// Creates a [SuggestionChip].
  const SuggestionChip({
    required this.label,
    required this.onTap,
    super.key,
    this.icon = Icons.auto_awesome,
  });

  final String label;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.gameCream,
          borderRadius: BorderRadius.circular(AppTheme.radius2xl),
          border: Border.all(color: AppColors.goldBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.gameGold),
            const SizedBox(width: 6),
            Text(label, style: AppTypography.labelSmall),
          ],
        ),
      ),
    );
  }
}
