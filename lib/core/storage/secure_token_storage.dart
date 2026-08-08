import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'token_storage.dart';

class SecureTokenStorage implements TokenStorage {
  final FlutterSecureStorage storage;

  const SecureTokenStorage(this.storage);

  static const String _tokenKey = 'auth_token';

  @override
  Future<void> saveToken(String token) async {
    await storage.write(
      key: _tokenKey,
      value: token,
    );
  }

  @override
  Future<String?> getToken() async {
    return storage.read(key: _tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await storage.delete(key: _tokenKey);
  }
}