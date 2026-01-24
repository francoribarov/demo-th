import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/auth/token_storage.dart';
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
}
