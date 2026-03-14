import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/presentation/widgets/atoms/common/app_primary_button.dart';

/// Submit button with loading state for authentication forms.
/// Uses [AppPrimaryButton] for consistent styling.
class AuthSubmitButton extends StatelessWidget {
  /// Creates an auth submit button.
  const AuthSubmitButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isLoading = false,
  });

  /// Button label text.
  final String label;

  /// Callback when button is pressed.
  final VoidCallback onPressed;

  /// Whether the button is in loading state.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }
}
