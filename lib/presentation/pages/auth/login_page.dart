import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_validators.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/auth/auth_header.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/auth/auth_switch_row.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isPasswordVisible = false;
  bool _didClearErrors = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didClearErrors) {
      _didClearErrors = true;
      context.read<AuthBloc>().add(const AuthEvent.clearErrors());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitLogin({required bool isSubmitting}) {
    if (isSubmitting) return;
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(const AuthEvent.loginSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status && current.isAuthenticated,
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
        appBar: PageAppBar(
          title: const Text('Iniciar sesión'),
          leadingType: PageAppBarLeadingType.close,
          onLeadingPressed: () => context.popOrGo(AppRoutes.home),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth >= 640 ? constraints.maxWidth * 0.18 : 24.0;

              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isSubmitting = state.isSubmittingLogin;
                  final errorMessage = state.loginErrorMessage ?? state.errorMessage;
                  final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

                  return SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      AppTheme.spacingLg,
                      horizontalPadding,
                      AppTheme.spacingLg + keyboardInset,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: AppTheme.spacing3xl),
                        Center(
                          child: Image.asset(
                            'assets/images/dice_logo.png',
                            height: 64,
                            width: 64,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacing2xl),
                        const AuthHeader(
                          title: 'Bienvenido/a',
                          subtitle: 'Ingresá tus datos para continuar.',
                        ),
                        const SizedBox(height: AppTheme.spacing3xl),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: AutofillGroup(
                            child: Column(
                              children: [
                                TextFormInputField(
                                  key: const Key('loginEmailField'),
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  enabled: !isSubmitting,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [
                                    AutofillHints.username,
                                    AutofillHints.email,
                                  ],
                                  autocorrect: false,
                                  labelText: 'Email',
                                  hintText: 'tu@email.com',
                                  validator: (value) => validateEmail(value ?? ''),
                                  onChanged: (email) => context.read<AuthBloc>().add(
                                    AuthEvent.loginEmailChanged(email),
                                  ),
                                  onFieldSubmitted: (_) {
                                    _passwordFocusNode.requestFocus();
                                  },
                                ),
                                const SizedBox(height: AppTheme.spacingLg),
                                TextFormInputField(
                                  key: const Key('loginPasswordField'),
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  enabled: !isSubmitting,
                                  obscureText: !_isPasswordVisible,
                                  textInputAction: TextInputAction.done,
                                  autofillHints: const [AutofillHints.password],
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  labelText: 'Contraseña',
                                  helperText: 'Mínimo 8 caracteres.',
                                  suffixIcon: IconButton(
                                    key: const Key(
                                      'loginPasswordVisibilityButton',
                                    ),
                                    tooltip: _isPasswordVisible ? 'Ocultar contraseña' : 'Mostrar contraseña',
                                    onPressed: isSubmitting
                                        ? null
                                        : () {
                                            setState(() {
                                              _isPasswordVisible = !_isPasswordVisible;
                                            });
                                          },
                                    icon: Icon(
                                      _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                    ),
                                  ),
                                  validator: (value) => validatePasswordMin8(value ?? ''),
                                  onChanged: (password) => context.read<AuthBloc>().add(
                                    AuthEvent.loginPasswordChanged(
                                      password,
                                    ),
                                  ),
                                  onFieldSubmitted: (_) => _submitLogin(isSubmitting: isSubmitting),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (errorMessage != null) ...[
                          const SizedBox(height: AppTheme.spacingSm),
                          InlineFeedbackText(
                            message: errorMessage,
                            padding: const EdgeInsets.only(
                              top: AppTheme.spacingMd,
                            ),
                          ),
                        ],
                        const SizedBox(height: AppTheme.spacing2xl),
                        AppPrimaryButton(
                          key: const Key('loginSubmitButton'),
                          label: 'Ingresar',
                          isLoading: isSubmitting,
                          onPressed: () => _submitLogin(isSubmitting: isSubmitting),
                        ),
                        const SizedBox(height: AppTheme.spacingLg),
                        AuthSwitchRow(
                          prompt: 'No tenés cuenta? ',
                          actionLabel: 'Registrate',
                          onAction: isSubmitting ? () {} : () => context.goToRegister(from: widget.from),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
