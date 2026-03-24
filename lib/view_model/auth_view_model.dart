import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/utils.dart';
import 'package:to_do_app/model/user_model.dart';
import 'package:to_do_app/repositories/auth_repository.dart';
import 'package:to_do_app/view/home_screen.dart';
import 'package:to_do_app/view/login_screen.dart';
import 'package:to_do_app/view_model/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final myrepo = AuthRepository();
  final formKey = GlobalKey<FormState>();
  final signupformKey = GlobalKey<FormState>();
  final TextEditingController nameCotroller = TextEditingController();
  final TextEditingController passCotroller = TextEditingController();
  final TextEditingController confirmPassCotroller = TextEditingController();
  bool _loading = false;
  bool get loading => _loading;
  bool _signupLoading = false;
  bool get signupLoading => _signupLoading;

  setSignupLoading(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void clearLoginFields() {
    nameCotroller.clear();
    passCotroller.clear();
    formKey.currentState?.reset();
    notifyListeners();
  }

  @override
  void dispose() {
    nameCotroller.dispose();
    passCotroller.dispose();
    confirmPassCotroller.dispose();
    super.dispose();
  }

  // login
  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    myrepo
        .loginApi(data)
        .then((value) {
          setLoading(false);

          final userModel = UserModel.fromJson(value);
          final userPrefrences = Provider.of<UserViewModel>(
            context,
            listen: false,
          );
          userPrefrences.saveUser(userModel);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          ).then((value) {
            clearLoginFields();
          });
          if (kDebugMode) print(value.toString());
          Utils.flushbarErrorMesaage("Login Successful", Colors.green, context);
        })
        .onError((error, stackTrace) {
          setLoading(false);
          if (kDebugMode) print(error.toString());
          Utils.flushbarErrorMesaage(
            error.toString(),
            AppColors.errorColor,
            context,
          );
        });
  }

  Future<void> signupApi(BuildContext context) async {
    if (!signupformKey.currentState!.validate()) return;

    if (passCotroller.text != confirmPassCotroller.text) {
      Utils.flushbarErrorMesaage(
        "Passwords don't match",
        AppColors.errorColor,
        context,
      );
      return;
    }

    setSignupLoading(true);

    final data = {
      "username": nameCotroller.text.trim(),
      "password": passCotroller.text.trim(),
    };

    myrepo
        .signupApi(data)
        .then((value) {
          setSignupLoading(false);
          if (kDebugMode) print("Signup success: $value");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );

          Future.delayed(Duration(milliseconds: 300), () {
            Utils.flushbarErrorMesaage(
              "Account created successfully",
              Colors.green,
              context,
            );
          });
        })
        .onError((error, stackTrace) {
          setSignupLoading(false);
          if (kDebugMode) print("Signup error: $error");

          Utils.flushbarErrorMesaage(
            error.toString(),
            AppColors.errorColor,
            context,
          );
        });
  }
}
