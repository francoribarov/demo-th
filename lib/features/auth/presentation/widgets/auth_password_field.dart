import 'package:flutter/material.dart';

/// Password field with visibility toggle for authentication forms.
class AuthPasswordField extends StatelessWidget {
  /// Creates an auth password field.
  const AuthPasswordField({
    required this.label,
    required this.onChanged,
    super.key,
    this.enabled = true,
    this.autofillHint = AutofillHints.password,
    this.visibleNotifier,
    this.onSubmitted,
  });

  /// Label text for the field.
  final String label;

  /// Callback when text changes.
  final ValueChanged<String> onChanged;

  /// Whether the field is enabled.
  final bool enabled;

  /// Autofill hint for the field.
  final String autofillHint;

  /// Notifier for password visibility state. If null, no toggle is shown.
  final ValueNotifier<bool>? visibleNotifier;

  /// Callback when submitted.
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final notifier = visibleNotifier;

    if (notifier == null) {
      return _buildField(obscure: true);
    }

    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (context, visible, _) {
        return _buildField(
          obscure: !visible,
          toggleButton: IconButton(
            icon: Icon(visible ? Icons.visibility_off : Icons.visibility),
            onPressed: () => notifier.value = !visible,
          ),
        );
      },
    );
  }

  Widget _buildField({required bool obscure, Widget? toggleButton}) {
    return TextField(
      enabled: enabled,
      obscureText: obscure,
      textInputAction: TextInputAction.next,
      autofillHints: [autofillHint],
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: toggleButton,
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
