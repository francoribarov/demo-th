import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/numeric_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/selectable_input_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

/// Step for editing publication price and delivery methods.
class EditPriceStep extends StatelessWidget {
  /// Creates the edit price step.
  const EditPriceStep({
    required this.price,
    required this.deliveryMethods,
    required this.availableDeliveryMethods,
    required this.onPriceChanged,
    required this.onDeliveryMethodsChanged,
    super.key,
  });

  /// Current price.
  final int price;

  /// Selected delivery methods.
  final List<DeliveryMethod> deliveryMethods;

  /// Available delivery methods.
  final List<DeliveryMethod> availableDeliveryMethods;

  /// Callback when price changes.
  final ValueChanged<int> onPriceChanged;

  /// Callback when delivery methods change.
  final ValueChanged<List<DeliveryMethod>> onDeliveryMethodsChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price section
        Text(
          'Precio de alquiler',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Precio por día de alquiler en pesos uruguayos.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.mutedForeground,
          ),
        ),
        const SizedBox(height: 16),

        NumericInputField(
          initialValue: price > 0 ? price.toString() : '',
          prefixText: r'$ ',
          suffixText: 'UYU / día',
          hintText: '0',
          variant: TextInputVisualVariant.subtle,
          onChangedValue: (value) => onPriceChanged(value ?? 0),
        ),

        const SizedBox(height: 32),

        // Delivery methods section
        Text(
          'Métodos de entrega',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecciona los métodos de entrega disponibles para esta publicación.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.mutedForeground,
          ),
        ),
        const SizedBox(height: 16),

        if (availableDeliveryMethods.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.muted.withOpacityValue(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.local_shipping_outlined,
                  size: 48,
                  color: AppColors.mutedForeground,
                ),
                const SizedBox(height: 16),
                Text(
                  'No tienes métodos de entrega configurados',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.mutedForeground,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        else
          ...availableDeliveryMethods.map(
            (method) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _DeliveryMethodTile(
                method: method,
                isSelected: deliveryMethods.any((m) => m.id == method.id),
                onTap: () => _toggleMethod(method),
              ),
            ),
          ),
      ],
    );
  }

  void _toggleMethod(DeliveryMethod method) {
    final exists = deliveryMethods.any((m) => m.id == method.id);
    List<DeliveryMethod> updated;
    if (exists) {
      updated = deliveryMethods.where((m) => m.id != method.id).toList();
    } else {
      updated = [...deliveryMethods, method];
    }
    onDeliveryMethodsChanged(updated);
  }
}

class _DeliveryMethodTile extends StatelessWidget {
  // Thin adapter to keep delivery-method visuals and price badge consistent.
  const _DeliveryMethodTile({
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  final DeliveryMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final priceChip = method.price > 0
        ? Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.gameGold.withOpacityValue(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Text(
              '\$${method.price}',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.gameBrown,
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
        method.deliveryType.icon,
        style: const TextStyle(fontSize: 24),
      ),
      title: method.deliveryType.displayName,
      subtitle: method.address != null && method.address!.isNotEmpty
          ? method.address
          : null,
      trailing: priceChip,
    );
  }
}
