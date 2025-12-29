import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens.freezed.dart';

@freezed
/// Domain entity containing auth access/refresh tokens.
class AuthTokens with _$AuthTokens {
  /// Creates an [AuthTokens] instance.
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
    @Default('bearer') String tokenType,
  }) = _AuthTokens;
}
