import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';

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

  void _addDeliveryMethod() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _AddDeliveryMethodSheet(
        onAdd: (method) {
          final updated = [...widget.deliveryMethods, method];
          widget.onDeliveryMethodsChanged(updated);
        },
      ),
    );
  }

  void _removeDeliveryMethod(int index) {
    final updated = [...widget.deliveryMethods];
    updated.removeAt(index);
    widget.onDeliveryMethodsChanged(updated);
  }
}

class _AddDeliveryMethodSheet extends StatefulWidget {
  const _AddDeliveryMethodSheet({required this.onAdd});

  final void Function(DeliveryMethod) onAdd;

  @override
  State<_AddDeliveryMethodSheet> createState() =>
      _AddDeliveryMethodSheetState();
}

class _AddDeliveryMethodSheetState extends State<_AddDeliveryMethodSheet> {
  DeliveryType _selectedType = DeliveryType.pickupInPerson;
  int _price = 0;
  DateTime? _initPickupTime;
  DateTime? _finishPickupTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Agregar método de entrega', style: AppTypography.titleLarge),
            const SizedBox(height: 24),
            Text('Tipo de entrega', style: AppTypography.titleSmall),
            const SizedBox(height: 12),
            ...DeliveryType.values.map((type) {
              final isSelected = _selectedType == type;
              return GestureDetector(
                onTap: () => setState(() => _selectedType = type),
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
                      Text(type.icon, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          type.displayName,
                          style: AppTypography.bodyMedium,
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.gameRust,
                        ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            Text(
              'Costo de entrega (opcional)',
              style: AppTypography.titleSmall,
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: '',
              decoration: const InputDecoration(
                prefixText: r'$ ',
                hintText: '0 (gratis)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _price = int.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 24),
            Text('Horario de retiro/entrega', style: AppTypography.titleSmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _DateTimePickerTile(
                    label: 'Desde',
                    value: _initPickupTime,
                    onChanged: (dt) => setState(() => _initPickupTime = dt),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DateTimePickerTile(
                    label: 'Hasta',
                    value: _finishPickupTime,
                    onChanged: (dt) => setState(() => _finishPickupTime = dt),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onAdd(
                    DeliveryMethod(
                      deliveryType: _selectedType,
                      price: _price,
                      initPickupTime: _initPickupTime,
                      finishPickupTime: _finishPickupTime,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Agregar'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _DateTimePickerTile extends StatelessWidget {
  const _DateTimePickerTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime? value;
  final void Function(DateTime?) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null && context.mounted) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(value ?? DateTime.now()),
          );
          if (time != null) {
            onChanged(
              DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              ),
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(
            color: AppColors.gameBrown.withOpacityValue(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value != null
                  ? '${value!.day}/${value!.month} ${value!.hour.toString().padLeft(2, '0')}:${value!.minute.toString().padLeft(2, '0')}'
                  : 'Seleccionar',
              style: AppTypography.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
