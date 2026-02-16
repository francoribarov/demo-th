import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/core/resources/api_result.dart';
import 'package:mobile_table_hopping/core/resources/base_data_source.dart';
import 'package:mobile_table_hopping/data/dto/auth/auth_models.dart';

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
  AuthRemoteDatasourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<ApiResult<AuthResponse>> login(LoginRequest request) {
    return getStateOf<AuthResponse>(
      request: () async {
        final response = await _dioClient.post<Map<String, dynamic>>(
          ApiConstants.login,
          data: request.toJson(),
        );
        final data = response.data;
        if (data == null) {
          throw Exception('Invalid server response');
        }
        return AuthResponse.fromJson(data);
      },
    );
  }

  @override
  Future<ApiResult<AuthResponse>> register(RegisterRequest request) {
    return getStateOf<AuthResponse>(
      request: () async {
        final response = await _dioClient.post<Map<String, dynamic>>(
          ApiConstants.register,
          data: request.toJson(),
        );
        final data = response.data;
        if (data == null) {
          throw Exception('Invalid server response');
        }
        return AuthResponse.fromJson(data);
      },
    );
  }

  @override
  Future<ApiResult<TokenResponse>> refreshToken(RefreshTokenRequest request) {
    return getStateOf<TokenResponse>(
      request: () async {
        final response = await _dioClient.post<Map<String, dynamic>>(
          ApiConstants.refreshToken,
          data: request.toJson(),
        );
        final data = response.data;
        if (data == null) {
          throw Exception('Invalid server response');
        }
        return TokenResponse.fromJson(data);
      },
    );
  }

  @override
  Future<ApiResult<void>> logout() {
    return getStateOf<void>(
      request: () => _dioClient.post<void>(ApiConstants.logout),
    );
  }
}
