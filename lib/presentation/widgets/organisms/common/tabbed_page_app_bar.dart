import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';

/// Shared app bar with embedded styled tab selector.
class TabbedPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [TabbedPageAppBar].
  const TabbedPageAppBar({
    required this.title,
    required this.tabs,
    super.key,
    this.backgroundColor = AppColors.background,
    this.foregroundColor = AppColors.foreground,
    this.centerTitle = true,
    this.elevation = 0,
  });

  final Widget title;
  final List<Widget> tabs;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool centerTitle;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return PageAppBar(
      title: title,
      leadingType: PageAppBarLeadingType.none,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      centerTitle: centerTitle,
      elevation: elevation,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.gameBrown.withOpacityValue(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            ),
            child: TabBar(
              tabs: tabs,
              indicator: BoxDecoration(
                color: AppColors.gameRust,
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.gameBrown,
              dividerColor: Colors.transparent,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 64);
}
