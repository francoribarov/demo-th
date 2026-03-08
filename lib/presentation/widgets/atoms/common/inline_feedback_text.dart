import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Feedback tone variants for [InlineFeedbackText].
enum InlineFeedbackTone {
  error,
  success,
  warning,
  info,
}

/// Shared inline feedback text widget for validation and status messages.
class InlineFeedbackText extends StatelessWidget {
  /// Creates an [InlineFeedbackText].
  const InlineFeedbackText({
    required this.message,
    super.key,
    this.tone = InlineFeedbackTone.error,
    this.textAlign = TextAlign.start,
    this.padding,
    this.style,
  });

  final String message;
  final InlineFeedbackTone tone;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      InlineFeedbackTone.error => AppColors.destructive,
      InlineFeedbackTone.success => AppColors.success,
      InlineFeedbackTone.warning => AppColors.gameRust,
      InlineFeedbackTone.info => AppColors.mutedForeground,
    };

    final baseStyle = AppTypography.bodySmall.copyWith(
      color: color,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        message,
        textAlign: textAlign,
        style: style == null ? baseStyle : baseStyle.merge(style),
      ),
    );
  }
}
