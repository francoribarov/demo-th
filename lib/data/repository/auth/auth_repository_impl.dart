import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/auth/token_storage.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/datasource/auth/auth_remote_datasource.dart';
import 'package:mobile_table_hopping/data/dto/auth/auth_models.dart';
import 'package:mobile_table_hopping/data/dto/auth/user_model.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_tokens.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/repository/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: AuthRepository)

/// Default implementation of [AuthRepository].
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  /// Creates an [AuthRepositoryImpl].
  AuthRepositoryImpl(this._remote, this._tokenStorage, this._prefs);

  static const String _cachedUserKey = 'auth_user';

  final AuthRemoteDatasource _remote;
  final TokenStorage _tokenStorage;
  final SharedPreferences _prefs;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final response = await unwrapOrThrow<AuthResponse>(
      () => _remote.login(LoginRequest(email: email, password: password)),
    );
    await _persistSession(response);
    return response.toDomainModel();
  }

  @override
  Future<AuthSession> register({
    required String email,
    required String password,
    required String username,
    String? location,
  }) async {
    final response = await unwrapOrThrow<AuthResponse>(
      () => _remote.register(
        RegisterRequest(
          email: email,
          password: password,
          username: username,
          location: location,
        ),
      ),
    );
    await _persistSession(response);
    return response.toDomainModel();
  }

  @override
  Future<AuthTokens> refresh() async {
    final refreshToken = _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    final response = await unwrapOrThrow<TokenResponse>(
      () => _remote.refreshToken(
        RefreshTokenRequest(refreshToken: refreshToken),
      ),
    );

    await _tokenStorage.saveTokens(response.accessToken, response.refreshToken);
    return response.toDomainModel();
  }

  @override
  Future<void> logout() async {
    try {
      final result = await executeVoidDataSource(function: _remote.logout);
      result.fold((error) => throw error, (_) {});
    } on DomainException catch (_) {
      // Always clear local session, even if API call fails.
    } finally {
      await _tokenStorage.clearTokens();
      await _prefs.remove(_cachedUserKey);
    }
  }

  @override
  Future<AuthSession?> getAuthStatus() async {
    final accessToken = _tokenStorage.getAccessToken();
    final refreshToken = _tokenStorage.getRefreshToken();
    if (accessToken == null || refreshToken == null) return null;

    final user = _getCachedUser();
    return AuthSession(
      user: user,
      tokens: AuthTokens(accessToken: accessToken, refreshToken: refreshToken),
    );
  }

  Future<void> _persistSession(AuthResponse response) async {
    await _tokenStorage.saveTokens(response.accessToken, response.refreshToken);
    await _prefs.setString(_cachedUserKey, jsonEncode(response.user.toJson()));
  }

  User? _getCachedUser() {
    final raw = _prefs.getString(_cachedUserKey);
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      final json = jsonDecode(raw);
      if (json is! Map<String, dynamic>) return null;
      return UserModel.fromJson(json).toDomainModel();
    } on Exception catch (_) {
      return null;
    }
  }
}
