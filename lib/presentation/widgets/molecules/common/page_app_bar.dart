import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';

/// Leading behavior variants for [PageAppBar].
enum PageAppBarLeadingType {
  /// Back navigation icon.
  back,

  /// Close icon for dismiss flows.
  close,

  /// No leading widget.
  none,
}

/// Shared regular app bar for page-level top navigation.
class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [PageAppBar].
  const PageAppBar({
    required this.title,
    super.key,
    this.leadingType = PageAppBarLeadingType.back,
    this.onLeadingPressed,
    this.actions,
    this.centerTitle,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.bottom,
  });

  final Widget title;
  final PageAppBarLeadingType leadingType;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    final leadingIcon = switch (leadingType) {
      PageAppBarLeadingType.back => Icons.arrow_back,
      PageAppBarLeadingType.close => Icons.close,
      PageAppBarLeadingType.none => null,
    };

    return AppBar(
      title: title,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      bottom: bottom,
      leading: leadingIcon == null
          ? null
          : IconButton(
              icon: Icon(leadingIcon),
              color: foregroundColor ?? AppColors.gameBrown,
              onPressed: onLeadingPressed,
            ),
      automaticallyImplyLeading: leadingType != PageAppBarLeadingType.none,
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
