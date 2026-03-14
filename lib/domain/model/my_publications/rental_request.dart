import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request_participants.dart';

part 'rental_request.freezed.dart';

enum RentalRequestStatus {
  pending,
  accepted,
  active,
  returned,
  finished,
  cancelled,
  rejected,
}

@freezed
abstract class RentalRequest with _$RentalRequest {
  const factory RentalRequest({
    required String id,
    required RentalRequestGameSummary game,
    required RentalRequestUserSummary requester,
    required DateTime startDate,
    required DateTime endDate,
    required double totalPrice,
    required RentalRequestStatus status,
    String? dropOffTicketId,
  }) = _RentalRequest;
}
