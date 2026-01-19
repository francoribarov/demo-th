import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/features/auth/data/models/auth_models.dart';

/// Remote datasource for authentication API calls
abstract class AuthRemoteDatasource {
  /// Authenticates using the provided credentials.
  Future<AuthResponse> login(LoginRequest request);

  /// Registers a new user account.
  Future<AuthResponse> register(RegisterRequest request);

  /// Requests a token refresh.
  Future<TokenResponse> refreshToken(RefreshTokenRequest request);

  /// Logs out the current session.
  Future<void> logout();
}

@LazySingleton(as: AuthRemoteDatasource)

/// Dio-backed implementation of [AuthRemoteDatasource].
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  /// Creates an [AuthRemoteDatasourceImpl].
  AuthRemoteDatasourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dioClient.post<Map<String, dynamic>>(
          ApiConstants.login,
          data: request.toJson());
      final data = response.data;
      print('LOGIN RESPONSE: $data');
      if (data == null) {
        throw Exception('Respuesta inválida del servidor');
      }
      return AuthResponse.fromJson(data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await _dioClient.post<Map<String, dynamic>>(
          ApiConstants.register,
          data: request.toJson());
      final data = response.data;
      if (data == null) {
        throw Exception('Respuesta inválida del servidor');
      }
      return AuthResponse.fromJson(data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<TokenResponse> refreshToken(RefreshTokenRequest request) async {
    try {
      final response = await _dioClient.post<Map<String, dynamic>>(
          ApiConstants.refreshToken,
          data: request.toJson());
      final data = response.data;
      if (data == null) {
        throw Exception('Respuesta inválida del servidor');
      }
      return TokenResponse.fromJson(data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dioClient.post<void>(ApiConstants.logout);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final data = error.response!.data;

      var message = 'Error de autenticación';
      if (data is Map && data['message'] != null) {
        message = data['message'].toString();
      } else if (data is Map && data['detail'] != null) {
        message = data['detail'].toString();
      }

      if (statusCode == 400 ||
          statusCode == 401 ||
          statusCode == 409 ||
          statusCode == 422) {
        return Exception(message);
      }
    }
    return Exception('Error de conexión. Intente nuevamente.');
  }
}
