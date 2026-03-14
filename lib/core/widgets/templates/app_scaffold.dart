import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Main scaffold with bottom navigation.
///
/// This widget is purely presentational. Navigation logic (including auth
/// guards) is the caller's responsibility via [onItemTapped].
class AppScaffold extends StatelessWidget {
  /// Creates an [AppScaffold] with the provided [navigationShell].
  const AppScaffold({
    required this.navigationShell,
    required this.onItemTapped,
    super.key,
  });

  /// Shell that holds the navigation branches.
  final StatefulNavigationShell navigationShell;

  /// Called when a bottom-nav item is tapped. Receives the branch index.
  final void Function(int index) onItemTapped;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          border: const Border(
            top: BorderSide(color: AppColors.border),
          ),
          boxShadow: AppTheme.shadowUp,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Inicio',
                  isSelected: selectedIndex == 0,
                  onTap: () => onItemTapped(0),
                ),
                _NavItem(
                  icon: Icons.casino_outlined,
                  activeIcon: Icons.casino,
                  label: 'Mis Publicaciones',
                  isSelected: selectedIndex == 1,
                  onTap: () => onItemTapped(1),
                ),
                _NavItem(
                  icon: Icons.add_circle_outline,
                  activeIcon: Icons.add_circle,
                  label: 'Publicar',
                  isSelected: selectedIndex == 2,
                  onTap: () => onItemTapped(2),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Perfil',
                  isSelected: selectedIndex == 3,
                  onTap: () => onItemTapped(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? activeIcon : icon,
                  size: 24,
                  color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
