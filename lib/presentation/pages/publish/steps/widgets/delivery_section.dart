import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/presentation/widgets/publish/delivery_method_card.dart';

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
        const SizedBox(height: 12),
        if (availableMethods.isEmpty)
          _buildEmptyState()
        else
          ...availableMethods.map((method) {
            final isSelected =
                selectedMethods.any((m) => m.id == method.id && m.id != null);
            return DeliveryMethodCard(
              method: method,
              isSelected: isSelected,
              onTap: () => onToggle(method),
            );
          }),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: AppColors.gameBrown.withOpacityValue(0.2),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.local_shipping_outlined,
              size: 48,
              color: AppColors.gameBrown.withOpacityValue(0.3),
            ),
            const SizedBox(height: 12),
            Text(
              'No hay métodos de entrega configurados',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Agregá al menos un método para que los compradores puedan recibir el juego',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
