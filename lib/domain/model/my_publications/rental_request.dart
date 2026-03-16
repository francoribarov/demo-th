import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request_participants.dart';

part 'rental_request.freezed.dart';

enum RentalRequestStatus { pending, accepted, rejected }

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
  }) = _RentalRequest;
}

extension RentalRequestOverlap on RentalRequest {
  /// Whether this request's date range overlaps with [other] for the same game.
  bool overlapsWith(RentalRequest other) {
    return game.id == other.game.id &&
        id != other.id &&
        startDate.isBefore(other.endDate) &&
        other.startDate.isBefore(endDate);
  }
}
