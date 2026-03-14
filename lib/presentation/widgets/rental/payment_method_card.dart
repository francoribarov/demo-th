import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(
          AppTheme.spacingXl,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.gameCream
              : AppColors.card,
          borderRadius: BorderRadius.circular(
            AppTheme.radiusLg,
          ),
          border: Border.all(
            color: isSelected
                ? AppColors.gameRust
                : AppColors.gameBrown
                    .withOpacityValue(0.15),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.gameRust
                        .withOpacityValue(0.1)
                    : AppColors.gameBrown
                        .withOpacityValue(0.06),
                borderRadius:
                    BorderRadius.circular(
                  AppTheme.radiusMd,
                ),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppColors.gameRust
                    : AppColors.gameBrown,
              ),
            ),
            const SizedBox(
              width: AppTheme.spacingLg,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        AppTypography.titleSmall,
                  ),
                  const SizedBox(
                    height: AppTheme.spacingXs,
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall
                        .copyWith(
                      color: AppColors.gameBrown
                          .withOpacityValue(0.6),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 200,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check_circle,
                      color: AppColors.gameRust,
                    )
                  : Icon(
                      Icons
                          .radio_button_unchecked,
                      color: AppColors.gameBrown
                          .withOpacityValue(0.25),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
