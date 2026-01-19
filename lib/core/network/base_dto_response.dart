/// Base interface for all DTOs that can map to domain entities.
///
/// This interface enforces compile-time safety that all data transfer objects
/// (DTOs) from the API layer implement a mapping function to their corresponding
/// domain entities.
///
/// Example:
/// ```dart
/// @freezed
/// sealed class UserResponse with _$UserResponse implements BaseDtoResponse<User> {
///   const factory UserResponse({
///     required String id,
///     required String email,
///   }) = _UserResponse;
///
///   const UserResponse._();
///
///   factory UserResponse.fromJson(Map<String, dynamic> json) =>
///       _$UserResponseFromJson(json);
///
///   @override
///   User toDomainModel() => User(id: id, email: email);
/// }
/// ```
// ignore_for_file: one_member_abstracts
// This is intentionally an abstract class (not a function type) to:
// 1. Clearly document the DTO contract
// 2. Enable future expansion (e.g., validation methods)
// 3. Improve IDE autocomplete/discoverability
abstract class BaseDtoResponse<T> {
  /// Converts this DTO to its corresponding domain entity.
  ///
  /// This method should handle all the mapping logic from the API response
  /// structure to the domain model structure, potentially including:
  /// - Field renaming
  /// - Type conversions
  /// - Nested object mapping
  /// - Default value handling
  T toDomainModel();
}
