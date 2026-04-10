import 'package:flutter/material.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';
import 'package:to_do_app/features/auth/models/login_request.dart';
import 'package:to_do_app/features/auth/models/signup_request.dart';
import 'package:to_do_app/features/auth/models/user_model/user_model.dart';
import 'package:to_do_app/features/auth/repositories/auth_repository.dart';

enum AuthState { idle, loading, success, error }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepo;
  AuthViewModel(this._authRepo);

  AuthState loginState = AuthState.idle;
  AuthState signUpState = AuthState.idle;
  String? errorMessage;
  UserModel? currentUser;

  Future<void> login(String username, String password) async {
    loginState = AuthState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final request = LoginRequest(username: username, password: password);
      final response = await _authRepo.loginApi(request.toJson());
      final user = UserModel.fromJson(response);
      currentUser = user;
      await _authRepo.saveToken(user.accessToken);
      loginState = AuthState.success;
    } on Failure catch (e) {
      loginState = AuthState.error;
      errorMessage = e.message;
    } finally {
      notifyListeners();
    }
  }

  Future<void> signup({
    required String username,
    required String password,
  }) async {
    signUpState = AuthState.loading;
    errorMessage = null;
    notifyListeners();
    try {
      final request = SignupRequest(username: username, password: password);
      await _authRepo.signupApi(request.toJson());
      signUpState = AuthState.success;
    } on Failure catch (e) {
      signUpState = AuthState.error;
      errorMessage = e.message;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    await _authRepo.clearToken();
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
