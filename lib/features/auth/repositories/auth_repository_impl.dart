import 'package:to_do_app/features/auth/repositories/auth_repository.dart';
import 'package:to_do_app/features/auth/services/auth_service.dart';
import 'package:to_do_app/features/auth/services/token_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final TokenService _tokenService;
  final AuthService _authService;

  AuthRepositoryImpl(this._authService, this._tokenService);

  @override
  Future<dynamic> loginApi(Map<String, dynamic> data) async {
    return await _authService.login(data);
  }

  @override
  Future<dynamic> signupApi(Map<String, dynamic> data) async {
    return _authService.signUp(data);
  }

  @override
  Future<void> clearToken() {
    return _tokenService.clearToken();
  }

  @override
  Future<void> saveToken(String token) {
    return _tokenService.saveToken(token);
  }
}
