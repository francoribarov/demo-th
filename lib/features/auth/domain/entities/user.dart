import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/user_address.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

part 'user.freezed.dart';

@freezed
/// Domain entity representing an authenticated user.
abstract class User with _$User {
  /// Creates a [User] entity.
  const factory User({
    required String id,
    required String email,
    required String username,
    String? imageUrl,
    DateTime? dateOfBirth,
    UserAddress? address,
    List<String>? deliveryZone,
    @Default([]) List<GameCategory> preferences,
    String? location, // Kept as per plan? "address" is object now. "location" might be deprecated or different. Plan said "address?" in register.
    // Keeping existing fields that weren't explicitly removed but might be useful
    String? responseTime,
    DateTime? memberSince,
    @Default(0) int completedRentals,
    @Default(0.0) double rating,
    @Default(0) int totalReviews,
    @Default(true) bool isActive,
    DateTime? createdAt,
  }) = _User;
}
