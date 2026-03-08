import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/numeric_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/selectable_input_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/time_picker_field.dart';

class DeliveryMethodSheet extends StatefulWidget {
  const DeliveryMethodSheet({required this.onAdd, super.key});

  final void Function(DeliveryMethod) onAdd;

  @override
  State<DeliveryMethodSheet> createState() => _DeliveryMethodSheetState();
}

class _DeliveryMethodSheetState extends State<DeliveryMethodSheet> {
  DeliveryType _selectedType = DeliveryType.pickupInPerson;
  int _price = 0;
  String? _initPickupTime;
  String? _finishPickupTime;

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
              return SelectableInputCard(
                onTap: () => setState(() => _selectedType = type),
                margin: const EdgeInsets.only(bottom: 8),
                isSelected: isSelected,
                indicatorMode: SelectableInputIndicatorMode.check,
                leading: Text(type.icon, style: const TextStyle(fontSize: 24)),
                title: type.displayName,
                titleStyle: AppTypography.bodyMedium,
                selectedTextColor: AppColors.gameBrown,
                unselectedTextColor: AppColors.gameBrown,
              );
            }),
            const SizedBox(height: 16),
            Text('Dirección', style: AppTypography.titleSmall),
            const SizedBox(height: 12),
            TextFormInputField(
              controller: _addressController,
              labelText: 'Calle y esquina',
              hintText: 'Ej: Av. 18 de Julio y Ejido',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormInputField(
                    controller: _addressNumberController,
                    labelText: 'Número / Apto',
                    hintText: '1234 Apto 101',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormInputField(
                    controller: _addressNameController,
                    labelText: 'Nombre lugar',
                    hintText: 'Ej: Casa, Oficina',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormInputField(
              controller: _notesController,
              labelText: 'Indicaciones adicionales (opcional)',
              hintText: 'Tocar timbre, dejar en recepción...',
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            Text(
              'Costo de entrega (opcional)',
              style: AppTypography.titleSmall,
            ),
            const SizedBox(height: 12),
            NumericInputField(
              initialValue: '',
              prefixText: r'$ ',
              hintText: '0 (gratis)',
              onChangedValue: (value) => _price = value ?? 0,
            ),
            const SizedBox(height: 24),
            Text('Horario de retiro/entrega', style: AppTypography.titleSmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TimePickerField(
                    label: 'Desde',
                    value: _initPickupTime,
                    onChanged: (time) => setState(() => _initPickupTime = time),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TimePickerField(
                    label: 'Hasta',
                    value: _finishPickupTime,
                    onChanged: (time) =>
                        setState(() => _finishPickupTime = time),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing2xl),
            SizedBox(
              width: double.infinity,
              child: AppPrimaryButton(
                label: 'Agregar',
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
              ),
            ),
            const SizedBox(height: AppTheme.spacing2xl),
          ],
        ),
      ),
    );
  }
}
