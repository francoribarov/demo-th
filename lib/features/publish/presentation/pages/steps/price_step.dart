import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:mobile_table_hopping/features/publish/presentation/widgets/delivery_method_sheet.dart';

/// Step in the publish flow for setting price and delivery methods.
class PriceStep extends StatefulWidget {
  /// Creates a [PriceStep].
  const PriceStep({
    required this.formVersion,
    required this.price,
    required this.deliveryMethods,
    required this.onPriceChanged,
    required this.onDeliveryMethodsChanged,
    super.key,
  });

  /// Incremented when the form is reset.
  final int formVersion;

  /// Current price.
  final int price;

  /// Current delivery methods.
  final List<DeliveryMethod> deliveryMethods;

  /// Callback when price changes.
  final void Function(int) onPriceChanged;

  /// Callback when delivery methods change.
  final void Function(List<DeliveryMethod>) onDeliveryMethodsChanged;

  @override
  State<PriceStep> createState() => _PriceStepState();
}

class _PriceStepState extends State<PriceStep> {
  @override
  void initState() {
    super.initState();
    // Load delivery methods when step is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _getDeliveryMethods();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Precio y entrega', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Definí el precio de alquiler y cómo entregarás el juego',
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
        ),
        const SizedBox(height: 24),

        // Price
        Text('Precio por día (UYU)', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        TextFormField(
          key: ValueKey('publish_price_${widget.formVersion}'),
          initialValue: widget.price > 0 ? widget.price.toString() : '',
          decoration: const InputDecoration(prefixText: r'$ ', hintText: '150'),
          keyboardType: TextInputType.number,
          onChanged: (v) => widget.onPriceChanged(int.tryParse(v) ?? 0),
        ),

        const SizedBox(height: 32),

        // Delivery Methods
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Métodos de entrega', style: AppTypography.titleMedium),
            TextButton.icon(
              onPressed: _addDeliveryMethod,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Agregar'),
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (widget.deliveryMethods.isEmpty)
          Container(
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
          )
        else
          ...widget.deliveryMethods.asMap().entries.map((entry) {
            final index = entry.key;
            final method = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(
                  color: AppColors.gameBrown.withOpacityValue(0.2),
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
                        if (method.price > 0)
                          Text(
                            'Costo: \$${method.price}',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gameBrown.withOpacityValue(0.7),
                            ),
                          )
                        else
                          Text(
                            'Gratis',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gameSage,
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: AppColors.destructive,
                    onPressed: () => _removeDeliveryMethod(index),
                  ),
                ],
              ),
            );
          }),

        const SizedBox(height: 100),
      ],
    );
  }

  void _getDeliveryMethods() {
    final publishBloc = context.read<PublishBloc>();
    publishBloc.add(const PublishEvent.getDeliveryMethods());
  }

  void _addDeliveryMethod() {
    final publishBloc = context.read<PublishBloc>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DeliveryMethodSheet(
        onAdd: (method) {
          publishBloc.add(PublishEvent.addDeliveryMethod(method));
        },
      ),
    );
  }

  void _removeDeliveryMethod(int index) {
    final updated = [...widget.deliveryMethods]..removeAt(index);
    widget.onDeliveryMethodsChanged(updated);
  }
}
