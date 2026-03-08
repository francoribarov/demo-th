import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/button_loading_indicator.dart';

/// Secondary action button using theme styling. Supports loading state.
class AppSecondaryButton extends StatelessWidget {
  /// Creates an [AppSecondaryButton].
  const AppSecondaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.loadingChild,
    this.icon,
    this.minimumSize,
    this.style,
  });

  /// Button label text.
  final String label;

  /// Callback when pressed.
  final VoidCallback? onPressed;

  /// Whether the button shows loading indicator.
  final bool isLoading;

  /// Optional custom widget when loading (defaults to [ButtonLoadingIndicator]).
  final Widget? loadingChild;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional minimum size.
  final Size? minimumSize;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final minimumSizeStyle = minimumSize == null
        ? null
        : OutlinedButton.styleFrom(minimumSize: minimumSize);
    final resolvedStyle = style == null
        ? minimumSizeStyle
        : style!.merge(minimumSizeStyle);

    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: resolvedStyle,
      child: isLoading
          ? (loadingChild ?? const ButtonLoadingIndicator())
          : icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: AppTheme.spacingSm),
                Text(label),
              ],
            )
          : Text(label),
    );
  }
}
