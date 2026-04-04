import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/auth/models/user_model.dart';
import 'package:to_do_app/features/auth/repositories/auth_repository.dart';

enum AuthState { idle, loading, success, error }

class AuthViewmodel extends ChangeNotifier {
  final AuthRepository _authRepo;
  final FlutterSecureStorage _secureStorage;

  AuthViewmodel(this._authRepo, this._secureStorage);

  AuthState loginState = AuthState.idle;
  AuthState signUpState = AuthState.idle;
  String? errorMessage;
  UserModel? currentUser;

  Future<void> login(String username, String password) async {
    loginState = AuthState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _authRepo.loginApi({
        'username': username,
        "password": password,
        "expiresInMins": 30,
      });

      final user = UserModel.fromJson(response);
      currentUser = user;

      await _secureStorage.write(key: 'access_token', value: user.accessToken);

      loginState = AuthState.success;
      debugPrint('Login: ${user.username}');
    } on Failure catch (e) {
      loginState = AuthState.error;
      errorMessage = e.message;
      debugPrint('Login error: ${e.message}');
    } finally {
      notifyListeners();
    }
  }

  Future<void> signup({
    required String userName,
    required String password,
  }) async {
    signUpState = AuthState.loading;
    errorMessage = null;
    notifyListeners();
    try {
      await _authRepo.signupApi({"userName": userName, "password": password});
      signUpState = AuthState.success;
      debugPrint('Signup success');
    } on Failure catch (e) {
      signUpState = AuthState.error;
      errorMessage = e.message;
      debugPrint('Signup Failure: ${e.message}');
    } finally {
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    await _secureStorage.delete(key: 'access_token');
    currentUser = null;

    loginState = AuthState.idle;
    errorMessage = null;
    notifyListeners();
  }

  void resetLogin() {
    loginState = AuthState.idle;
    errorMessage = null;
    notifyListeners();
  }

  void resetSignupState() {
    signUpState = AuthState.idle;
    errorMessage = null;
    notifyListeners();
  }
}
