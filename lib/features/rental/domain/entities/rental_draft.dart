import 'package:freezed_annotation/freezed_annotation.dart';

part 'rental_draft.freezed.dart';

/// Immutable draft data for a rental request.
@freezed
abstract class RentalDraft with _$RentalDraft {
  /// Creates a draft payload for a rental request.
  const factory RentalDraft({
    required int gameId,
    required String ownerId,
    required String startDate,
    required String endDate,
    required int pricePerDay,
    @Default(0) int deposit,
    @Default(false) bool isDelivery,
    @Default('') String deliveryAddress,
    @Default('') String deliveryComments,
    @Default('mercadopago') String paymentMethod,
    @Default([]) List<String> foodBundleIds,
  }) = _RentalDraft;
}
