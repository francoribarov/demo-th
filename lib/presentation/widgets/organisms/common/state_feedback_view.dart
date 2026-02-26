import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

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
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.padding = const EdgeInsets.all(32),
    this.titleStyle,
    this.messageStyle,
    this.primaryActionStyle,
    this.secondaryActionStyle,
    this.textAlign = TextAlign.center,
    this.spacing = 16,
  });

  final StateFeedbackVariant variant;
  final String? title;
  final String? message;
  final IconData? icon;
  final Widget? leading;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final EdgeInsetsGeometry padding;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final ButtonStyle? primaryActionStyle;
  final ButtonStyle? secondaryActionStyle;
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
              leading ??
                  const CircularProgressIndicator(color: AppColors.gameRust),
              if (title != null) ...[
                SizedBox(height: spacing),
                Text(
                  title!,
                  style: titleStyle ?? AppTypography.titleMedium,
                  textAlign: textAlign,
                ),
              ],
              if (message != null) ...[
                const SizedBox(height: 8),
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

    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            leading ??
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        (variant == StateFeedbackVariant.error
                                ? AppColors.error
                                : AppColors.gameCream)
                            .withOpacityValue(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon ??
                        (variant == StateFeedbackVariant.error
                            ? Icons.error_outline
                            : Icons.inbox_outlined),
                    size: 48,
                    color: variant == StateFeedbackVariant.error
                        ? AppColors.error
                        : AppColors.gameBrown,
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
              const SizedBox(height: 8),
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
            if (primaryActionLabel != null && onPrimaryAction != null) ...[
              SizedBox(height: spacing + 8),
              ElevatedButton(
                onPressed: onPrimaryAction,
                style: primaryActionStyle,
                child: Text(primaryActionLabel!),
              ),
            ],
            if (secondaryActionLabel != null && onSecondaryAction != null) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: onSecondaryAction,
                style: secondaryActionStyle,
                child: Text(secondaryActionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
