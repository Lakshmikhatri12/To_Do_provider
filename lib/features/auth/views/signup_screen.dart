import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/app_validators.dart';
import 'package:to_do_app/core/router/app_routes.dart';
import 'package:to_do_app/core/utils/snackbar_utils.dart';
import 'package:to_do_app/features/auth/view_models/auth_view_model.dart';
import 'package:to_do_app/features/auth/widgets/custom_button.dart';
import 'package:to_do_app/features/auth/widgets/custom_textfield.dart';
import 'package:to_do_app/features/auth/widgets/social_button.dart';
import 'package:to_do_app/gen/assets.gen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureonfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  late AuthViewModel _vm;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm = context.read<AuthViewModel>();
      _vm.addListener(onsignupStateChanged);
    });
  }

  void _signup() {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      SnackBarUtils.showError(context, 'Password do not match');
      return;
    }
    _vm.signup(
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  void onsignupStateChanged() {
    if (!mounted) return;
    if (_vm.signUpState == AuthState.success) {
      _vm.resetSignupState();
      SnackBarUtils.showSuccess(context, 'Account created successfully!');
      context.goNamed(AppRoutes.login);
    }
    if (_vm.signUpState == AuthState.error) {
      SnackBarUtils.showError(context, _vm.errorMessage!);
      _vm.resetSignupState();
    }
  }

  @override
  void dispose() {
    _vm.removeListener(onsignupStateChanged);
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.h),
          child: Consumer<AuthViewModel>(
            builder: (context, vm, child) {
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
                    CustomTextfield.auth(
                      controller: _usernameController,
                      validator: AppValidators.name,
                      hint: "Enter your name",
                      title: "Name",
                      obscureText: false,
                    ),
                    23.verticalSpace,
                    CustomTextfield.auth(
                      validator: AppValidators.password,
                      controller: _passwordController,
                      hint: "********",
                      title: "Password",
                      obscureText: obscurePassword,
                      suffixIcon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                      ),
                      onSuffixTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    23.verticalSpace,
                    CustomTextfield.auth(
                      controller: _confirmPasswordController,
                      validator: (val) {
                        return AppValidators.confirmPassword(
                          val,
                          _passwordController.text,
                        );
                      },
                      hint: "********",
                      title: "Confirm Password",
                      obscureText: obscureonfirmPassword,
                      suffixIcon: Icon(
                        obscureonfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                      ),
                      onSuffixTap: () {
                        setState(() {
                          obscureonfirmPassword = !obscureonfirmPassword;
                        });
                      },
                    ),
                    40.verticalSpace,
                    CustomButton(
                      loading: vm.signUpState == AuthState.loading,
                      text: 'Register',
                      ontap: () => _signup(),
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
                      image: Assets.icons.google.path,
                      title: 'Login with Google',
                      ontap: () {},
                    ),
                    17.verticalSpace,
                    SocialButton(
                      image: Assets.icons.apple.path,
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
                              context.pushNamed(AppRoutes.login);
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
