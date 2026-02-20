import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_tokens.dart';

/// Repository interface for authentication operations.
abstract class AuthRepository {
  /// Authenticates a user with email/password credentials.
  Future<AuthSession> login({required String email, required String password});

  /// Registers a new user account.
  Future<AuthSession> register({
    required String email,
    required String password,
    required String username,
    String? location,
  });

  /// Refreshes the current access token.
  Future<AuthTokens> refresh();

  /// Logs out the current session and clears local state.
  Future<void> logout();

  /// Returns the cached authenticated session, or null if not authenticated.
  Future<AuthSession?> getAuthStatus();
}
