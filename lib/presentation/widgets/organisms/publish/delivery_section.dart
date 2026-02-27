import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/surface_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/publish/delivery_method_selectable_tile.dart';

class DeliverySection extends StatelessWidget {
  const DeliverySection({
    required this.selectedMethods,
    required this.availableMethods,
    required this.onAdd,
    required this.onToggle,
    super.key,
  });

  final List<DeliveryMethod> selectedMethods;
  final List<DeliveryMethod> availableMethods;
  final VoidCallback onAdd;
  final ValueChanged<DeliveryMethod> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Métodos de entrega', style: AppTypography.titleMedium),
            TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Agregar'),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingMd),
        if (availableMethods.isEmpty)
          _buildEmptyState()
        else
          ...availableMethods.map((method) {
            final isSelected = selectedMethods.any(
              (m) => m.id == method.id && m.id != null,
            );
            return Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingMd),
              child: DeliveryMethodSelectableTile(
                data: _toDisplayData(method),
                isSelected: isSelected,
                onTap: () => onToggle(method),
              ),
            );
          }),
      ],
    );
  }

  DeliveryMethodDisplayData _toDisplayData(DeliveryMethod method) {
    final parts = <String>[];
    if (method.deliveryType == DeliveryType.pickupInPerson && method.address != null) {
      parts.add('${method.address} ${method.addressNumber ?? ''}');
    }
    if (method.initPickupTime != null && method.finishPickupTime != null) {
      parts.add('${method.initPickupTime} - ${method.finishPickupTime}');
    }
    final subtitle = parts.isNotEmpty ? parts.join('\n') : null;
    final isFree = method.price <= 0;
    return DeliveryMethodDisplayData(
      icon: method.deliveryType.icon,
      title: method.deliveryType.displayName,
      subtitle: subtitle,
      priceLabel: isFree ? 'Gratis' : 'Costo: \$${method.price}',
      priceLabelColor: isFree ? AppColors.gameSage : null,
    );
  }

  Widget _buildEmptyState() {
    return SurfaceCard(
      padding: const EdgeInsets.all(AppTheme.spacing2xl),
      borderColor: AppColors.gameBrown.withOpacityValue(0.2),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.local_shipping_outlined,
              size: 48,
              color: AppColors.gameBrown.withOpacityValue(0.3),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Text(
              'No hay métodos de entrega configurados',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Text(
              'Agregá al menos un método para que los compradores puedan recibir el juego',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textPlaceholder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
