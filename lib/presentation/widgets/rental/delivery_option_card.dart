import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

class DeliveryOptionCard extends StatelessWidget {
  const DeliveryOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(
          AppTheme.spacingXl,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gameCream : AppColors.card,
          borderRadius: BorderRadius.circular(
            AppTheme.radiusLg,
          ),
          border: Border.all(
            color: isSelected
                ? AppColors.gameRust
                : AppColors.gameBrown.withOpacityValue(0.15),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.gameRust.withOpacityValue(0.1)
                    : AppColors.gameBrown.withOpacityValue(0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
              ),
            ),
            const SizedBox(
              height: AppTheme.spacingMd,
            ),
            Text(
              title,
              style: AppTypography.titleSmall.copyWith(
                color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppTheme.spacingXs,
            ),
            Text(
              subtitle,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.5),
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
            if (isSelected) ...[
              const SizedBox(
                height: AppTheme.spacingSm,
              ),
              const Icon(
                Icons.check_circle,
                color: AppColors.gameRust,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
