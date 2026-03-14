import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request_participants.dart';

part 'rental_request_model.freezed.dart';
part 'rental_request_model.g.dart';

@freezed
sealed class RentalRequestModel
    with _$RentalRequestModel
    implements BaseDtoResponse<RentalRequest> {
  const factory RentalRequestModel({
    required String id,
    required RentalRequestGameModel game,
    required RentalRequestUserModel requester,
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

@freezed
sealed class RentalRequestGameModel
    with _$RentalRequestGameModel
    implements BaseDtoResponse<RentalRequestGameSummary> {
  const factory RentalRequestGameModel({
    required String id,
    required String title,
    required int price,
    required List<RentalRequestGameImageModel> images,
    @JsonKey(name: 'owner_id') String? ownerId,
  }) = _RentalRequestGameModel;

  const RentalRequestGameModel._();

  factory RentalRequestGameModel.fromJson(Map<String, dynamic> json) =>
      _$RentalRequestGameModelFromJson(json);

  @override
  RentalRequestGameSummary toDomainModel() {
    return RentalRequestGameSummary(
      id: id,
      title: title,
      images: images.map((e) => e.url).toList(),
      price: price,
      ownerId: ownerId,
    );
  }
}

@freezed
sealed class RentalRequestGameImageModel with _$RentalRequestGameImageModel {
  const factory RentalRequestGameImageModel({
    required String url,
  }) = _RentalRequestGameImageModel;

  factory RentalRequestGameImageModel.fromJson(Map<String, dynamic> json) =>
      _$RentalRequestGameImageModelFromJson(json);
}

@freezed
sealed class RentalRequestUserModel
    with _$RentalRequestUserModel
    implements BaseDtoResponse<RentalRequestUserSummary> {
  const factory RentalRequestUserModel({
    required String id,
    required String email,
    required String username,
    String? imageUrl,
  }) = _RentalRequestUserModel;

  const RentalRequestUserModel._();

  factory RentalRequestUserModel.fromJson(Map<String, dynamic> json) =>
      _$RentalRequestUserModelFromJson(
        <String, dynamic>{
          ...json,
          'imageUrl': json['imageUrl'] ?? json['image_url'],
        },
      );

  @override
  RentalRequestUserSummary toDomainModel() {
    return RentalRequestUserSummary(
      id: id,
      email: email,
      username: username,
      imageUrl: imageUrl,
    );
  }
}
