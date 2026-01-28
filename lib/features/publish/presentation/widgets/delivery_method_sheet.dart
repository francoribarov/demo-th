import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';

class DeliveryMethodSheet extends StatefulWidget {
  const DeliveryMethodSheet({required this.onAdd, super.key});

  final void Function(DeliveryMethod) onAdd;

  @override
  State<DeliveryMethodSheet> createState() => _DeliveryMethodSheetState();
}

class _DeliveryMethodSheetState extends State<DeliveryMethodSheet> {
  DeliveryType _selectedType = DeliveryType.pickupInPerson;
  int _price = 0;
  DateTime? _initPickupTime;
  DateTime? _finishPickupTime;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressNameController = TextEditingController();
  final TextEditingController _addressNumberController =
      TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _addressNameController.dispose();
    _addressNumberController.dispose();
    _notesController.dispose();
    super.dispose();
  }

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
            Text('Dirección', style: AppTypography.titleSmall),
            const SizedBox(height: 12),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Calle y esquina',
                hintText: 'Ej: Av. 18 de Julio y Ejido',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _addressNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Número / Apto',
                      hintText: '1234 Apto 101',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _addressNameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre lugar',
                      hintText: 'Ej: Casa, Oficina',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Indicaciones adicionales (opcional)',
                hintText: 'Tocar timbre, dejar en recepción...',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
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
                      address: _addressController.text,
                      addressName: _addressNameController.text,
                      addressNumber: _addressNumberController.text,
                      additionalNotes: _notesController.text,
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
