import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Shared section header with optional subtitle and trailing widget.
class SectionHeaderBlock extends StatelessWidget {
  /// Creates a [SectionHeaderBlock].
  const SectionHeaderBlock({
    required this.title,
    super.key,
    this.subtitle,
    this.trailing,
    this.padding,
    this.titleStyle,
    this.subtitleStyle,
    this.gap = 4,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: titleStyle ?? AppTypography.titleMedium,
                ),
                if (subtitle != null) ...[
                  SizedBox(height: gap),
                  Text(
                    subtitle!,
                    style:
                        subtitleStyle ??
                        AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],
        ],
      ),
    );
  }
}
