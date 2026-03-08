import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

/// Shared [TextField] with the standard input decoration variants.
class TextInputField extends StatelessWidget {
  /// Creates a [TextInputField].
  const TextInputField({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.suffixIcon,
    this.helperText,
    this.hintText,
    this.labelText,
    this.enabled,
    this.readOnly = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.variant = TextInputVisualVariant.surface,
    this.isDense,
    this.contentPadding,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final bool? enabled;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final TextCapitalization textCapitalization;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextInputVisualVariant variant;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      inputFormatters: inputFormatters,
      enabled: enabled,
      readOnly: readOnly,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      textCapitalization: textCapitalization,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      decoration: buildTextInputDecoration(
        variant: variant,
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        prefixText: prefixText,
        suffixText: suffixText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        isDense: isDense,
        contentPadding: contentPadding,
      ),
    );
  }
}
