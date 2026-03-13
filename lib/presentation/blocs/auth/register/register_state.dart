part of 'register_cubit.dart';

@freezed
/// State for the register form.
abstract class RegisterState with _$RegisterState {
  /// Creates a register state.
  const factory RegisterState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String passwordConfirm,
    @Default('') String username,
    @Default('') String location,
    @Default(false) bool isSubmitting,
    String? errorMessage,
    FeedbackNotice? feedbackNotice,
  }) = _RegisterState;
}
