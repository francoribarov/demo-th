import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/data/dto/catalog/game_model.dart';
import 'package:mobile_table_hopping/data/dto/publish/delivery_method_model.dart';
import 'package:mobile_table_hopping/domain/model/auth/address.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User model matching backend UserSchema
@freezed
abstract class UserModel with _$UserModel implements BaseDtoResponse<User> {
  /// Creates a [UserModel] instance from backend fields.
  const factory UserModel({
    required String id,
    @Default('') String email,
    required String username,
    @Default('') String email,
    String? imageUrl,
    DateTime? dateOfBirth,
    UserAddressModel? address,
    List<String>? deliveryZone,
    @JsonKey(name: 'delivery_methods')
    List<DeliveryMethodModel>? deliveryMethods,
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
    DateTime? createdAt,
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
abstract class UserAddressModel
    with _$UserAddressModel
    implements BaseDtoResponse<Address> {
  const factory UserAddressModel({
    @Default('') String address,
    @Default('') String addressName,
    @Default('') String number,
    String? additionalNotes,
  }) = _UserAddressModel;

  const UserAddressModel._();

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      _$UserAddressModelFromJson(json);

  factory UserAddressModel.fromEntity(Address entity) => UserAddressModel(
    address: entity.address,
    addressName: entity.addressName,
    number: entity.number,
    additionalNotes: entity.additionalNotes,
  );

  @override
  Address toDomainModel() => Address(
    address: address,
    addressName: addressName,
    number: number,
    additionalNotes: additionalNotes,
  );
}
