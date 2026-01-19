import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';

/// Step in the publish flow for setting price and condition.
class PriceStep extends StatelessWidget {
  /// Creates a [PriceStep].
  const PriceStep({
    required this.formVersion,
    required this.price,
    required this.condition,
    required this.conditions,
    required this.deliveryMethods,
    required this.onPriceChanged,
    required this.onConditionChanged,
    required this.onDeliveryMethodsChanged,
    super.key,
  });

  /// Incremented when the form is reset.
  final int formVersion;

  /// Current price.
  final int price;

  /// Current game condition key.
  final String condition;

  /// List of condition metadata (key, label, description).
  final List<(String, String, String)> conditions;

  /// Selected delivery methods.
  final List<DeliveryMethod> deliveryMethods;

  /// Callback when price changes.
  final void Function(int) onPriceChanged;

  /// Callback when condition changes.
  final void Function(String) onConditionChanged;

  /// Callback when delivery methods change.
  final void Function(List<DeliveryMethod>) onDeliveryMethodsChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Precio y condición', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Definí el precio de alquiler y el estado del juego',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.gameBrown.withOpacityValue(0.7),
          ),
        ),
        const SizedBox(height: 24),

        // Condition
        Text('Estado del juego', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        ...conditions.map((c) {
          final isSelected = condition == c.$1;
          return GestureDetector(
            onTap: () => onConditionChanged(c.$1),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.$2, style: AppTypography.titleSmall),
                        Text(
                          c.$3,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.gameBrown.withOpacityValue(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle, color: AppColors.gameRust),
                ],
              ),
            ),
          );
        }),

        const SizedBox(height: 24),

        // Price
        Text('Precio (UYU)', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        TextFormField(
          key: ValueKey('publish_price_$formVersion'),
          initialValue: price.toString(),
          decoration: const InputDecoration(prefixText: r'$ ', hintText: '50'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (v) => onPriceChanged(int.tryParse(v) ?? price),
        ),

        const SizedBox(height: 24),

        // Delivery Methods
        Text('Opciones de entrega', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        // Pickup
        _DeliveryOption(
          title: 'Retiro en persona',
          subtitle: 'El locatario pasa a buscar el juego',
          price: 0,
          isSelected: deliveryMethods.any((m) => m.deliveryType == 'pickup'),
          onToggle: (selected) {
            final current = List<DeliveryMethod>.from(deliveryMethods);
            if (selected) {
              current.add(
                const DeliveryMethod(
                  id: 1, // ID will be handled by backend or is fixed 'pickup'
                  deliveryType: 'pickup',
                  price: 0,
                ),
              );
            } else {
              current.removeWhere((m) => m.deliveryType == 'pickup');
            }
            onDeliveryMethodsChanged(current);
          },
        ),
        const SizedBox(height: 12),
        // Delivery
        _DeliveryOption(
          title: 'Envío propio',
          subtitle: 'Vos llevás el juego',
          price: deliveryMethods
              .firstWhere(
                (m) => m.deliveryType == 'delivery',
                orElse: () => const DeliveryMethod(
                  id: 0,
                  deliveryType: 'delivery',
                  price: 0,
                ),
              )
              .price,
          isSelected: deliveryMethods.any((m) => m.deliveryType == 'delivery'),
          onToggle: (selected) {
            final current = List<DeliveryMethod>.from(deliveryMethods);
            if (selected) {
              current.add(
                const DeliveryMethod(
                  id: 2,
                  deliveryType: 'delivery',
                  price: 150, // Default price
                ),
              );
            } else {
              current.removeWhere((m) => m.deliveryType == 'delivery');
            }
            onDeliveryMethodsChanged(current);
          },
          onPriceChanged: (newPrice) {
            final current = List<DeliveryMethod>.from(deliveryMethods);
            final index = current.indexWhere(
              (m) => m.deliveryType == 'delivery',
            );
            if (index != -1) {
              current[index] = current[index].copyWith(price: newPrice);
              onDeliveryMethodsChanged(current);
            }
          },
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}

class _DeliveryOption extends StatelessWidget {
  const _DeliveryOption({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isSelected,
    required this.onToggle,
    this.onPriceChanged,
  });

  final String title;
  final String subtitle;
  final int price;
  final bool isSelected;
  final ValueChanged<bool> onToggle;
  final ValueChanged<int>? onPriceChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isSelected
              ? AppColors.gameRust
              : AppColors.gameBrown.withOpacityValue(0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: isSelected,
                activeColor: AppColors.gameRust,
                onChanged: (v) => onToggle(v ?? false),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.titleSmall),
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gameBrown.withOpacityValue(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isSelected && onPriceChanged != null) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('Costo de envío:', style: AppTypography.bodySmall),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: price.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: r'$ ',
                        isDense: true,
                      ),
                      onChanged: (v) =>
                          onPriceChanged?.call(int.tryParse(v) ?? 0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
