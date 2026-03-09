import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/numeric_input_field.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({
    required this.formVersion,
    required this.price,
    required this.onChanged,
    this.priceError,
    super.key,
  });

  final int formVersion;
  final int price;
  final ValueChanged<int> onChanged;
  final String? priceError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Precio por día (UYU)', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        NumericInputField(
          key: ValueKey('publish_price_$formVersion'),
          initialValue: price > 0 ? price.toString() : '',
          prefixText: r'$ ',
          hintText: '150',
          validator: (_) => priceError,
          autovalidateMode: priceError != null ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
          onChangedValue: (value) => onChanged(value ?? 0),
        ),
      ],
    );
  }
}
