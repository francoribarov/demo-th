import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/presentation/widgets/atoms/common/app_bar_icon_action.dart';

/// Shared sliver app bar wrapper for publication detail-like headers.
class SliverPageAppBar extends StatelessWidget {
  /// Creates a [SliverPageAppBar].
  const SliverPageAppBar({
    required this.background,
    required this.onLeadingPressed,
    super.key,
    this.actions,
    this.leadingIcon = Icons.arrow_back,
    this.expandedHeight = 320,
    this.pinned = true,
  });

  final Widget background;
  final VoidCallback onLeadingPressed;
  final List<Widget>? actions;
  final IconData leadingIcon;
  final double expandedHeight;
  final bool pinned;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: pinned,
      leading: AppBarIconAction(
        icon: leadingIcon,
        onPressed: onLeadingPressed,
        withCircularBackground: true,
      ),
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(background: background),
    );
  }
}
