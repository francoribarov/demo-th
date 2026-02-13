import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/features/rental/domain/entities/rental_draft.dart';

part 'rental_models.freezed.dart';
part 'rental_models.g.dart';

/// Request model for creating a rental.
@freezed
abstract class RentalCreateRequestModel with _$RentalCreateRequestModel {
  /// Creates a rental request model.
  const factory RentalCreateRequestModel({
    @JsonKey(name: 'publicationId') required String publicationId,
    required String ownerId,
    required String startDate,
    required String endDate,
    required double pricePerDay,
    required double deposit,
    required String deliveryMethod,
    required String paymentMethod,
    String? deliveryAddress,
    List<String>? foodBundleIds,
  }) = _RentalCreateRequestModel;

  /// Creates a [RentalCreateRequestModel] from a [RentalDraft].
  factory RentalCreateRequestModel.fromEntity(RentalDraft draft) {
    return RentalCreateRequestModel(
      publicationId: draft.publicationId,
      ownerId: draft.ownerId,
      startDate: draft.startDate,
      endDate: draft.endDate,
      pricePerDay: draft.pricePerDay,
      deposit: draft.deposit,
      deliveryMethod: draft.isDelivery ? 'delivery' : 'pickup',
      paymentMethod: draft.paymentMethod,
      deliveryAddress: draft.isDelivery && draft.deliveryAddress.isNotEmpty
          ? draft.deliveryAddress
          : null,
      foodBundleIds: draft.foodBundleIds.isEmpty ? null : draft.foodBundleIds,
    );
  }

  /// Creates a [RentalCreateRequestModel] from JSON.
  factory RentalCreateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RentalCreateRequestModelFromJson(json);
}
