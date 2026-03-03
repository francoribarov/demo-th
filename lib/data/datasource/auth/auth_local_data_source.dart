import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/data/dto/auth/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstract local data source for auth-related data.
abstract class AuthLocalDataSource {
  /// Save user to local storage.
  Future<void> saveUser(UserModel user);

  /// Get cached user from local storage.
  UserModel? getCachedUser();

  /// Clear cached user from local storage.
  Future<void> clearUser();
}

/// Implementation of [AuthLocalDataSource] using SharedPreferences.
@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  /// Creates an [AuthLocalDataSourceImpl].
  AuthLocalDataSourceImpl(this._prefs);

  static const String _cachedUserKey = 'auth_user';

  final SharedPreferences _prefs;

  @override
  Future<void> saveUser(UserModel user) async {
    await _prefs.setString(_cachedUserKey, jsonEncode(user.toJson()));
  }

  @override
  UserModel? getCachedUser() {
    final raw = _prefs.getString(_cachedUserKey);
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      final json = jsonDecode(raw);
      if (json is! Map<String, dynamic>) return null;
      return UserModel.fromJson(json);
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearUser() async {
    await _prefs.remove(_cachedUserKey);
  }
}
