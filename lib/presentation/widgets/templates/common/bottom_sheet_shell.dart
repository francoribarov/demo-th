import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';

/// Shared draggable bottom-sheet shell with header/body/footer slots.
class BottomSheetShell extends StatelessWidget {
  /// Creates a [BottomSheetShell].
  const BottomSheetShell({
    required this.title,
    required this.body,
    super.key,
    this.leading,
    this.trailing,
    this.footer,
    this.centerTitle = false,
    this.initialChildSize = 0.9,
    this.minChildSize = 0.5,
    this.maxChildSize = 0.95,
    this.contentPadding = const EdgeInsets.all(24),
  });

  final Widget title;
  final Widget body;
  final Widget? leading;
  final Widget? trailing;
  final Widget? footer;
  final bool centerTitle;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppTheme.radius3xl),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.gameBrown.withOpacityValue(0.1),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 96, child: leading ?? const SizedBox()),
                    Expanded(
                      child: centerTitle ? Center(child: title) : title,
                    ),
                    SizedBox(width: 96, child: trailing ?? const SizedBox()),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: contentPadding,
                  child: body,
                ),
              ),
              ?footer,
            ],
          ),
        );
      },
    );
  }
}
