import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

/// Navigation bar used by wizard scaffolds to show next/previous steps.
class WizardNavigationBar extends StatelessWidget {
  /// Creates a [WizardNavigationBar].
  const WizardNavigationBar({
    required this.primaryLabel,
    this.onPrimaryPressed,
    this.secondaryLabel,
    this.onSecondaryPressed,
    this.isSubmitting = false,
    this.submittingChild,
    this.extendBottomSafeArea = true,
    super.key,
  });

  /// The label for the primary button.
  final String primaryLabel;

  /// Callback when primary button is pressed.
  final VoidCallback? onPrimaryPressed;

  /// The label for the secondary button. If null or empty, it won't be shown.
  final String? secondaryLabel;

  /// Callback when secondary button is pressed.
  final VoidCallback? onSecondaryPressed;

  /// Whether the primary button is in a loading state.
  final bool isSubmitting;

  /// Optional widget to display when [isSubmitting] is true.
  final Widget? submittingChild;

  /// Whether to include SafeArea at the bottom.
  final bool extendBottomSafeArea;

  @override
  Widget build(BuildContext context) {
    final hasSecondary =
        secondaryLabel != null &&
        secondaryLabel!.isNotEmpty &&
        onSecondaryPressed != null;

    final child = Row(
      children: [
        if (hasSecondary)
          Expanded(
            child: AppSecondaryButton(
              label: secondaryLabel!,
              onPressed: onSecondaryPressed,
              isLoading: isSubmitting,
            ),
          ),
        if (hasSecondary) const SizedBox(width: AppTheme.spacingLg),
        Expanded(
          child: AppPrimaryButton(
            label: primaryLabel,
            onPressed: onPrimaryPressed,
            isLoading: isSubmitting,
            loadingChild: submittingChild,
          ),
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(
          top: BorderSide(
            color: AppColors.gameBrown.withOpacityValue(0.1),
          ),
        ),
      ),
      child: extendBottomSafeArea ? SafeArea(top: false, child: child) : child,
    );
  }
}
