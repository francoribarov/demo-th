import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/api_constants.dart';
import 'package:mobile_table_hopping/data/dto/auth/auth_models.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

/// Retrofit service for authentication API endpoints.
@RestApi()
abstract class AuthService {
  /// Creates an [AuthService] instance with the provided Dio client.
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST(ApiConstants.login)
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.register)
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.refreshToken)
  Future<TokenResponse> refreshToken(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.logout)
  Future<void> logout();
}
