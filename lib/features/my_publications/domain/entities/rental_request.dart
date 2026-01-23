import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/user.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

part 'rental_request.freezed.dart';

enum RentalRequestStatus { pending, accepted, rejected }

@freezed
abstract class RentalRequest with _$RentalRequest {
  const factory RentalRequest({
    required String id,
    // TODO(FRAN): Change this to a Publication when available
    required Game game,
    required User requester,
    required DateTime startDate,
    required DateTime endDate,
    required double totalPrice,
    required RentalRequestStatus status,
  }) = _RentalRequest;
}
