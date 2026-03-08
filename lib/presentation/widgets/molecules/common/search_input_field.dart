import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_input_field.dart';

/// Search-specific input with built-in prefix icon and optional clear action.
class SearchInputField extends StatelessWidget {
  /// Creates a [SearchInputField].
  const SearchInputField({
    required this.controller,
    super.key,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.enabled,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onClear,
    this.variant = TextInputVisualVariant.surface,
    this.textInputAction = TextInputAction.search,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? labelText;
  final bool? enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final TextInputVisualVariant variant;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return TextInputField(
          controller: controller,
          focusNode: focusNode,
          hintText: hintText,
          labelText: labelText,
          enabled: enabled,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onTap: onTap,
          textInputAction: textInputAction,
          variant: variant,
          prefixIcon: const Icon(Icons.search, color: AppColors.gameBrown),
          suffixIcon: value.text.trim().isEmpty
              ? null
              : IconButton(
                  onPressed: onClear,
                  icon: const Icon(Icons.clear),
                  tooltip: 'Limpiar búsqueda',
                ),
        );
      },
    );
  }
}
