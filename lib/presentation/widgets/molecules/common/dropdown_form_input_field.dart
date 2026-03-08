import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

/// Shared dropdown form input aligned with text input styles.
class DropdownFormInputField<T> extends StatelessWidget {
  /// Creates a [DropdownFormInputField].
  const DropdownFormInputField({
    required this.items,
    super.key,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.hintText,
    this.labelText,
    this.helperText,
    this.enabled,
    this.selectedItemBuilder,
    this.isExpanded = true,
    this.variant = TextInputVisualVariant.surface,
    this.isDense,
    this.contentPadding,
  });

  final T? initialValue;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final AutovalidateMode? autovalidateMode;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final bool? enabled;
  final DropdownButtonBuilder? selectedItemBuilder;
  final bool isExpanded;
  final TextInputVisualVariant variant;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: initialValue,
      items: items,
      onChanged: enabled == false ? null : onChanged,
      validator: validator,
      autovalidateMode: autovalidateMode,
      selectedItemBuilder: selectedItemBuilder,
      isExpanded: isExpanded,
      decoration: buildTextInputDecoration(
        variant: variant,
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        isDense: isDense,
        contentPadding: contentPadding,
      ),
    );
  }
}
