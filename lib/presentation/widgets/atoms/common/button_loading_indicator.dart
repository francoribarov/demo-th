import 'package:flutter/material.dart';

/// Shared loading indicator for button content.
class ButtonLoadingIndicator extends StatelessWidget {
  /// Creates a [ButtonLoadingIndicator].
  const ButtonLoadingIndicator({
    super.key,
    this.size = 18,
    this.strokeWidth = 2,
    this.color = Colors.white,
  });

  final double size;
  final double strokeWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color,
      ),
    );
  }
}
