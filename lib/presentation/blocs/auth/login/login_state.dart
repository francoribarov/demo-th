part of 'login_cubit.dart';

@freezed
/// State for the login form.
abstract class LoginState with _$LoginState {
  /// Creates a login state.
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isSubmitting,
    String? errorMessage,
    FeedbackNotice? feedbackNotice,
  }) = _LoginState;
}
