import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

class ReviewSectionCard extends StatelessWidget {
  const ReviewSectionCard({
    required this.icon,
    required this.title,
    required this.onEdit,
    required this.child,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onEdit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppTheme.spacingMd,
      ),
      padding: const EdgeInsets.all(
        AppTheme.spacingLg,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(
          AppTheme.radiusLg,
        ),
        border: Border.all(
          color: AppColors.gameBrown.withOpacityValue(0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.gameRust.withOpacityValue(0.08),
              borderRadius: BorderRadius.circular(
                AppTheme.radiusMd,
              ),
            ),
            child: Icon(
              icon,
              size: 18,
              color: AppColors.gameRust,
            ),
          ),
          const SizedBox(
            width: AppTheme.spacingMd,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.5),
                  ),
                ),
                const SizedBox(
                  height: AppTheme.spacingXs,
                ),
                child,
              ],
            ),
          ),
          GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.all(
                AppTheme.spacingSm,
              ),
              decoration: BoxDecoration(
                color: AppColors.gameRust.withOpacityValue(0.08),
                borderRadius: BorderRadius.circular(
                  AppTheme.radiusSm,
                ),
              ),
              child: const Icon(
                Icons.edit_outlined,
                size: 16,
                color: AppColors.gameRust,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
