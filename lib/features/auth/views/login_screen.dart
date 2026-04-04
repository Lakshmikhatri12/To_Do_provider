import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/app_validators.dart';
import 'package:to_do_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:to_do_app/features/auth/widgets/custom_button.dart';
import 'package:to_do_app/features/auth/widgets/custom_textfield.dart';
import 'package:to_do_app/features/auth/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(AuthViewmodel vm) {
    if (!_formKey.currentState!.validate()) return;
    vm.login(_usernameController.text.trim(), _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.h),
          child: Consumer<AuthViewmodel>(
            builder: (context, vm, _) {
              if (vm.loginState == AuthState.success) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  vm.resetLogin();
                  context.go('/home');
                });
              }
              if (vm.loginState == AuthState.error && vm.errorMessage != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        vm.errorMessage!,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red.shade700,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  vm.resetLogin();
                });
              }
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    23.verticalSpace,
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    53.verticalSpace,
                    CustomTextfield(
                      validator: AppValidators.name,
                      controller: _usernameController,
                      hint: "Enter your name",
                      title: "Name",
                      obsecureText: false,
                    ),
                    25.verticalSpace,
                    CustomTextfield(
                      validator: AppValidators.password,
                      controller: _passwordController,
                      hint: "********",
                      title: "Password",
                      obsecureText: _obscurePassword,
                    ),
                    69.verticalSpace,
                    CustomButton(
                      loading: vm.loginState == AuthState.loading,
                      text: "Login",
                      ontap: () => _login(vm),
                    ),
                    31.verticalSpace,
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            "or",
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),
                    29.verticalSpace,
                    SocialButton(
                      image: 'assets/google.png',
                      title: 'Login with Google',
                      ontap: () {},
                    ),
                    20.verticalSpace,
                    SocialButton(
                      image: 'assets/apple.png',
                      title: 'Login with Apple',
                      ontap: () {},
                    ),
                    46.verticalSpace,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.go('/auth/signup');
                            },
                            child: Text(
                              "Register",
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    30.verticalSpace,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// username: emilys
// password: emilyspass
