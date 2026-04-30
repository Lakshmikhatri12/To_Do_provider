import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/features/auth/services/token_service.dart';

enum SplashState { loading, authenticated, unauthenticated }

@lazySingleton
class SplashViewModel extends ChangeNotifier {
  final TokenService _tokenService;

  SplashViewModel(this._tokenService);

  SplashState state = SplashState.loading;

  Future<void> checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final token = await _tokenService.getToken();
      if (token != null && token.isNotEmpty) {
        state = SplashState.authenticated;
      } else {
        state = SplashState.unauthenticated;
      }
    } catch (e) {
      state = SplashState.unauthenticated;
      if (kDebugMode) debugPrint('Splash error: $e');
    }
    notifyListeners();
  }
}
