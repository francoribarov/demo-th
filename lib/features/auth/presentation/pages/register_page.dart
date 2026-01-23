import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_table_hopping/features/auth/presentation/widgets/auth_error_text.dart';
import 'package:mobile_table_hopping/features/auth/presentation/widgets/auth_header.dart';
import 'package:mobile_table_hopping/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:mobile_table_hopping/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:mobile_table_hopping/features/auth/presentation/widgets/auth_text_field.dart';

/// Registration screen for new users.
class RegisterPage extends StatefulWidget {
  /// Creates the register page.
  const RegisterPage({super.key, this.from});

  /// Optional redirect path after authentication.
  final String? from;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
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

  void _onSubmit() {
    context.read<AuthBloc>().add(const AuthEvent.registerSubmitted());
  }

  void _navigateToLogin() {
    final from = widget.from;
    final encodedFrom = from != null ? Uri.encodeComponent(from) : null;
    final query = encodedFrom != null ? '?from=$encodedFrom' : '';
    context.go('${AppRoutes.login}$query');
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
                      child: _RegisterForm(
                    passwordVisible: _passwordVisible,
                    onSubmit: _onSubmit,
                    onNavigateToLogin: _navigateToLogin,
                  )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({
    required this.passwordVisible,
    required this.onSubmit,
    required this.onNavigateToLogin,
  });

  final ValueNotifier<bool> passwordVisible;
  final VoidCallback onSubmit;
  final VoidCallback onNavigateToLogin;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isSubmitting = state.isSubmittingRegister;
        final authBloc = context.read<AuthBloc>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(
              title: 'Empecemos',
              subtitle: 'Creá tu cuenta para publicar y alquilar juegos.',
            ),
            const SizedBox(height: 24),
            AutofillGroup(
              child: Column(
                children: [
                  AuthTextField(
                    label: 'Nombre',
                    enabled: !isSubmitting,
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.name],
                    onChanged: (name) =>
                        authBloc.add(AuthEvent.registerUsernameChanged(name)),
                  ),
                  const SizedBox(height: 12),
                  AuthTextField(
                    label: 'Email',
                    hintText: 'tu@email.com',
                    enabled: !isSubmitting,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autofillHints: const [AutofillHints.email],
                    onChanged: (email) =>
                        authBloc.add(AuthEvent.registerEmailChanged(email)),
                  ),
                  const SizedBox(height: 12),
                  AuthPasswordField(
                    label: 'Contraseña',
                    enabled: !isSubmitting,
                    autofillHint: AutofillHints.newPassword,
                    visibleNotifier: passwordVisible,
                    onChanged: (password) => authBloc
                        .add(AuthEvent.registerPasswordChanged(password)),
                    onSubmitted: (_) {
                      if (!isSubmitting) onSubmit();
                    },
                  ),
                  const SizedBox(height: 12),
                  AuthPasswordField(
                    label: 'Repetí la contraseña',
                    enabled: !isSubmitting,
                    autofillHint: AutofillHints.newPassword,
                    visibleNotifier: passwordVisible,
                    onChanged: (confirmPassword) => authBloc.add(
                      AuthEvent.registerPasswordConfirmChanged(confirmPassword),
                    ),
                    onSubmitted: (_) {
                      if (!isSubmitting) onSubmit();
                    },
                  ),
                ],
              ),
            ),
            if (state.registerErrorMessage != null)
              AuthErrorText(message: state.registerErrorMessage!),
            if (state.errorMessage != null)
              AuthErrorText(message: state.errorMessage!),
            const Spacer(),
            AuthSubmitButton(
              label: 'Crear cuenta',
              isLoading: isSubmitting,
              onPressed: onSubmit,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: isSubmitting ? null : onNavigateToLogin,
              child: const Text('Ya tengo cuenta'),
            ),
          ],
        );
      },
    );
  }
}
