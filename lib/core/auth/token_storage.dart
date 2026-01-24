import 'package:shared_preferences/shared_preferences.dart';

/// Service for storing and retrieving authentication tokens.
class TokenStorage {
  /// Creates a token storage backed by shared preferences.
  TokenStorage(this._prefs);

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  final SharedPreferences _prefs;

  /// Save access token
  Future<void> saveAccessToken(String token) async {
    await _prefs.setString(_accessTokenKey, token);
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _prefs.setString(_refreshTokenKey, token);
  }

  /// Save both tokens
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
    ]);
  }

  /// Get access token
  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  /// Get refresh token
  String? getRefreshToken() {
    return _prefs.getString(_refreshTokenKey);
  }

  /// Check if user is authenticated
  bool isAuthenticated() {
    return getAccessToken() != null;
  }

  /// Clear all tokens (logout)
  Future<void> clearTokens() async {
    await Future.wait([
      _prefs.remove(_accessTokenKey),
      _prefs.remove(_refreshTokenKey),
    ]);
  }
}
