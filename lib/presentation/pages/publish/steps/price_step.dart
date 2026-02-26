import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/widgets/delivery_section.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/widgets/price_section.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/publish/delivery_method_sheet.dart';

/// Step in the publish flow for setting price and delivery methods.
class PriceStep extends StatelessWidget {
  /// Creates a [PriceStep].
  const PriceStep({
    required this.formVersion,
    required this.price,
    required this.deliveryMethods,
    required this.availableDeliveryMethods,
    required this.onPriceChanged,
    required this.onToggleDeliveryMethod,
    required this.onAddDeliveryMethod,
    super.key,
  });

  /// Incremented when the form is reset.
  final int formVersion;

  /// Current price.
  final int price;

  /// Current delivery methods (selected for publication).
  final List<DeliveryMethod> deliveryMethods;

  /// All available delivery methods for the user.
  final List<DeliveryMethod> availableDeliveryMethods;

  /// Callback when price changes.
  final void Function(int) onPriceChanged;

  /// Callback when a delivery method is toggled.
  final void Function(DeliveryMethod) onToggleDeliveryMethod;

  /// Callback when a new delivery method is added.
  final void Function(DeliveryMethod) onAddDeliveryMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Precio y entrega', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Definí el precio de alquiler y cómo entregarás el juego',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.gameBrown.withOpacityValue(0.7),
          ),
        ),
        const SizedBox(height: 24),

        // Price
        PriceSection(
          formVersion: formVersion,
          price: price,
          onChanged: onPriceChanged,
        ),

        const SizedBox(height: 32),

        // Delivery Methods
        DeliverySection(
          selectedMethods: deliveryMethods,
          availableMethods: availableDeliveryMethods,
          onAdd: () => _addDeliveryMethod(context),
          onToggle: onToggleDeliveryMethod,
        ),

        const SizedBox(height: 100),
      ],
    );
  }

  Future<void> _addDeliveryMethod(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DeliveryMethodSheet(
        onAdd: onAddDeliveryMethod,
      ),
    );
  }
}
