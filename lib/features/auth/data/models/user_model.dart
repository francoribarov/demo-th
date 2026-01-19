// ignore_for_file: invalid_annotation_target // Required for Freezed/json annotations.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/user.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/user_address.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/game_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User model matching backend UserSchema
@freezed
sealed class UserModel with _$UserModel implements BaseDtoResponse<User> {
  /// Creates a [UserModel] instance from backend fields.
  const factory UserModel({
    required String id,
    required String email,
    required String username,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,
    UserAddressModel? address,
    @JsonKey(name: 'delivery_zone') List<String>? deliveryZone,
    @JsonKey(name: 'preferences')
    @Default([])
    List<GameCategoryModel> preferences,
    String? location,
    @JsonKey(name: 'response_time') String? responseTime,
    @JsonKey(name: 'member_since') DateTime? memberSince,
    @JsonKey(name: 'completed_rentals') @Default(0) int completedRentals,
    @Default(0.0) double rating,
    @JsonKey(name: 'total_reviews') @Default(0) int totalReviews,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _UserModel;

  const UserModel._();

  /// Creates a [UserModel] from JSON.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Creates a [UserModel] from a domain [User] entity.
  factory UserModel.fromEntity(User entity) => UserModel(
    id: entity.id,
    email: entity.email,
    username: entity.username,
    imageUrl: entity.imageUrl,
    dateOfBirth: entity.dateOfBirth,
    address: entity.address != null
        ? UserAddressModel.fromEntity(entity.address!)
        : null,
    deliveryZone: entity.deliveryZone,
    preferences: entity.preferences.map(GameCategoryModel.fromEntity).toList(),
    location: entity.location,
    responseTime: entity.responseTime,
    memberSince: entity.memberSince,
    completedRentals: entity.completedRentals,
    rating: entity.rating,
    totalReviews: entity.totalReviews,
    isActive: entity.isActive,
    createdAt: entity.createdAt,
  );

  @override
  User toDomainModel() => User(
    id: id,
    email: email,
    username: username,
    imageUrl: imageUrl,
    dateOfBirth: dateOfBirth,
    address: address?.toDomainModel(),
    deliveryZone: deliveryZone,
    preferences: preferences.map((p) => p.toDomainModel()).toList(),
    location: location,
    responseTime: responseTime,
    memberSince: memberSince,
    completedRentals: completedRentals,
    rating: rating,
    totalReviews: totalReviews,
    isActive: isActive,
    createdAt: createdAt,
  );
}

@freezed
sealed class UserAddressModel
    with _$UserAddressModel
    implements BaseDtoResponse<UserAddress> {
  const factory UserAddressModel({
    required String address,
    @JsonKey(name: 'address_name') required String addressName,
    required String number,
    @JsonKey(name: 'additional_notes') String? additionalNotes,
  }) = _UserAddressModel;

  const UserAddressModel._();

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      _$UserAddressModelFromJson(json);

  factory UserAddressModel.fromEntity(UserAddress entity) => UserAddressModel(
    address: entity.address,
    addressName: entity.addressName,
    number: entity.number,
    additionalNotes: entity.additionalNotes,
  );

  @override
  UserAddress toDomainModel() => UserAddress(
    address: address,
    addressName: addressName,
    number: number,
    additionalNotes: additionalNotes,
  );
}
