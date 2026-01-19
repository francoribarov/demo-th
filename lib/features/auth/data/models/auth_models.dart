// ignore_for_file: annotate_overrides, invalid_annotation_target // Required for Freezed/json annotations.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_table_hopping/core/network/base_dto_response.dart';
import 'package:mobile_table_hopping/features/auth/data/models/user_model.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/auth_session.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/auth_tokens.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

/// Login request model
@freezed
abstract class LoginRequest with _$LoginRequest {
  /// Creates a login request.
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  const LoginRequest._();

  /// Creates a [LoginRequest] from JSON.
  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  /// Serializes the request payload.
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

/// Register request model
@freezed
abstract class RegisterRequest with _$RegisterRequest {
  /// Creates a register request.
  const factory RegisterRequest({
    required String email,
    required String password,
    required String username,
    @JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,
    @JsonKey(name: 'image_url') String? imageUrl,
    UserAddressModel? address,
    @JsonKey(name: 'delivery_zone') List<String>? deliveryZone,
    String? location,
  }) = _RegisterRequest;

  const RegisterRequest._();

  /// Creates a [RegisterRequest] from JSON.
  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  /// Serializes the request payload.
  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'username': username,
    if (dateOfBirth != null) 'date_of_birth': dateOfBirth!.toIso8601String(),
    if (imageUrl != null) 'image_url': imageUrl,
    if (address != null) 'address': address!.toJson(),
    if (deliveryZone != null) 'delivery_zone': deliveryZone,
    if (location != null) 'location': location,
  };
}

/// Token response model
@freezed
sealed class TokenResponse
    with _$TokenResponse
    implements BaseDtoResponse<AuthTokens> {
  /// Creates a token response model.
  const factory TokenResponse({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'token_type') @Default('bearer') String tokenType,
  }) = _TokenResponse;

  const TokenResponse._();

  /// Creates a [TokenResponse] from JSON.
  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  @override
  AuthTokens toDomainModel() => AuthTokens(
    accessToken: accessToken,
    refreshToken: refreshToken,
    tokenType: tokenType,
  );
}

/// Authentication response model
@freezed
sealed class AuthResponse
    with _$AuthResponse
    implements BaseDtoResponse<AuthSession> {
  /// Creates an authentication response model.
  const factory AuthResponse({
    required UserModel user,
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'token_type') @Default('bearer') String tokenType,
  }) = _AuthResponse;

  const AuthResponse._();

  /// Creates an [AuthResponse] from JSON.
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  @override
  AuthSession toDomainModel() => AuthSession(
    user: user.toDomainModel(),
    tokens: AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: tokenType,
    ),
  );
}

/// Refresh token request model
@freezed
abstract class RefreshTokenRequest with _$RefreshTokenRequest {
  /// Creates a refresh token request.
  const factory RefreshTokenRequest({
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _RefreshTokenRequest;

  const RefreshTokenRequest._();

  /// Creates a [RefreshTokenRequest] from JSON.
  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);
}
