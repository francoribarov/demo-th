import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_typography.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({
    required this.formVersion,
    required this.price,
    required this.onChanged,
    super.key,
  });

  final int formVersion;
  final int price;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Precio por día (UYU)', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        TextFormField(
          key: ValueKey('publish_price_$formVersion'),
          initialValue: price > 0 ? price.toString() : '',
          decoration: const InputDecoration(prefixText: r'$ ', hintText: '150'),
          keyboardType: TextInputType.number,
          onChanged: (v) => onChanged(int.tryParse(v) ?? 0),
        ),
      ],
    );
  }
}
