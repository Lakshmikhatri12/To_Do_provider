import 'package:to_do_app/core/constants/app_api.dart';
import 'package:to_do_app/data/network/base_api_services.dart';
import 'package:to_do_app/data/network/network_api_service.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.loginEndPoint,
        data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signupApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.signupEndPoint,
        data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
