import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';

/// Feedback tone variants for [FeedbackMessenger].
enum FeedbackMessageTone {
  success,
  error,
  warning,
  info,
}

/// Shared snackbar helper for user-facing feedback messages.
class FeedbackMessenger {
  FeedbackMessenger._();

  /// Shows a snackbar message with the provided [tone].
  static void show(
    BuildContext context, {
    required String message,
    FeedbackMessageTone tone = FeedbackMessageTone.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final icon = _leadingIcon(tone);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: icon != null
              ? Row(
                  children: [
                    Icon(icon, color: AppColors.card, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(message)),
                  ],
                )
              : Text(message),
          duration: duration,
          backgroundColor: _backgroundColor(tone),
        ),
      );
  }

  /// Shows a success feedback snackbar.
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      tone: FeedbackMessageTone.success,
      duration: duration,
    );
  }

  /// Shows an error feedback snackbar.
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      tone: FeedbackMessageTone.error,
      duration: duration,
    );
  }

  /// Shows a warning feedback snackbar.
  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      tone: FeedbackMessageTone.warning,
      duration: duration,
    );
  }

  /// Shows an informational feedback snackbar.
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      duration: duration,
    );
  }

  static Color? _backgroundColor(
    FeedbackMessageTone tone,
  ) {
    return switch (tone) {
      FeedbackMessageTone.success =>
        AppColors.gameSage,
      FeedbackMessageTone.error =>
        AppColors.destructive,
      FeedbackMessageTone.warning =>
        AppColors.warning,
      FeedbackMessageTone.info => null,
    };
  }

  static IconData? _leadingIcon(
    FeedbackMessageTone tone,
  ) {
    return switch (tone) {
      FeedbackMessageTone.success =>
        Icons.check_circle_rounded,
      FeedbackMessageTone.error =>
        Icons.error_outline_rounded,
      FeedbackMessageTone.warning =>
        Icons.warning_amber_rounded,
      FeedbackMessageTone.info => null,
    };
  }
}
