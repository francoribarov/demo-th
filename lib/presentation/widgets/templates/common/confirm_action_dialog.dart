import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

/// Shared confirm/cancel action dialog.
class ConfirmActionDialog {
  ConfirmActionDialog._();

  /// Shows a confirmation dialog and returns `true` on confirm.
  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          AppSecondaryButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            label: cancelLabel,
          ),
          AppPrimaryButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            label: confirmLabel,
            style: isDestructive
                ? ElevatedButton.styleFrom(
                    backgroundColor: AppColors.destructive,
                    foregroundColor: AppColors.destructiveForeground,
                  )
                : null,
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
