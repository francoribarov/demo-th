import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';

/// Reusable alert dialog molecule. Use static methods to show.
class AppAlertDialog {
  AppAlertDialog._();

  /// Shows an alert with title only and "Entendido" button.
  static Future<void> showAlert(
    BuildContext context, {
    required String title,
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  /// Shows a confirmation dialog. Returns true when user confirms.
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String confirmText,
    String? content,
    String cancelText = 'Cancelar',
    VoidCallback? onConfirm,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
              onConfirm?.call();
            },
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor: AppColors.destructive,
                  )
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}
