import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';

/// Shared app-bar icon action with optional circular background style.
///
/// For accessibility, pass [tooltip] or [semanticLabel] so screen readers
/// can announce a meaningful label for icon-only buttons.
class AppBarIconAction extends StatelessWidget {
  /// Creates an [AppBarIconAction].
  const AppBarIconAction({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.semanticLabel,
    this.iconColor,
    this.backgroundColor,
    this.withCircularBackground = false,
    this.padding = const EdgeInsets.all(AppTheme.spacingSm),
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? semanticLabel;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool withCircularBackground;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final actionIcon = Icon(
      icon,
      color: iconColor ?? AppColors.gameBrown,
    );

    final iconWidget = withCircularBackground
        ? Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.card.withOpacityValue(0.9),
              shape: BoxShape.circle,
            ),
            child: actionIcon,
          )
        : actionIcon;

    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Semantics(
        label: semanticLabel,
        button: true,
        child: iconWidget,
      ),
    );
  }
}
