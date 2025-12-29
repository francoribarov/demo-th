import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart';

/// Registration screen for new users.
class RegisterPage extends StatelessWidget {
  /// Creates the register page.
  const RegisterPage({super.key, this.from});

  /// Optional redirect path after authentication.
  final String? from;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status && current.isAuthenticated,
      listener: (context, state) {
        final redirectTo = from;
        if (redirectTo != null && redirectTo.trim().isNotEmpty) {
          context.go(redirectTo);
        } else {
          context.goHome();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear cuenta'),
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final isBusy = state.isSubmittingRegister || state.isCheckingStatus;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Empecemos', style: AppTypography.headlineMedium, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text(
                      'Creá tu cuenta para publicar y alquilar juegos.',
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      enabled: !isBusy,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      onChanged: (v) => context.read<AuthBloc>().add(AuthEvent.registerNameChanged(v)),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      enabled: !isBusy,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email', hintText: 'tu@email.com'),
                      onChanged: (v) => context.read<AuthBloc>().add(AuthEvent.registerEmailChanged(v)),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      enabled: !isBusy,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Contraseña'),
                      onChanged: (v) => context.read<AuthBloc>().add(AuthEvent.registerPasswordChanged(v)),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      enabled: !isBusy,
                      decoration: const InputDecoration(
                        labelText: 'Ubicación (opcional)',
                        hintText: 'Ej: Montevideo, Uruguay',
                      ),
                      onChanged: (v) => context.read<AuthBloc>().add(AuthEvent.registerLocationChanged(v)),
                    ),
                    if (state.registerErrorMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        state.registerErrorMessage!,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.destructive,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    if (state.errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        state.errorMessage!,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.destructive,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const Spacer(),
                    ElevatedButton(
                      onPressed: isBusy
                          ? null
                          : () => context.read<AuthBloc>().add(const AuthEvent.registerSubmitted()),
                      child: isBusy
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Crear cuenta'),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: isBusy
                          ? null
                          : () {
                              final encodedFrom = from != null ? Uri.encodeComponent(from!) : null;
                              final query = encodedFrom != null ? '?from=$encodedFrom' : '';
                              context.go('${AppRoutes.login}$query');
                            },
                      child: const Text('Ya tengo cuenta'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
