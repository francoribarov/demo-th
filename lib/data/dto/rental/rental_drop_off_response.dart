import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';

part 'rental_drop_off_response.freezed.dart';
part 'rental_drop_off_response.g.dart';

@freezed
abstract class RentalDropOffResponse
    with _$RentalDropOffResponse
    implements BaseDtoResponse<RentalDropOffResponse> {
  const factory RentalDropOffResponse({
    required String id,
    required String status,
    @JsonKey(name: 'rentalId') required String rentalId,
    @JsonKey(name: 'dropOffDate') required String dropOffDate,
    @JsonKey(name: 'images') @Default([]) List<String> images,
    @JsonKey(name: 'rejectionReason') String? rejectionReason,
  }) = _RentalDropOffResponse;

  const RentalDropOffResponse._();

  factory RentalDropOffResponse.fromJson(Map<String, dynamic> json) =>
      _$RentalDropOffResponseFromJson(json);

  @override
  RentalDropOffResponse toDomainModel() => this;
}
