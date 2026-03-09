import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';

/// Visual variants for shared input controls.
enum TextInputVisualVariant {
  /// Default app inputs.
  surface,

  /// Subtle edit-flow style inputs.
  subtle,
}

/// Builds the shared input decoration used by input molecules.
InputDecoration buildTextInputDecoration({
  required TextInputVisualVariant variant,
  String? labelText,
  String? hintText,
  String? helperText,
  String? prefixText,
  String? suffixText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool? isDense,
  EdgeInsetsGeometry? contentPadding,
}) {
  final radius = variant == TextInputVisualVariant.surface ? AppTheme.radius2xl : AppTheme.radiusMd;

  final fillColor = variant == TextInputVisualVariant.surface ? AppColors.card : AppColors.background;

  final borderColor = variant == TextInputVisualVariant.surface
      ? AppColors.gameBrown.withOpacityValue(0.2)
      : AppColors.border;

  OutlineInputBorder border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    helperText: helperText,
    prefixText: prefixText,
    suffixText: suffixText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    isDense: isDense,
    contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    filled: true,
    fillColor: fillColor,
    border: border(borderColor),
    enabledBorder: border(borderColor),
    focusedBorder: border(AppColors.gameRust, width: 2),
    errorBorder: border(AppColors.destructive),
    focusedErrorBorder: border(AppColors.destructive, width: 2),
    errorMaxLines: 3,
  );
}

/// Shared text form input with unified styling variants.
class TextFormInputField extends StatelessWidget {
  /// Creates a [TextFormInputField].
  const TextFormInputField({
    super.key,
    this.controller,
    this.initialValue,
    this.validator,
    this.autovalidateMode,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.autofillHints,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.suffixIcon,
    this.helperText,
    this.hintText,
    this.labelText,
    this.enabled,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.variant = TextInputVisualVariant.surface,
    this.isDense,
    this.contentPadding,
  }) : assert(
         controller == null || initialValue == null,
         'controller and initialValue cannot both be provided.',
       );

  final TextEditingController? controller;
  final String? initialValue;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final bool? enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;
  final TextCapitalization textCapitalization;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextInputVisualVariant variant;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      enabled: enabled,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
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
