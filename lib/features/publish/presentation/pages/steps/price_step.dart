import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Step in the publish flow for setting price and condition.
class PriceStep extends StatelessWidget {
  /// Creates a [PriceStep].
  const PriceStep({
    required this.formVersion,
    required this.price,
    required this.condition,
    required this.conditions,
    required this.onPriceChanged,
    required this.onConditionChanged,
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

  /// Callback when price changes.
  final void Function(int) onPriceChanged;

  /// Callback when condition changes.
  final void Function(String) onConditionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Precio y condición', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Definí el precio de alquiler y el estado del juego',
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
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
                              color: AppColors.gameBrown.withOpacityValue(0.7),),
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
        Text('Precio por día (UYU)', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        TextFormField(
          key: ValueKey('publish_price_$formVersion'),
          initialValue: price > 0 ? price.toString() : '',
          decoration: const InputDecoration(prefixText: r'$ ', hintText: '150'),
          keyboardType: const TextInputType.numberWithOptions(),
          onChanged: (v) => onPriceChanged(int.tryParse(v) ?? 0),
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}
