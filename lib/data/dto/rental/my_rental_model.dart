import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request_participants.dart';

part 'my_rental_model.freezed.dart';
part 'my_rental_model.g.dart';

@freezed
abstract class MyRentalModel
    with _$MyRentalModel
    implements BaseDtoResponse<RentalRequest> {
  const factory MyRentalModel({
    required String id,
    required String publicationId,
    required String renterId,
    required String ownerId,
    required String startDate,
    required String endDate,
    required String status,
    required String gameTitle,
    required String renterName,
    @JsonKey(name: 'dropOffTicketId') String? dropOffTicketId,
    @JsonKey(name: 'finalPrice') double? finalPrice,
  }) = _MyRentalModel;

  const MyRentalModel._();

  factory MyRentalModel.fromJson(Map<String, dynamic> json) =>
      _$MyRentalModelFromJson(json);

  @override
  RentalRequest toDomainModel() {
    return RentalRequest(
      id: id,
      game: RentalRequestGameSummary(
        id: publicationId,
        title: gameTitle,
        price: 0,
        ownerId: ownerId,
      ),
      requester: RentalRequestUserSummary(
        id: renterId,
        email: '',
        username: renterName,
      ),
      startDate: DateTime.parse(startDate),
      endDate: DateTime.parse(endDate),
      totalPrice: finalPrice ?? 0.0,
      dropOffTicketId: dropOffTicketId,
      status: _parseStatus(status),
    );
  }

  RentalRequestStatus _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return RentalRequestStatus.pending;
      case 'ACTIVE':
      case 'ACCEPTED':
        return RentalRequestStatus.accepted;
      case 'REJECTED':
        return RentalRequestStatus.rejected;
      default:
        return RentalRequestStatus.pending;
    }
  }
}
