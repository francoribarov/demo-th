import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart';

/// Registration screen for new users.
class RegisterPage extends StatefulWidget {
  /// Creates the register page.
  const RegisterPage({super.key, this.from});

  /// Optional redirect path after authentication.
  final String? from;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.enabled,
    required this.autofillHint,
    required this.onChanged,
    this.onSubmitted,
    this.visibleNotifier,
  });

  final String label;
  final bool enabled;
  final String autofillHint;
  final ValueNotifier<bool>? visibleNotifier;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final notifier = visibleNotifier;

    return notifier == null
        ? TextField(
            enabled: enabled,
            obscureText: true,
            textInputAction: TextInputAction.next,
            autofillHints: [autofillHint],
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(labelText: label),
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          )
        : ValueListenableBuilder<bool>(
            valueListenable: notifier,
            builder: (context, visible, _) {
              return TextField(
                enabled: enabled,
                obscureText: !visible,
                textInputAction: TextInputAction.next,
                autofillHints: [autofillHint],
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  labelText: label,
                  suffixIcon: IconButton(
                    icon: Icon(
                      visible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => notifier.value = !visible,
                  ),
                ),
                onChanged: onChanged,
                onSubmitted: onSubmitted,
              );
            },
          );
  }
}

class _RegisterPageState extends State<RegisterPage> {
  late final ValueNotifier<bool> _passwordVisible;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.clearErrors());
    _passwordVisible = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _passwordVisible.dispose();
    super.dispose();
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
          title: const Text('Crear cuenta'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.popOrGo(AppRoutes.home),
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isSubmitting = state.isSubmittingRegister;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Empecemos',
                              style: AppTypography.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Creá tu cuenta para publicar y alquilar juegos.',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.gameBrown.withOpacityValue(
                                  0.7,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            AutofillGroup(
                              child: Column(
                                children: [
                                  TextField(
                                    enabled: !isSubmitting,
                                    textInputAction: TextInputAction.next,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    autofillHints: const [AutofillHints.name],
                                    decoration: const InputDecoration(
                                      labelText: 'Nombre',
                                    ),
                                    onChanged: (name) =>
                                        context.read<AuthBloc>().add(
                                              AuthEvent.registerUsernameChanged(
                                                name,
                                              ),
                                            ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    enabled: !isSubmitting,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    autocorrect: false,
                                    autofillHints: const [AutofillHints.email],
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      hintText: 'tu@email.com',
                                    ),
                                    onChanged: (email) => context
                                        .read<AuthBloc>()
                                        .add(
                                          AuthEvent.registerEmailChanged(email),
                                        ),
                                  ),
                                  const SizedBox(height: 12),
                                  _PasswordField(
                                    label: 'Contraseña',
                                    enabled: !isSubmitting,
                                    autofillHint: AutofillHints.newPassword,
                                    visibleNotifier: _passwordVisible,
                                    onChanged: (password) =>
                                        context.read<AuthBloc>().add(
                                              AuthEvent.registerPasswordChanged(
                                                password,
                                              ),
                                            ),
                                    onSubmitted: (_) {
                                      if (!isSubmitting) {
                                        context.read<AuthBloc>().add(
                                              const AuthEvent
                                                  .registerSubmitted(),
                                            );
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  _PasswordField(
                                    label: 'Repetí la contraseña',
                                    enabled: !isSubmitting,
                                    autofillHint: AutofillHints.newPassword,
                                    visibleNotifier: _passwordVisible,
                                    onChanged: (confirmPassword) =>
                                        context.read<AuthBloc>().add(
                                              AuthEvent
                                                  .registerPasswordConfirmChanged(
                                                confirmPassword,
                                              ),
                                            ),
                                    onSubmitted: (_) {
                                      if (!isSubmitting) {
                                        context.read<AuthBloc>().add(
                                              const AuthEvent
                                                  .registerSubmitted(),
                                            );
                                      }
                                    },
                                  ),
                                ],
                              ),
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
                              onPressed: isSubmitting
                                  ? null
                                  : () => context.read<AuthBloc>().add(
                                        const AuthEvent.registerSubmitted(),
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
                                  : const Text('Crear cuenta'),
                            ),
                            const SizedBox(height: 12),
                            TextButton(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
