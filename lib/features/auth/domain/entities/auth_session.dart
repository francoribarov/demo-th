import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile_table_hopping/features/auth/domain/entities/auth_tokens.dart';
import 'package:mobile_table_hopping/features/auth/domain/entities/user.dart';

part 'auth_session.freezed.dart';

@freezed

/// Domain entity representing an authenticated session.
abstract class AuthSession with _$AuthSession {
  /// Creates an [AuthSession] instance.
  const factory AuthSession({required AuthTokens tokens, User? user}) =
      _AuthSession;
}
