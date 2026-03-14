import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/data/dto/auth/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

/// Retrofit service for user-related API endpoints.
@RestApi()
// ignore: one_member_abstracts
abstract class UserService {
  /// Creates a [UserService] instance with the provided Dio client.
  @factoryMethod
  factory UserService(Dio dio) = _UserService;

  @GET('/api/users/{id}')
  Future<UserModel> getUserById(@Path('id') String id);
}
