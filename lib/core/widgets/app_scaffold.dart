import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/rental_request.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/bloc/rental_requests_bloc.dart';

/// Main scaffold with bottom navigation.
/// Matches the Layout component from the Vite.js prototype.
class AppScaffold extends StatelessWidget {
  /// Creates an [AppScaffold] with the provided [child].
  const AppScaffold({required this.child, super.key});

  /// Content rendered above the bottom navigation bar.
  final Widget child;

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location == AppRoutes.home) return 0;
    if (location == AppRoutes.myGames) return 1;
    if (location == AppRoutes.publish) return 2;
    if (location == AppRoutes.profile) return 3;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        return;
      case 1:
        context.go(AppRoutes.myGames);
        return;
      case 2:
        context.go(AppRoutes.publish);
        return;
      case 3:
        context.go(AppRoutes.profile);
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          border: const Border(
            top: BorderSide(color: AppColors.gameRust, width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacityValue(0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
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
                  onTap: () => _onItemTapped(context, 0),
                ),
                BlocBuilder<RentalRequestsBloc, RentalRequestsState>(
                  builder: (context, state) {
                    final pendingCount = state.maybeWhen(
                      success: (requests) => requests
                          .where(
                            (r) => r.status == RentalRequestStatus.pending,
                          )
                          .length,
                      orElse: () => 0,
                    );

                    return _NavItem(
                      icon: Icons.casino_outlined,
                      activeIcon: Icons.casino,
                      label: 'Mis Juegos',
                      isSelected: selectedIndex == 1,
                      badgeCount: pendingCount,
                      onTap: () => _onItemTapped(context, 1),
                    );
                  },
                ),
                _NavItem(
                  icon: Icons.add_circle_outline,
                  activeIcon: Icons.add_circle,
                  label: 'Publicar',
                  isSelected: selectedIndex == 2,
                  onTap: () => _onItemTapped(context, 2),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Perfil',
                  isSelected: selectedIndex == 3,
                  onTap: () => _onItemTapped(context, 3),
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
    this.badgeCount = 0,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
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
                if (badgeCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
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
