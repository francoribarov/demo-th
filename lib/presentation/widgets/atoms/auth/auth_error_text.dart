import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/inline_feedback_text.dart';

/// Error text widget for authentication forms.
///
/// Prefer [InlineFeedbackText] with [InlineFeedbackTone.error] and
/// `padding: EdgeInsets.only(top: AppTheme.spacingMd)`.
class AuthErrorText extends StatelessWidget {
  /// Creates an auth error text widget.
  const AuthErrorText({
    required this.message,
    super.key,
  });

  /// The error message to display.
  final String message;

  @override
  Widget build(BuildContext context) {
    return InlineFeedbackText(
      message: message,
      padding: const EdgeInsets.only(top: AppTheme.spacingMd),
    );
  }
}
