import 'package:flutter/material.dart';

/// Generic text field for authentication forms.
class AuthTextField extends StatelessWidget {
  /// Creates an auth text field.
  const AuthTextField({
    required this.label,
    required this.onChanged,
    super.key,
    this.enabled = true,
    this.hintText,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.autocorrect = true,
  });

  /// Label text for the field.
  final String label;

  /// Callback when text changes.
  final ValueChanged<String> onChanged;

  /// Whether the field is enabled.
  final bool enabled;

  /// Optional hint text.
  final String? hintText;

  /// Keyboard type for input.
  final TextInputType? keyboardType;

  /// Text capitalization behavior.
  final TextCapitalization textCapitalization;

  /// Autofill hints for the field.
  final Iterable<String>? autofillHints;

  /// Whether to enable autocorrect.
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      textInputAction: TextInputAction.next,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
      ),
      onChanged: onChanged,
    );
  }
}
