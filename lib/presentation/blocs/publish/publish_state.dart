part of 'publish_bloc.dart';

@freezed
/// State for the publish flow.
abstract class PublishState with _$PublishState {
  /// Creates a publish state snapshot.
  const factory PublishState({
    @Default(0) int formVersion,
    @Default(0) int currentStep,
    @Default(false) bool success,
    @Default(false) bool isSubmitting,
    String? errorMessage,
    @Default(PublicationFormState()) PublicationFormState form,
    @Default(false) bool isStepValid,
  }) = _PublishState;

  const PublishState._();
}
