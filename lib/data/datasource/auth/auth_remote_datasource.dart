import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/data/dto/auth/auth_models.dart';
import 'package:mobile_table_hopping/data/services/auth/auth_service.dart';

/// Remote datasource for authentication API calls
abstract class AuthRemoteDatasource {
  /// Authenticates using the provided credentials.
  Future<ApiResult<AuthResponse>> login(LoginRequest request);

  /// Registers a new user account.
  Future<ApiResult<AuthResponse>> register(RegisterRequest request);

  /// Requests a token refresh.
  Future<ApiResult<TokenResponse>> refreshToken(RefreshTokenRequest request);

  /// Logs out the current session.
  Future<ApiResult<void>> logout();
}

@LazySingleton(as: AuthRemoteDatasource)

/// Dio-backed implementation of [AuthRemoteDatasource].
class AuthRemoteDatasourceImpl extends BaseDataSource
    implements AuthRemoteDatasource {
  /// Creates an [AuthRemoteDatasourceImpl].
  AuthRemoteDatasourceImpl(this._service);

  final AuthService _service;

  @override
  Future<ApiResult<AuthResponse>> login(LoginRequest request) {
    return getStateOf<AuthResponse>(
      request: () => _service.login(request.toJson()),
    );
  }

  @override
  Future<ApiResult<AuthResponse>> register(RegisterRequest request) {
    return getStateOf<AuthResponse>(
      request: () => _service.register(request.toJson()),
    );
  }

  @override
  Future<ApiResult<TokenResponse>> refreshToken(RefreshTokenRequest request) {
    return getStateOf<TokenResponse>(
      request: () => _service.refreshToken(request.toJson()),
    );
  }

  @override
  Future<ApiResult<void>> logout() {
    return getStateOf<void>(
      request: _service.logout,
    );
  }
}
