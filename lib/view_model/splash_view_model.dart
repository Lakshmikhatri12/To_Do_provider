// controllers/splash_controller.dart
import 'package:flutter/material.dart';
import 'package:to_do_app/model/user_model.dart';
import 'package:to_do_app/view/home_screen.dart';
import 'package:to_do_app/view/onboarding_screens.dart';
import 'package:to_do_app/view_model/user_view_model.dart';

class SplashViewModel extends ChangeNotifier {
  Future<UserModel> getUserData = UserViewModel().getUser();
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    _isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    getUserData
        .then((value) {
          if (!context.mounted) return;

          if (value.accessToken == null ||
              value.accessToken == 'null' ||
              value.accessToken!.isEmpty) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => OnboardingScreens()),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false,
            );
          }
        })
        .onError((error, stackTrace) {
          // onboarding
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => OnboardingScreens()),
            (route) => false,
          );
        });
  }
}
