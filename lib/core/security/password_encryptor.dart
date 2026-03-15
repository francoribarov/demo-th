import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/network/dio_client.dart';
import 'package:pointycastle/asymmetric/api.dart';

/// Encrypts passwords with the backend RSA public key before sending.
@lazySingleton
class PasswordEncryptor {
  /// Creates a [PasswordEncryptor] using the given [DioClient].
  PasswordEncryptor(DioClient dioClient) : _dio = dioClient.dio;

  final Dio _dio;
  Encrypter? _encrypter;

  /// Fetches and caches the public key, then encrypts [password].
  Future<String> encrypt(String password) async {
    _encrypter ??= await _buildEncrypter();
    final encrypted = _encrypter!.encryptBytes(utf8.encode(password));
    return encrypted.base64;
  }

  Future<Encrypter> _buildEncrypter() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/auth/public-key',
    );
    final pem = response.data!['public_key'] as String;
    final publicKey = RSAKeyParser().parse(pem) as RSAPublicKey;
    return Encrypter(
      RSA(
        publicKey: publicKey,
        encoding: RSAEncoding.OAEP,
        digest: RSADigest.SHA256,
      ),
    );
  }
}
