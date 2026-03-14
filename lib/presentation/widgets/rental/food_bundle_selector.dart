import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

class FoodBundleSelector extends StatelessWidget {
  const FoodBundleSelector({
    required this.selectedBundles,
    required this.onBundlesChanged,
    super.key,
  });

  final List<String> selectedBundles;
  final void Function(List<String>) onBundlesChanged;

  static const _bundles = [
    ('classic', 'Pack Clásico', 'Pop, papas y bebidas', '🍿'),
    ('sweet', 'Pack Dulce', 'Chocolates, galletas y jugos', '🍫'),
    ('premium', 'Pack Premium', 'Quesos, fiambres y vino', '🧀'),
  ];

  static String labelForId(String id) {
    switch (id) {
      case 'classic':
        return 'Pack Clásico';
      case 'sweet':
        return 'Pack Dulce';
      case 'premium':
        return 'Pack Premium';
      default:
        return id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _bundles.map((bundle) {
        final isSelected = selectedBundles.contains(bundle.$1);
        return GestureDetector(
          onTap: () {
            final newBundles = List<String>.from(selectedBundles);
            if (isSelected) {
              newBundles.remove(bundle.$1);
            } else {
              newBundles.add(bundle.$1);
            }
            onBundlesChanged(newBundles);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.gameCream : AppColors.card,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border: Border.all(
                color: isSelected
                    ? AppColors.gameRust
                    : AppColors.gameBrown.withOpacityValue(0.15),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Center(
                    child:
                        Text(bundle.$4, style: const TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bundle.$2, style: AppTypography.titleSmall),
                      Text(
                        bundle.$3,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.gameBrown.withOpacityValue(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(r'$250', style: AppTypography.titleSmall),
                const SizedBox(width: 8),
                Icon(
                  isSelected ? Icons.check_circle : Icons.add_circle_outline,
                  color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
