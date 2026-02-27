import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/button_loading_indicator.dart';

/// Primary action button using theme styling. Supports loading state.
class AppPrimaryButton extends StatelessWidget {
  /// Creates an [AppPrimaryButton].
  const AppPrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.loadingChild,
    this.icon,
    this.minimumSize,
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

  /// Optional minimum size (e.g. Size(double.infinity, 56) for full width).
  final Size? minimumSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: minimumSize != null ? ElevatedButton.styleFrom(minimumSize: minimumSize) : null,
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
