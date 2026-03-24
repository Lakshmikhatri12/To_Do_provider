import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/model/user_model.dart';

class UserViewModel with ChangeNotifier {
  // save — token + other details
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.accessToken ?? '');
    sp.setString('username', user.username ?? '');
    sp.setString('email', user.email ?? '');
    sp.setString('firstName', user.firstName ?? '');
    sp.setString('image', user.image ?? '');
    sp.setInt('userId', user.id ?? 0);
    notifyListeners();
    return true;
  }

  // get
  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return UserModel(
      accessToken: sp.getString('token') ?? '',
      username: sp.getString('username') ?? '',
      email: sp.getString('email') ?? '',
      firstName: sp.getString('firstName') ?? '',
      image: sp.getString('image') ?? '',
      id: sp.getInt('userId') ?? 0,
    );
  }

  // logout
  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear(); // ← removes every thing instead of token
    notifyListeners();
    return true;
  }

  // check: user logedIn or not
  Future<bool> isLoggedIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final token = sp.getString('token') ?? '';
    return token.isNotEmpty;
  }
}
