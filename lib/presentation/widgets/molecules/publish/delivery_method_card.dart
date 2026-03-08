import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';

class DeliveryMethodCard extends StatelessWidget {
  const DeliveryMethodCard({
    required this.method,
    required this.priceLabel,
    this.priceLabelColor,
    this.isSelected = false,
    this.onTap,
    super.key,
  });

  final DeliveryMethod method;

  /// Pre-formatted price label, e.g. "Gratis" or "Costo: \$150".
  final String priceLabel;

  /// Text colour for [priceLabel]. Defaults to [AppColors.textTertiary].
  final Color? priceLabelColor;

  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gameCream : AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isSelected
                ? AppColors.gameRust
                : AppColors.gameBrown.withOpacityValue(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              method.deliveryType.icon,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.deliveryType.displayName,
                    style: AppTypography.titleSmall,
                  ),
                  if (method.deliveryType == DeliveryType.pickupInPerson &&
                      method.address != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${method.address} ${method.addressNumber ?? ''}',
                      style: AppTypography.bodySmall,
                    ),
                    if (method.addressName != null &&
                        method.addressName!.isNotEmpty)
                      Text(
                        method.addressName!,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                  ],
                  if (method.initPickupTime != null &&
                      method.finishPickupTime != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${method.initPickupTime} - ${method.finishPickupTime}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                  Text(
                    priceLabel,
                    style: AppTypography.bodySmall.copyWith(
                      color: priceLabelColor ?? AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.gameRust,
              )
            else
              const Icon(
                Icons.circle_outlined,
                color: AppColors.textPlaceholder,
              ),
          ],
        ),
      ),
    );
  }
}
