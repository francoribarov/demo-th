import 'package:freezed_annotation/freezed_annotation.dart';

part 'rental_request_participants.freezed.dart';

@freezed
abstract class RentalRequestGameSummary with _$RentalRequestGameSummary {
  const factory RentalRequestGameSummary({
    required String id,
    required String title,
    required int price,
    @Default([]) List<String> images,
    String? ownerId,
  }) = _RentalRequestGameSummary;
}

@freezed
abstract class RentalRequestUserSummary with _$RentalRequestUserSummary {
  const factory RentalRequestUserSummary({
    required String id,
    required String email,
    required String username,
    String? imageUrl,
  }) = _RentalRequestUserSummary;
}
