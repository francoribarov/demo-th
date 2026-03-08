part of 'drop_off_bloc.dart';

@freezed
abstract class DropOffState with _$DropOffState {
  const factory DropOffState({
    required String? imagePath,
    required bool isSubmitting,
    required bool isSuccess,
    String? errorMessage,
  }) = _DropOffState;

  factory DropOffState.initial() => const DropOffState(
        imagePath: null,
        isSubmitting: false,
        isSuccess: false,
      );
}
