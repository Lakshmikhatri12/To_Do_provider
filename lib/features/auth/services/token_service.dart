import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenService {
  final FlutterSecureStorage _secureStorage;

  TokenService(this._secureStorage);

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'access_token');
  }
}
