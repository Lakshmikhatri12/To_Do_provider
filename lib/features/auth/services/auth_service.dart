import 'package:to_do_app/core/network/config/app_url.dart';
import 'package:to_do_app/core/network/client/api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<dynamic> login(Map<String, dynamic> data) async {
    return await _apiService.post(AppUrl.loginEndPoint, data: data);
  }

  Future<dynamic> signUp(Map<String, dynamic> data) async {
    return await _apiService.post(AppUrl.signupEndPoint, data: data);
  }
}
