import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

class InfoBanner extends StatelessWidget {
  const InfoBanner({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppTheme.spacingMd,
      ),
      decoration: BoxDecoration(
        color: AppColors.gameCream.withOpacityValue(0.4),
        borderRadius: BorderRadius.circular(
          AppTheme.radiusMd,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 18,
            color: AppColors.gameBrown.withOpacityValue(0.5),
          ),
          const SizedBox(
            width: AppTheme.spacingSm,
          ),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
