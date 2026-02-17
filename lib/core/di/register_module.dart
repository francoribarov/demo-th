import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/auth/token_storage.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:mobile_table_hopping/data/services/my_publications/publication_detail_service.dart';
import 'package:mobile_table_hopping/data/services/my_publications/rental_requests_service.dart';
import 'package:mobile_table_hopping/data/services/rental/rental_service.dart';
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

  /// Provides the Retrofit publication detail service.
  @lazySingleton
  PublicationDetailService publicationDetailService(DioClient dioClient) =>
      PublicationDetailService(dioClient.dio);

  /// Provides the Retrofit rental requests service.
  @lazySingleton
  RentalRequestsService rentalRequestsService(DioClient dioClient) =>
      RentalRequestsService(dioClient.dio);
}
