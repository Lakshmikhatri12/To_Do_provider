import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/app_validators.dart';
import 'package:to_do_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:to_do_app/features/auth/widgets/custom_button.dart';
import 'package:to_do_app/features/auth/widgets/custom_textfield.dart';
import 'package:to_do_app/features/auth/widgets/social_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup(AuthViewmodel vm) {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      return;
    }
    vm.signup(
      userName: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.h),
          child: Consumer<AuthViewmodel>(
            builder: (context, vm, child) {
              if (vm.signUpState == AuthState.success) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  vm.resetSignupState();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Account created! Please login.',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green.shade600,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  context.go('/auth/login');
                });
              }
              if (vm.signUpState == AuthState.error &&
                  vm.errorMessage != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        vm.errorMessage!,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red.shade700,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  vm.resetSignupState();
                });
              }
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    23.verticalSpace,
                    CustomTextfield(
                      controller: _usernameController,
                      validator: AppValidators.name,
                      hint: "Enter your name",
                      title: "Name",
                      obsecureText: false,
                    ),
                    23.verticalSpace,

                    CustomTextfield(
                      controller: _passwordController,
                      validator: AppValidators.password,
                      hint: "********",
                      title: "Password",
                      obsecureText: true,
                    ),
                    23.verticalSpace,

                    CustomTextfield(
                      controller: _confirmPasswordController,
                      validator: (val) {
                        return AppValidators.confirmPassword(
                          val,
                          _passwordController.text,
                        );
                      },
                      hint: "********",
                      title: "Confirm Password",
                      obsecureText: true,
                    ),
                    40.verticalSpace,
                    CustomButton(
                      loading: vm.signUpState == AuthState.loading,
                      text: 'Register',
                      ontap: () => _signup(vm),
                    ),
                    18.verticalSpace,
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
                    18.verticalSpace,
                    SocialButton(
                      image: 'assets/google.png',
                      title: 'Login with Google',
                      ontap: () {},
                    ),
                    17.verticalSpace,
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
                            "Already have an account? ",
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed('/auth/login');
                            },
                            child: Text(
                              "Login",
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
