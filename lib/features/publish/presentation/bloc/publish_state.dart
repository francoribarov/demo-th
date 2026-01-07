part of 'publish_bloc.dart';

// Implicitly using imports from publish_bloc part directive logic or parent logic?
// No, parts usually share imports of the parent file if they are part of it.
// Checked publish_bloc.dart imports. It imports `listing_validator.dart` (which was renamed/refactored). I need to make sure `publish_bloc.dart` imports `publication_validator.dart` and `delivery_method.dart`.
// PublishBloc.dart already updated imports in previous step.
// But `PublicationValidator` usage in `PublishState` requires `PublishBloc` to import `PublicationValidator`.
// I renamed `listing_validator.dart` to `publication_validator.dart` and file content class `ListingValidator` to `PublicationValidator`.
// But `PublishBloc` imports `publication_validator.dart`.
// Wait, previous tool call replaced `listing_validator.dart` import with `...validator/listing_validator.dart` was not updated to `publication_validator.dart`?
// Ah, the file move happened. And content update happened.
// I need to check `publish_bloc.dart` imports again.
// And `PublishState` logic relies on `PublicationValidator` which is imported in `PublishBloc`.

// However, `deliveryMethods` uses `DeliveryMethod` Type. `PublishBloc` imports `delivery_method.dart`.
// So it should be fine.


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

    @Default(0) int gameId,
    @Default('') String description,
    @Default(0) int price,
    @Default('like_new') String condition,
    @Default([]) List<String> images,
    @Default([]) List<DeliveryMethod> deliveryMethods,
  }) = _PublishState;
  const PublishState._();

  /// Returns whether the current step is valid to advance.
  bool get canProceed {
    // Simplified logic for now as steps might change
    // Assuming single page or fewer steps
    return PublicationValidator.validateDescription(description).isValid &&
           PublicationValidator.validatePricing(price).isValid &&
           gameId > 0;
  }
}
