import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/domain/validators/auth/auth_validator.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/register/register_cubit.dart';
import 'package:mobile_table_hopping/presentation/validators/auth_validation_error_mapper.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/auth/auth_header.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/auth/auth_switch_row.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/feedback_messenger.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.clearErrors());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitRegister({required bool isSubmitting}) async {
    if (isSubmitting) return;
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    FocusScope.of(context).unfocus();
    await context.read<RegisterCubit>().submit();
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
          title: const Text('Crear cuenta'),
          onLeadingPressed: () => context.goToLogin(from: widget.from),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth >= 640 ? constraints.maxWidth * 0.18 : 24.0;

              return BlocConsumer<RegisterCubit, RegisterState>(
                listenWhen: (previous, current) =>
                    current.feedbackNotice != null && previous.feedbackNotice != current.feedbackNotice,
                listener: (context, state) {
                  final notice = state.feedbackNotice;
                  if (notice == null) return;
                  FeedbackMessenger.showError(
                    context,
                    message: notice.message,
                  );
                  context.read<RegisterCubit>().clearNotice();
                },
                builder: (context, registerState) {
                  final isSubmitting = registerState.isSubmitting;
                  final errorMessage = registerState.errorMessage;
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
                          title: 'Empecemos',
                          subtitle: 'Creá tu cuenta para publicar y alquilar juegos.',
                        ),
                        const SizedBox(height: AppTheme.spacing3xl),
                        Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: AutofillGroup(
                            child: Column(
                              children: [
                                TextFormInputField(
                                  key: const Key('registerNameField'),
                                  controller: _nameController,
                                  focusNode: _nameFocusNode,
                                  enabled: !isSubmitting,
                                  textInputAction: TextInputAction.next,
                                  textCapitalization: TextCapitalization.words,
                                  autofillHints: const [
                                    AutofillHints.name,
                                    AutofillHints.newUsername,
                                  ],
                                  labelText: 'Nombre',
                                  validator: (value) => AuthValidationErrorMapper.mapUsernameError(
                                    AuthValidator.validateUsernameRequired(
                                      value ?? '',
                                    ),
                                  ),
                                  onChanged: (name) => context.read<RegisterCubit>().usernameChanged(name),
                                  onFieldSubmitted: (_) {
                                    _emailFocusNode.requestFocus();
                                  },
                                ),
                                const SizedBox(height: AppTheme.spacingLg),
                                TextFormInputField(
                                  key: const Key('registerEmailField'),
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  enabled: !isSubmitting,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autocorrect: false,
                                  autofillHints: const [
                                    AutofillHints.email,
                                    AutofillHints.newUsername,
                                  ],
                                  labelText: 'Email',
                                  hintText: 'tu@email.com',
                                  validator: (value) => AuthValidationErrorMapper.mapEmailError(
                                    AuthValidator.validateEmail(
                                      value ?? '',
                                    ),
                                  ),
                                  onChanged: (email) => context.read<RegisterCubit>().emailChanged(email),
                                  onFieldSubmitted: (_) {
                                    _passwordFocusNode.requestFocus();
                                  },
                                ),
                                const SizedBox(height: AppTheme.spacingLg),
                                TextFormInputField(
                                  key: const Key('registerPasswordField'),
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  enabled: !isSubmitting,
                                  obscureText: !_isPasswordVisible,
                                  textInputAction: TextInputAction.next,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  autofillHints: const [
                                    AutofillHints.newPassword,
                                  ],
                                  labelText: 'Contraseña',
                                  helperText: 'Mínimo 8 caracteres.',
                                  suffixIcon: IconButton(
                                    key: const Key(
                                      'registerPasswordVisibilityButton',
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
                                  validator: (value) => AuthValidationErrorMapper.mapPasswordError(
                                    AuthValidator.validatePassword(
                                      value ?? '',
                                    ),
                                  ),
                                  onChanged: (password) => context.read<RegisterCubit>().passwordChanged(password),
                                  onFieldSubmitted: (_) {
                                    _confirmPasswordFocusNode.requestFocus();
                                  },
                                ),
                                const SizedBox(height: AppTheme.spacingLg),
                                TextFormInputField(
                                  key: const Key(
                                    'registerConfirmPasswordField',
                                  ),
                                  controller: _confirmPasswordController,
                                  focusNode: _confirmPasswordFocusNode,
                                  enabled: !isSubmitting,
                                  obscureText: !_isConfirmPasswordVisible,
                                  textInputAction: TextInputAction.next,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  autofillHints: const [
                                    AutofillHints.newPassword,
                                  ],
                                  labelText: 'Repetí la contraseña',
                                  suffixIcon: IconButton(
                                    key: const Key(
                                      'registerConfirmPasswordVisibilityButton',
                                    ),
                                    tooltip: _isConfirmPasswordVisible ? 'Ocultar contraseña' : 'Mostrar contraseña',
                                    onPressed: isSubmitting
                                        ? null
                                        : () {
                                            setState(() {
                                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                            });
                                          },
                                    icon: Icon(
                                      _isConfirmPasswordVisible
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                  ),
                                  validator: (value) => AuthValidationErrorMapper.mapPasswordConfirmationError(
                                    AuthValidator.validatePasswordConfirmation(
                                      password: _passwordController.text,
                                      confirmation: value ?? '',
                                    ),
                                  ),
                                  onChanged: (confirmPassword) =>
                                      context.read<RegisterCubit>().passwordConfirmChanged(confirmPassword),
                                  onFieldSubmitted: (_) => _submitRegister(
                                    isSubmitting: isSubmitting,
                                  ),
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
                          key: const Key('registerSubmitButton'),
                          label: 'Crear cuenta',
                          isLoading: isSubmitting,
                          onPressed: () => _submitRegister(isSubmitting: isSubmitting),
                        ),
                        const SizedBox(height: AppTheme.spacingLg),
                        AuthSwitchRow(
                          key: const Key('registerGoToLoginButton'),
                          prompt: 'Ya tenés cuenta? ',
                          actionLabel: 'Iniciá sesión',
                          onAction: isSubmitting ? () {} : () => context.goToLogin(from: widget.from),
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
