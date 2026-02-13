import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/features/auth/data/models/user_model.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/game_summary_model.dart';
import 'package:mobile_table_hopping/features/my_publications/domain/entities/rental_request.dart';

part 'rental_request_model.freezed.dart';
part 'rental_request_model.g.dart';

@freezed
sealed class RentalRequestModel
    with _$RentalRequestModel
    implements BaseDtoResponse<RentalRequest> {
  const factory RentalRequestModel({
    required String id,
    required GameSummaryModel game,
    required UserModel requester,
    required String startDate,
    required String endDate,
    required double totalPrice,
    required String status,
  }) = _RentalRequestModel;

  const RentalRequestModel._();

  factory RentalRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RentalRequestModelFromJson(json);

  @override
  RentalRequest toDomainModel() {
    return RentalRequest(
      id: id,
      game: game.toDomainModel(),
      requester: requester.toDomainModel(),
      startDate: DateTime.parse(startDate),
      endDate: DateTime.parse(endDate),
      totalPrice: totalPrice,
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
