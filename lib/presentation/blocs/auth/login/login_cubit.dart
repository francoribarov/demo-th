import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/login.dart';
import 'package:mobile_table_hopping/domain/validators/auth/auth_validator.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';
import 'package:mobile_table_hopping/presentation/validators/auth_validation_error_mapper.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@injectable
/// Cubit managing the login form state.
class LoginCubit extends Cubit<LoginState> {
  /// Creates a [LoginCubit] wired to [Login] and [AuthBloc].
  LoginCubit({required Login login, required AuthBloc authBloc})
    : _login = login,
      _authBloc = authBloc,
      super(const LoginState());

  final Login _login;
  final AuthBloc _authBloc;

  /// Updates the email field.
  void emailChanged(String email) {
    emit(state.copyWith(email: email, errorMessage: null));
  }

  /// Updates the password field.
  void passwordChanged(String password) {
    emit(state.copyWith(password: password, errorMessage: null));
  }

  /// Submits the login form.
  Future<void> submit() async {
    if (state.isSubmitting) return;

    final email = state.email.trim();
    final password = state.password;

    final emailError = AuthValidationErrorMapper.mapEmailError(
      AuthValidator.validateEmail(email),
    );
    if (emailError != null) {
      emit(state.copyWith(errorMessage: emailError));
      return;
    }

    final passwordError = AuthValidationErrorMapper.mapPasswordError(
      AuthValidator.validatePassword(password),
    );
    if (passwordError != null) {
      emit(state.copyWith(errorMessage: passwordError));
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        feedbackNotice: null,
      ),
    );

    try {
      final session = await _login(email: email, password: password);
      emit(state.copyWith(isSubmitting: false, password: ''));
      _authBloc.add(AuthEvent.sessionObtained(session));
    } on DomainException catch (e) {
      if (kDebugMode) debugPrint('LoginCubit: Login error: $e');
      emit(
        state.copyWith(
          isSubmitting: false,
          feedbackNotice: FeedbackNotice(
            message: e.message,
            severity: FeedbackSeverity.error,
          ),
        ),
      );
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('LoginCubit: Login error: $e');
      emit(
        state.copyWith(
          isSubmitting: false,
          feedbackNotice: const FeedbackNotice(
            message: 'No pudimos iniciar sesión. Intenta nuevamente.',
            severity: FeedbackSeverity.error,
          ),
        ),
      );
    }
  }

  /// Clears the pending feedback notice after it has been shown.
  void clearNotice() {
    emit(state.copyWith(feedbackNotice: null));
  }
}
