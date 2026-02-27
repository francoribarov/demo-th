import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/app_primary_button.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/app_secondary_button.dart';

/// Grouped actions for [StateFeedbackView] to reduce prop count.
class StateFeedbackActions {
  const StateFeedbackActions({
    this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
}

/// Feedback variants for [StateFeedbackView].
enum StateFeedbackVariant {
  /// Loading state content.
  loading,

  /// Empty state content.
  empty,

  /// Error state content.
  error,
}

/// Shared loading/empty/error content template.
class StateFeedbackView extends StatelessWidget {
  /// Creates a [StateFeedbackView].
  const StateFeedbackView({
    required this.variant,
    super.key,
    this.title,
    this.message,
    this.icon,
    this.leading,
    this.actions,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.padding = const EdgeInsets.all(AppTheme.spacing3xl),
    this.titleStyle,
    this.messageStyle,
    this.textAlign = TextAlign.center,
    this.spacing = AppTheme.spacingLg,
  });

  final StateFeedbackVariant variant;
  final String? title;
  final String? message;
  final IconData? icon;
  final Widget? leading;
  final StateFeedbackActions? actions;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final EdgeInsetsGeometry padding;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final TextAlign textAlign;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (variant == StateFeedbackVariant.loading) {
      return Center(
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              leading ?? const CircularProgressIndicator(color: AppColors.gameRust),
              if (title != null) ...[
                SizedBox(height: spacing),
                Text(
                  title!,
                  style: titleStyle ?? AppTypography.titleMedium,
                  textAlign: textAlign,
                ),
              ],
              if (message != null) ...[
                const SizedBox(height: AppTheme.spacingSm),
                Text(
                  message!,
                  style:
                      messageStyle ??
                      AppTypography.bodyMedium.copyWith(
                        color: AppColors.mutedForeground,
                      ),
                  textAlign: textAlign,
                ),
              ],
            ],
          ),
        ),
      );
    }

    final primaryLabel = actions?.primaryLabel ?? primaryActionLabel;
    final onPrimary = actions?.onPrimary ?? onPrimaryAction;
    final secondaryLabel = actions?.secondaryLabel ?? secondaryActionLabel;
    final onSecondary = actions?.onSecondary ?? onSecondaryAction;

    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            leading ??
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingXl),
                  decoration: BoxDecoration(
                    color: (variant == StateFeedbackVariant.error ? AppColors.error : AppColors.gameCream)
                        .withOpacityValue(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon ?? (variant == StateFeedbackVariant.error ? Icons.error_outline : Icons.inbox_outlined),
                    size: 48,
                    color: variant == StateFeedbackVariant.error ? AppColors.error : AppColors.gameBrown,
                  ),
                ),
            if (title != null) ...[
              SizedBox(height: spacing),
              Text(
                title!,
                style: titleStyle ?? AppTypography.titleLarge,
                textAlign: textAlign,
              ),
            ],
            if (message != null) ...[
              const SizedBox(height: AppTheme.spacingSm),
              Text(
                message!,
                style:
                    messageStyle ??
                    AppTypography.bodyMedium.copyWith(
                      color: AppColors.mutedForeground,
                    ),
                textAlign: textAlign,
              ),
            ],
            if (primaryLabel != null && onPrimary != null) ...[
              SizedBox(height: spacing + AppTheme.spacingSm),
              Semantics(
                label: 'Acción principal: $primaryLabel',
                button: true,
                child: AppPrimaryButton(
                  label: primaryLabel,
                  onPressed: onPrimary,
                ),
              ),
            ],
            if (secondaryLabel != null && onSecondary != null) ...[
              const SizedBox(height: AppTheme.spacingMd),
              Semantics(
                label: 'Acción secundaria: $secondaryLabel',
                button: true,
                child: AppSecondaryButton(
                  label: secondaryLabel,
                  onPressed: onSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
