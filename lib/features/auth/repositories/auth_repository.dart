abstract class AuthRepository {
  Future<dynamic> loginApi(Map<String, dynamic> data);
  Future<dynamic> signupApi(Map<String, dynamic> data);
}

