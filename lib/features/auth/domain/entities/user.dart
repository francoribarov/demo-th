import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
/// Domain entity representing an authenticated user.
abstract class User with _$User {
  /// Creates a [User] entity.
  const factory User({
    required String id,
    required String email,
    required String name,
    String? location,
    String? avatarUrl,
    String? responseTime,
    DateTime? memberSince,
    @Default(0) int completedRentals,
    @Default(0.0) double rating,
    @Default(0) int totalReviews,
    @Default(true) bool isActive,
    DateTime? createdAt,
  }) = _User;
}
