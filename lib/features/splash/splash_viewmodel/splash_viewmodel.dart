import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SplashState { loading, authenticated, unauthenticated }

class SplashViewmodel extends ChangeNotifier {
  final FlutterSecureStorage _secureStorage;

  SplashViewmodel(this._secureStorage);

  SplashState state = SplashState.loading;

  Future<void> checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final token = await _secureStorage.read(key: 'access_token');
      if (token != null && token.isNotEmpty) {
        state = SplashState.authenticated;
      } else {
        state = SplashState.unauthenticated;
      }
    } catch (e) {
      state = SplashState.unauthenticated;
      debugPrint('Splash error: $e');
    }
    notifyListeners();
  }
}
