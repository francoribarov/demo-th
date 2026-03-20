import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/domain/usecase/auth/register.dart';
import 'package:mobile_table_hopping/domain/validators/auth/auth_validator.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';
import 'package:mobile_table_hopping/presentation/validators/auth_validation_error_mapper.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

@injectable
/// Cubit managing the registration form state.
class RegisterCubit extends Cubit<RegisterState> {
  /// Creates a [RegisterCubit] wired to [Register] and [AuthBloc].
  RegisterCubit({required Register register, required AuthBloc authBloc})
    : _register = register,
      _authBloc = authBloc,
      super(const RegisterState());

  final Register _register;
  final AuthBloc _authBloc;

  /// Updates the email field.
  void emailChanged(String email) {
    emit(state.copyWith(email: email, errorMessage: null));
  }

  /// Updates the password field.
  void passwordChanged(String password) {
    emit(state.copyWith(password: password, errorMessage: null));
  }

  /// Updates the password confirmation field.
  void passwordConfirmChanged(String passwordConfirm) {
    emit(state.copyWith(passwordConfirm: passwordConfirm, errorMessage: null));
  }

  /// Updates the username field.
  void usernameChanged(String username) {
    emit(state.copyWith(username: username, errorMessage: null));
  }

  /// Updates the location field.
  void locationChanged(String location) {
    emit(state.copyWith(location: location, errorMessage: null));
  }

  /// Submits the registration form.
  Future<void> submit() async {
    if (state.isSubmitting) return;

    final email = state.email.trim();
    final password = state.password;
    final passwordConfirm = state.passwordConfirm;
    final username = state.username.trim();
    final location = state.location.trim();

    final usernameError = AuthValidationErrorMapper.mapUsernameError(
      AuthValidator.validateUsernameRequired(username),
    );
    if (usernameError != null) {
      emit(state.copyWith(errorMessage: usernameError));
      return;
    }

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

    final confirmError = AuthValidationErrorMapper.mapPasswordConfirmationError(
      AuthValidator.validatePasswordConfirmation(
        password: password,
        confirmation: passwordConfirm,
      ),
    );
    if (confirmError != null) {
      emit(state.copyWith(errorMessage: confirmError));
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
      final session = await _register(
        email: email,
        password: password,
        username: username,
        location: location.isEmpty ? null : location,
      );
      emit(
        state.copyWith(isSubmitting: false, password: '', passwordConfirm: ''),
      );
      _authBloc.add(AuthEvent.sessionObtained(session));
    } on DomainException catch (e) {
      if (kDebugMode) debugPrint('RegisterCubit: Register error: $e');
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
      if (kDebugMode) debugPrint('RegisterCubit: Register error: $e');
      emit(
        state.copyWith(
          isSubmitting: false,
          feedbackNotice: const FeedbackNotice(
            message: 'No pudimos crear tu cuenta. Intenta nuevamente.',
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
