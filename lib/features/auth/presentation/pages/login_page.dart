import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart';

/// Login screen for email/password authentication.
class LoginPage extends StatefulWidget {
  /// Creates the login page.
  const LoginPage({super.key, this.from});

  /// Optional redirect path after authentication.
  final String? from;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.clearErrors());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.status != current.status && current.isAuthenticated,
      listener: (context, state) {
        final redirectTo = widget.from;
        if (redirectTo != null &&
            redirectTo.trim().isNotEmpty &&
            !redirectTo.contains(AppRoutes.login) &&
            !redirectTo.contains(AppRoutes.register)) {
          context.go(redirectTo);
        } else {
          context.goHome();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Iniciar sesión'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.popOrGo(AppRoutes.home),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final isSubmitting = state.isSubmittingLogin;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Bienvenido/a',
                      style: AppTypography.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ingresá tus datos para continuar.',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.gameBrown.withOpacityValue(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    AutofillGroup(
                      child: Column(
                        children: [
                          TextField(
                            enabled: !isSubmitting,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.email],
                            autocorrect: false,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'tu@email.com',
                            ),
                            onChanged: (email) => context.read<AuthBloc>().add(
                                  AuthEvent.loginEmailChanged(email),
                                ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            enabled: !isSubmitting,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                            ),
                            onChanged: (password) =>
                                context.read<AuthBloc>().add(
                                      AuthEvent.loginPasswordChanged(password),
                                    ),
                            onSubmitted: (_) {
                              if (!isSubmitting) {
                                context.read<AuthBloc>().add(
                                      const AuthEvent.loginSubmitted(),
                                    );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    if (state.loginErrorMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        state.loginErrorMessage!,
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
                      onPressed: isSubmitting
                          ? null
                          : () => context.read<AuthBloc>().add(
                                const AuthEvent.loginSubmitted(),
                              ),
                      child: isSubmitting
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Ingresar'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: isSubmitting
                          ? null
                          : () {
                              final from = widget.from;
                              final encodedFrom = from != null
                                  ? Uri.encodeComponent(from)
                                  : null;
                              final query = encodedFrom != null
                                  ? '?from=$encodedFrom'
                                  : '';
                              context.go('${AppRoutes.register}$query');
                            },
                      child: const Text('Crear cuenta'),
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
