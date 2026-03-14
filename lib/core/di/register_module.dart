import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/auth/token_storage.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/data/services/auth/auth_service.dart';
import 'package:mobile_table_hopping/data/services/catalog/catalog_service.dart';
import 'package:mobile_table_hopping/data/services/my_publications/publication_detail_service.dart';
import 'package:mobile_table_hopping/data/services/my_publications/rental_requests_service.dart';
import 'package:mobile_table_hopping/data/services/publish/publish_service.dart';
import 'package:mobile_table_hopping/data/services/rental/rental_service.dart';
import 'package:mobile_table_hopping/data/services/user/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Injectable module for registering external dependencies.
@module
abstract class RegisterModule {
  /// Lazily resolves the shared preferences instance.
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  /// Provides a token storage backed by shared preferences.
  @lazySingleton
  TokenStorage tokenStorage(SharedPreferences prefs) => TokenStorage(prefs);

  /// Provides the Retrofit rental service.
  @lazySingleton
  RentalService rentalService(DioClient dioClient) =>
      RentalService(dioClient.dio);

  /// Provides the Retrofit auth service.
  @lazySingleton
  AuthService authService(DioClient dioClient) => AuthService(dioClient.dio);

  /// Provides the Retrofit catalog service.
  @lazySingleton
  CatalogService catalogService(DioClient dioClient) =>
      CatalogService(dioClient.dio);

  /// Provides the Retrofit publication detail service.
  @lazySingleton
  PublicationDetailService publicationDetailService(DioClient dioClient) =>
      PublicationDetailService(dioClient.dio);

  /// Provides the Retrofit rental requests service.
  @lazySingleton
  RentalRequestsService rentalRequestsService(DioClient dioClient) =>
      RentalRequestsService(dioClient.dio);

  /// Provides the Retrofit publish service.
  @lazySingleton
  PublishService publishService(DioClient dioClient) =>
      PublishService(dioClient.dio);

  /// Provides the Retrofit user service.
  @lazySingleton
  UserService userService(DioClient dioClient) => UserService(dioClient.dio);
}
