import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/numeric_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/publish/delivery_method_selectable_tile.dart';

/// Step for editing publication price and delivery methods.
class EditPriceStep extends StatelessWidget {
  /// Creates the edit price step.
  const EditPriceStep({
    required this.price,
    required this.deliveryMethods,
    required this.availableDeliveryMethods,
    required this.onPriceChanged,
    required this.onDeliveryMethodsChanged,
    this.priceError,
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

  /// Validation error for price from bloc.
  final String? priceError;

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
          validator: (_) => priceError,
          autovalidateMode: priceError != null ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
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
              padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
              child: DeliveryMethodSelectableTile(
                data: _toDisplayData(method),
                isSelected: deliveryMethods.any((m) => m.id == method.id),
                onTap: () => _toggleMethod(method),
              ),
            ),
          ),
      ],
    );
  }

  DeliveryMethodDisplayData _toDisplayData(DeliveryMethod method) {
    final subtitle =
        method.deliveryType == DeliveryType.pickupInPerson && method.address != null && method.address!.isNotEmpty
        ? '${method.address} ${method.addressNumber ?? ''}'
        : null;
    return DeliveryMethodDisplayData(
      icon: method.deliveryType.icon,
      title: method.deliveryType.displayName,
      subtitle: subtitle,
      priceLabel: method.price > 0 ? '\$${method.price}' : 'Gratis',
      priceLabelColor: method.price <= 0 ? AppColors.gameSage : null,
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
