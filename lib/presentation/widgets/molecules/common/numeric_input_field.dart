import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

/// Shared numeric text form input with parsed integer callback.
class NumericInputField extends StatelessWidget {
  /// Creates a [NumericInputField].
  const NumericInputField({
    super.key,
    this.controller,
    this.initialValue,
    this.validator,
    this.autovalidateMode,
    this.focusNode,
    this.textInputAction,
    this.prefixText,
    this.suffixText,
    this.hintText,
    this.labelText,
    this.helperText,
    this.enabled,
    this.onChanged,
    this.onChangedValue,
    this.inputFormatters,
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
  final String? prefixText;
  final String? suffixText;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final bool? enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<int?>? onChangedValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputVisualVariant variant;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormInputField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: TextInputType.number,
      prefixText: prefixText,
      suffixText: suffixText,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      enabled: enabled,
      variant: variant,
      isDense: isDense,
      contentPadding: contentPadding,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        onChanged?.call(value);
        onChangedValue?.call(int.tryParse(value.trim()));
      },
    );
  }
}
