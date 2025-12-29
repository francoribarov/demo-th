// ignore_for_file: invalid_annotation_target // Required for Freezed/json annotations.

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile_table_hopping/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User model matching backend UserSchema
@freezed
class UserModel with _$UserModel {
  /// Creates a [UserModel] instance from backend fields.
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? location,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
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
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Creates a [UserModel] from a domain [User] entity.
  factory UserModel.fromEntity(User entity) => UserModel(
    id: entity.id,
    email: entity.email,
    name: entity.name,
    location: entity.location,
    avatarUrl: entity.avatarUrl,
    responseTime: entity.responseTime,
    memberSince: entity.memberSince,
    completedRentals: entity.completedRentals,
    rating: entity.rating,
    totalReviews: entity.totalReviews,
    isActive: entity.isActive,
    createdAt: entity.createdAt,
  );

  /// Converts this model into a domain [User] entity.
  User toEntity() => User(
    id: id,
    email: email,
    name: name,
    location: location,
    avatarUrl: avatarUrl,
    responseTime: responseTime,
    memberSince: memberSince,
    completedRentals: completedRentals,
    rating: rating,
    totalReviews: totalReviews,
    isActive: isActive,
    createdAt: createdAt,
  );
}
