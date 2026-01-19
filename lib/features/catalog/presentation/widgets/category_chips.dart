// UI widgets are documented at a higher level; omit per-member docs.
//

import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

/// Horizontal scrollable list of category chips
class CategoryChips extends StatelessWidget {
  const CategoryChips({
    required this.categories,
    required this.filterShortcuts,
    required this.onCategorySelected,
    required this.onShortcutSelected,
    super.key,
  });

  final List<GameCategory> categories;
  final List<FilterShortcut> filterShortcuts;
  final void Function(String category) onCategorySelected;
  final void Function(FilterShortcut shortcut) onShortcutSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 12),
          child: Text(
            'EXPLORÁ POR CATEGORÍA',
            style: AppTypography.sectionHeader,
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length + filterShortcuts.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index < categories.length) {
                final category = categories[index];
                return _CategoryChip(
                  name: category.name,
                  icon: category.icon,
                  gradient:
                      AppColors.gradientPalette[index %
                          AppColors.gradientPalette.length],
                  onTap: () =>
                      onCategorySelected(category.query ?? category.name),
                );
              } else {
                final shortcut = filterShortcuts[index - categories.length];
                return _CategoryChip(
                  name: shortcut.name,
                  icon: shortcut.icon,
                  gradient:
                      AppColors.gradientPalette[index %
                          AppColors.gradientPalette.length],
                  onTap: () => onShortcutSelected(shortcut),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.name,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  final String name;
  final String icon;
  final List<Color> gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: Colors.white.withOpacityValue(0.6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacityValue(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacityValue(0.8),
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacityValue(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(icon, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: AppTypography.categoryChip,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
