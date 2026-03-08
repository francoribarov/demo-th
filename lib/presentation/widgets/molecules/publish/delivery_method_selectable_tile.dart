import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/selectable_input_card.dart';

/// Display data for a delivery method (domain-agnostic view model).
class DeliveryMethodDisplayData {
  const DeliveryMethodDisplayData({
    required this.icon,
    required this.title,
    required this.priceLabel,
    this.subtitle,
    this.priceLabelColor,
  });

  final String icon;
  final String title;
  final String? subtitle;
  final String priceLabel;
  final Color? priceLabelColor;
}

/// Reusable selectable tile for delivery methods.
/// Accepts [DeliveryMethodDisplayData] so it works with both
/// publish.DeliveryMethod and publication_primitives.DeliveryMethod.
class DeliveryMethodSelectableTile extends StatelessWidget {
  const DeliveryMethodSelectableTile({
    required this.data,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final DeliveryMethodDisplayData data;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final priceChip = data.priceLabel.isNotEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSm,
              vertical: AppTheme.spacingXs,
            ),
            decoration: BoxDecoration(
              color: (data.priceLabelColor ?? AppColors.gameBrown)
                  .withOpacityValue(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Text(
              data.priceLabel,
              style: AppTypography.labelSmall.copyWith(
                color: data.priceLabelColor ?? AppColors.gameBrown,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : null;

    return SelectableInputCard(
      onTap: onTap,
      isSelected: isSelected,
      indicatorMode: SelectableInputIndicatorMode.checkbox,
      indicatorPosition: SelectableInputIndicatorPosition.leading,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      selectedBackgroundColor: AppColors.gameRust.withOpacityValue(0.1),
      unselectedBorderColor: AppColors.border,
      selectedTextColor: AppColors.gameRust,
      unselectedTextColor: AppColors.foreground,
      leading: Text(
        data.icon,
        style: const TextStyle(fontSize: 24),
      ),
      title: data.title,
      subtitle: data.subtitle,
      trailing: priceChip,
    );
  }
}
