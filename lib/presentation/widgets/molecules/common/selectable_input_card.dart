import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Layout variants for [SelectableInputCard].
enum SelectableInputCardLayout {
  /// Horizontal layout with leading-title-subtitle-trailing.
  row,

  /// Vertical layout for icon + label style actions.
  stacked,
}

/// Indicator variants for [SelectableInputCard].
enum SelectableInputIndicatorMode {
  /// Uses a trailing check-circle icon.
  check,

  /// Uses a circular radio selector.
  radio,

  /// Uses a square checkbox selector.
  checkbox,

  /// Hides selection indicator.
  none,
}

/// Indicator placement for [SelectableInputCard].
enum SelectableInputIndicatorPosition {
  /// Renders indicator at the leading slot.
  leading,

  /// Renders indicator at the trailing slot.
  trailing,
}

/// Shared selectable card used by option rows and cards.
class SelectableInputCard extends StatelessWidget {
  /// Creates a [SelectableInputCard].
  const SelectableInputCard({
    required this.isSelected,
    required this.onTap,
    super.key,
    this.layout = SelectableInputCardLayout.row,
    this.indicatorMode = SelectableInputIndicatorMode.none,
    this.indicatorPosition = SelectableInputIndicatorPosition.trailing,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.titleStyle,
    this.subtitleStyle,
    this.margin,
    this.padding = const EdgeInsets.all(16),
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 200),
    this.child,
    this.centerStackedContent = true,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final SelectableInputCardLayout layout;
  final SelectableInputIndicatorMode indicatorMode;
  final SelectableInputIndicatorPosition indicatorPosition;
  final Widget? leading;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  final Color? selectedBackgroundColor;
  final Color? unselectedBackgroundColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final BorderRadius? borderRadius;
  final Duration animationDuration;
  final Widget? child;
  final bool centerStackedContent;

  @override
  Widget build(BuildContext context) {
    final effectiveSelectedColor = selectedBorderColor ?? AppColors.gameRust;
    final effectiveUnselectedColor = unselectedBorderColor ?? AppColors.gameBrown.withOpacityValue(0.2);

    final effectiveSelectedText = selectedTextColor ?? AppColors.gameRust;
    final effectiveUnselectedText = unselectedTextColor ?? AppColors.gameBrown;

    final effectiveSelectedIcon = selectedIconColor ?? AppColors.gameRust;
    final effectiveUnselectedIcon = unselectedIconColor ?? AppColors.gameBrown;

    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(AppTheme.radiusLg);

    final indicator = _buildIndicator(
      selectedColor: effectiveSelectedColor,
      unselectedColor: effectiveUnselectedColor,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: effectiveBorderRadius,
      child: AnimatedContainer(
        duration: animationDuration,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected
              ? (selectedBackgroundColor ?? AppColors.gameCream)
              : (unselectedBackgroundColor ?? AppColors.card),
          borderRadius: effectiveBorderRadius,
          border: Border.all(
            color: isSelected ? effectiveSelectedColor : effectiveUnselectedColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child:
            child ??
            _buildDefaultContent(
              context: context,
              indicator: indicator,
              selectedTextColor: effectiveSelectedText,
              unselectedTextColor: effectiveUnselectedText,
              selectedIconColor: effectiveSelectedIcon,
              unselectedIconColor: effectiveUnselectedIcon,
            ),
      ),
    );
  }

  Widget _buildDefaultContent({
    required BuildContext context,
    required Widget indicator,
    required Color selectedTextColor,
    required Color unselectedTextColor,
    required Color selectedIconColor,
    required Color unselectedIconColor,
  }) {
    final titleWidget = title == null
        ? null
        : Text(
            title!,
            style:
                titleStyle ??
                AppTypography.bodyMedium.copyWith(
                  color: isSelected ? selectedTextColor : unselectedTextColor,
                  fontWeight: FontWeight.w600,
                ),
          );

    final subtitleWidget = subtitle == null
        ? null
        : Text(
            subtitle!,
            style:
                subtitleStyle ??
                AppTypography.bodySmall.copyWith(
                  color: AppColors.mutedForeground,
                ),
          );

    if (layout == SelectableInputCardLayout.stacked) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: centerStackedContent ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (indicatorPosition == SelectableInputIndicatorPosition.leading &&
              indicatorMode != SelectableInputIndicatorMode.none)
            indicator,
          if (leading != null)
            IconTheme(
              data: IconThemeData(
                color: isSelected ? selectedIconColor : unselectedIconColor,
              ),
              child: leading!,
            ),
          if (leading != null && titleWidget != null) const SizedBox(height: 8),
          if (titleWidget != null)
            Text(
              title!,
              style:
                  titleStyle ??
                  AppTypography.labelMedium.copyWith(
                    color: isSelected ? selectedTextColor : unselectedTextColor,
                  ),
              textAlign: centerStackedContent ? TextAlign.center : TextAlign.start,
            ),
          if (subtitleWidget != null) ...[
            const SizedBox(height: 4),
            subtitleWidget,
          ],
          if (indicatorPosition == SelectableInputIndicatorPosition.trailing &&
              indicatorMode != SelectableInputIndicatorMode.none) ...[
            const SizedBox(height: 8),
            indicator,
          ],
        ],
      );
    }

    return Row(
      children: [
        if (indicatorPosition == SelectableInputIndicatorPosition.leading &&
            indicatorMode != SelectableInputIndicatorMode.none) ...[
          indicator,
          const SizedBox(width: 16),
        ],
        if (leading != null) ...[
          IconTheme(
            data: IconThemeData(
              color: isSelected ? selectedIconColor : unselectedIconColor,
            ),
            child: leading!,
          ),
          const SizedBox(width: 12),
        ],
        if (titleWidget != null || subtitleWidget != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ...?titleWidget == null ? null : [titleWidget],
                ...?subtitleWidget == null ? null : [const SizedBox(height: 2), subtitleWidget],
              ],
            ),
          )
        else
          const Spacer(),
        ?trailing,
        if (indicatorPosition == SelectableInputIndicatorPosition.trailing &&
            indicatorMode != SelectableInputIndicatorMode.none) ...[
          if (trailing != null) const SizedBox(width: 8),
          indicator,
        ],
      ],
    );
  }

  Widget _buildIndicator({
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    switch (indicatorMode) {
      case SelectableInputIndicatorMode.check:
        return Icon(
          isSelected ? Icons.check_circle : Icons.add_circle_outline,
          color: isSelected ? selectedColor : AppColors.gameBrown,
        );
      case SelectableInputIndicatorMode.radio:
        return AnimatedContainer(
          duration: animationDuration,
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? selectedColor : Colors.transparent,
            border: Border.all(
              color: isSelected ? selectedColor : unselectedColor,
              width: 2,
            ),
          ),
          child: isSelected
              ? const Icon(
                  Icons.check,
                  size: 16,
                  color: AppColors.primaryForeground,
                )
              : null,
        );
      case SelectableInputIndicatorMode.checkbox:
        return AnimatedContainer(
          duration: animationDuration,
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isSelected ? selectedColor : Colors.transparent,
            border: Border.all(
              color: isSelected ? selectedColor : unselectedColor,
              width: 2,
            ),
          ),
          child: isSelected
              ? const Icon(
                  Icons.check,
                  size: 16,
                  color: AppColors.primaryForeground,
                )
              : null,
        );
      case SelectableInputIndicatorMode.none:
        return const SizedBox.shrink();
    }
  }
}
