import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/di/injection.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

/// Personal profile tab page.
class ProfilePage extends StatelessWidget {
  /// Creates the profile page.
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Configuración de tu perfil.'),
            const SizedBox(height: 32),
            AppPrimaryButton(
              onPressed: () {
                getIt<AuthBloc>().add(const AuthEvent.logoutRequested());
              },
              icon: Icons.logout,
              label: 'Cerrar Sesión',
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.destructive,
                foregroundColor: AppColors.primaryForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
