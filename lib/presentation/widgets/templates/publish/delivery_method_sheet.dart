import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/selectable_input_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

class DeliveryMethodSheet extends StatefulWidget {
  const DeliveryMethodSheet({required this.onAdd, super.key});

  final void Function(DeliveryMethod) onAdd;

  @override
  State<DeliveryMethodSheet> createState() => _DeliveryMethodSheetState();
}

class _DeliveryMethodSheetState extends State<DeliveryMethodSheet> {
  DeliveryType _selectedType = DeliveryType.pickupInPerson;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _addressNumberController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _aliasController.dispose();
    _addressNumberController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _showToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    
    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingLg,
              vertical: AppTheme.spacingMd,
            ),
            decoration: BoxDecoration(
              color: AppColors.gameBrown,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              boxShadow: AppTheme.shadowSm,
            ),
            child: Text(
              message,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.background,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 3), () {
      if (entry.mounted) {
        entry.remove();
      }
    });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Agregar método de entrega',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.gameBrown,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                  icon: const Icon(Icons.close, color: AppColors.gameBrown),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  style: IconButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Text(
              'La dirección únicamente se compartirá con el alquilador o delivery para retirar y entregar el juego',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing2xl),
            Text('Tipo de entrega', style: AppTypography.titleSmall),
            const SizedBox(height: AppTheme.spacingMd),
            ...DeliveryType.values.map((type) {
              final isSelected = _selectedType == type;
              return SelectableInputCard(
                onTap: () {
                  if (type == DeliveryType.delivery) {
                    _showToast(
                      context,
                      'Próximamente: Aún no se puede implementar este tipo de entrega.',
                    );
                    return;
                  }
                  setState(() => _selectedType = type);
                },
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
            const SizedBox(height: AppTheme.spacingLg),
            Text('Dirección', style: AppTypography.titleSmall),
            const SizedBox(height: AppTheme.spacingMd),
            TextFormInputField(
              controller: _addressController,
              hintText: 'Calle principal',
            ),
            const SizedBox(height: AppTheme.spacingMd),
            TextFormInputField(
              controller: _addressNumberController,
              hintText: 'Número de puerta',
            ),
            const SizedBox(height: AppTheme.spacingMd),
            TextFormInputField(
              controller: _notesController,
              hintText: 'Indicaciones adicionales (opcional)',
            ),
            const SizedBox(height: AppTheme.spacingMd),
            TextFormInputField(
              controller: _aliasController,
              hintText: 'Alias',
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
                      price: 0,
                      address: _addressController.text,
                      addressName: _aliasController.text,
                      addressNumber: _addressNumberController.text,
                      additionalNotes: _notesController.text,
                    ),
                  );
                  Navigator.of(context, rootNavigator: true).pop();
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
