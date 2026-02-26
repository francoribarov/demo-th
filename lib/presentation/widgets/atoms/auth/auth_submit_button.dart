import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/presentation/widgets/atoms/common/button_loading_indicator.dart';

/// Submit button with loading state for authentication forms.
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
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? const ButtonLoadingIndicator() : Text(label),
    );
  }
}
