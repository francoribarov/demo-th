import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/domain/validators/publication/publication_validator.dart';

part 'publication_form_state.freezed.dart';

@freezed
/// Shared form state for publish and edit-publication flows.
abstract class PublicationFormState with _$PublicationFormState {
  /// Creates a publication form state.
  const factory PublicationFormState({
    @Default('') String gameId,
    @Default('') String description,
    @Default(null) PublicationCondition? condition,
    @Default(0) int price,
    String? descriptionError,
    String? conditionError,
    String? priceError,
  }) = _PublicationFormState;

  const PublicationFormState._();

  /// True when description and condition are valid.
  bool get hasValidData =>
      PublicationValidator.validateDescription(description) == null &&
      PublicationValidator.validateCondition(condition) == null;

  /// True when price is valid.
  bool get hasValidPrice =>
      PublicationValidator.validatePricing(price) == null;
}
