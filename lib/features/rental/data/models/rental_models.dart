import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/features/rental/domain/entities/rental_draft.dart';

part 'rental_models.freezed.dart';
part 'rental_models.g.dart';

/// Request model for creating a rental.
@freezed
abstract class RentalCreateRequestModel with _$RentalCreateRequestModel {
  /// Creates a rental request model.
  const factory RentalCreateRequestModel({
    required String publicationId,
    required String startDate,
    required String endDate,
    @JsonKey(name: 'selectedDelivery') required String selectedDelivery,
    required String paymentMethod,
    String? deliveryAddress,
    List<String>? foodBundleIds,
  }) = _RentalCreateRequestModel;

  /// Creates a [RentalCreateRequestModel] from a [RentalDraft].
  factory RentalCreateRequestModel.fromEntity(RentalDraft draft) {
    return RentalCreateRequestModel(
      publicationId: draft.publicationId,
      startDate: draft.startDate,
      endDate: draft.endDate,
      selectedDelivery: draft.isDelivery ? 'Delivery' : 'Retiro en persona',
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
