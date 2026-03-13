import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/auth/token_storage.dart';
import 'package:mobile_table_hopping/core/data/base_repository.dart';
import 'package:mobile_table_hopping/core/errors/domain/domain_exception.dart';
import 'package:mobile_table_hopping/data/datasource/auth/auth_local_data_source.dart';
import 'package:mobile_table_hopping/data/datasource/auth/auth_remote_datasource.dart';
import 'package:mobile_table_hopping/data/dto/auth/auth_models.dart';
import 'package:mobile_table_hopping/data/dto/auth/user_model.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_tokens.dart';
import 'package:mobile_table_hopping/domain/model/auth/user.dart';
import 'package:mobile_table_hopping/domain/repository/auth/auth_repository.dart';

@LazySingleton(as: AuthRepository)
/// Default implementation of [AuthRepository].
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  /// Creates an [AuthRepositoryImpl].
  AuthRepositoryImpl(this._remote, this._tokenStorage, this._local);

  final AuthRemoteDatasource _remote;
  final TokenStorage _tokenStorage;
  final AuthLocalDataSource _local;

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
      throw const DomainException(
        message: 'Tu sesión ha expirado. Iniciá sesión nuevamente.',
      );
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
      await clearCachedUser();
    }
  }

  @override
  Future<AuthSession?> getAuthStatus() async {
    final accessToken = _tokenStorage.getAccessToken();
    final refreshToken = _tokenStorage.getRefreshToken();
    if (accessToken == null || refreshToken == null) return null;

    final user = getCachedUser();
    return AuthSession(
      user: user,
      tokens: AuthTokens(accessToken: accessToken, refreshToken: refreshToken),
    );
  }

  @override
  User? getCachedUser() {
    return _local.getCachedUser()?.toDomainModel();
  }

  @override
  Future<void> cacheUser(User user) async {
    await _local.saveUser(UserModel.fromEntity(user));
  }

  @override
  Future<void> clearCachedUser() async {
    await _local.clearUser();
  }

  Future<void> _persistSession(AuthResponse response) async {
    await _tokenStorage.saveTokens(response.accessToken, response.refreshToken);
    await _local.saveUser(response.user);
  }
}
