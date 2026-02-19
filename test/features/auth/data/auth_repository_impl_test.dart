import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/core/auth/token_storage.dart';
import 'package:mobile_table_hopping/core/errors/data/data_exception.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/data/datasource/auth/auth_local_data_source.dart';
import 'package:mobile_table_hopping/data/datasource/auth/auth_remote_datasource.dart';
import 'package:mobile_table_hopping/data/dto/auth/auth_models.dart';
import 'package:mobile_table_hopping/data/dto/auth/user_model.dart';
import 'package:mobile_table_hopping/data/repository/auth/auth_repository_impl.dart';
import 'package:mobile_table_hopping/domain/model/auth/auth_session.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRemoteDatasource remote;
  late AuthLocalDataSource local;
  late SharedPreferences prefs;
  late TokenStorage tokenStorage;
  late AuthRepositoryImpl repository;

  const userModel = UserModel(
    id: 'user-1',
    email: 'user@example.com',
    username: 'User One',
    location: 'Montevideo',
  );
  const authResponse = AuthResponse(
    user: userModel,
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
  );

  setUpAll(() {
    registerFallbackValue(
      const LoginRequest(email: 'fallback@example.com', password: 'password'),
    );
    registerFallbackValue(
      const RegisterRequest(
        email: 'fallback@example.com',
        password: 'password',
        username: 'Fallback',
        location: 'Montevideo',
      ),
    );
    registerFallbackValue(
      const RefreshTokenRequest(refreshToken: 'refresh-token'),
    );
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    tokenStorage = TokenStorage(prefs);
    remote = MockAuthRemoteDatasource();
    local = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(remote, tokenStorage, local);

    // Setup default mock behaviors
    when(() => local.saveUser(any())).thenAnswer((_) async {});
    when(() => local.clearUser()).thenAnswer((_) async {});
    when(() => local.getCachedUser()).thenReturn(null);
  });

  test('login persists tokens and caches user', () async {
    when(
      () => remote.login(any()),
    ).thenAnswer((_) async => const ApiResult.success(data: authResponse));

    final session = await repository.login(
      email: 'user@example.com',
      password: 'secret',
    );

    expect(session, isA<AuthSession>());
    expect(session.tokens.accessToken, 'access-token');
    expect(tokenStorage.getAccessToken(), 'access-token');
    expect(tokenStorage.getRefreshToken(), 'refresh-token');

    final cachedUser = prefs.getString('auth_user');
    expect(cachedUser, isNotNull);
    final cachedJson = jsonDecode(cachedUser!) as Map<String, dynamic>;
    expect(cachedJson['id'], 'user-1');

    verify(
      () => remote.login(
        const LoginRequest(email: 'user@example.com', password: 'secret'),
      ),
    ).called(1);
  });

  test('register persists tokens and caches user', () async {
    when(
      () => remote.register(any()),
    ).thenAnswer((_) async => const ApiResult.success(data: authResponse));

    final session = await repository.register(
      email: 'user@example.com',
      password: 'secret',
      username: 'User One',
      location: 'Montevideo',
    );

    expect(session.tokens.refreshToken, 'refresh-token');
    expect(tokenStorage.getAccessToken(), 'access-token');
    expect(prefs.getString('auth_user'), isNotNull);

    verify(
      () => remote.register(
        const RegisterRequest(
          email: 'user@example.com',
          password: 'secret',
          username: 'User One',
          location: 'Montevideo',
        ),
      ),
    ).called(1);
  });

  test('refresh updates stored tokens', () async {
    await tokenStorage.saveTokens('old-access', 'old-refresh');
    const tokenResponse = TokenResponse(
      accessToken: 'new-access',
      refreshToken: 'new-refresh',
    );
    when(
      () => remote.refreshToken(
        const RefreshTokenRequest(refreshToken: 'old-refresh'),
      ),
    ).thenAnswer((_) async => const ApiResult.success(data: tokenResponse));

    final tokens = await repository.refresh();

    expect(tokens.accessToken, 'new-access');
    expect(tokenStorage.getAccessToken(), 'new-access');
    expect(tokenStorage.getRefreshToken(), 'new-refresh');
  });

  test('refresh throws when no refresh token is stored', () async {
    expect(repository.refresh, throwsA(isA<Exception>()));
  });

  test('logout clears tokens and cached user even on failure', () async {
    when(
      () => remote.logout(),
    ).thenAnswer(
      (_) async => ApiResult.failure(
        dataException: DataException(message: 'fail'),
      ),
    );
    await tokenStorage.saveTokens('access-token', 'refresh-token');
    await prefs.setString('auth_user', jsonEncode(userModel.toJson()));

    await repository.logout();

    expect(tokenStorage.getAccessToken(), isNull);
    expect(tokenStorage.getRefreshToken(), isNull);
    expect(prefs.getString('auth_user'), isNull);
  });
}
