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
  late AuthViewModel _vm; // <-- store reference

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm = context.read<AuthViewModel>(); // <-- ek baar store karo
      _vm.addListener(onAuthStateChanged);
    });
  }

  void onAuthStateChanged() {
    if (!mounted) return;
    if (_vm.loginState == AuthState.success) {
      _vm.resetLogin();
      context.goNamed(AppRoutes.home);
    }
    if (_vm.loginState == AuthState.error) {
      SnackBarUtils.showError(context, _vm.errorMessage!);
      _vm.resetLogin();
    }
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    _vm.login(_usernameController.text.trim(), _passwordController.text.trim());
  }

  @override
  void dispose() {
    _vm.removeListener(onAuthStateChanged);
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final vm = context.read<AuthViewModel>();
  //     vm.addListener(onAuthStateChanged);
  //   });
  // }

  // void onAuthStateChanged() {
  //   if (!mounted) return;
  //   final vm = context.read<AuthViewModel>();
  //   if (vm.loginState == AuthState.success) {
  //     vm.resetLogin();
  //     context.goNamed(AppRoutes.home);
  //   }
  //   if (vm.loginState == AuthState.error) {
  //     SnackBarUtils.showError(context, vm.errorMessage!);
  //     vm.resetLogin();
  //   }
  // }

  // void _login() {
  //   if (!_formKey.currentState!.validate()) return;
  //   final vm = context.read<AuthViewModel>();
  //   vm.login(_usernameController.text.trim(), _passwordController.text.trim());
  // }

  // @override
  // void dispose() {
  //   final vm = context.read<AuthViewModel>();
  //   vm.removeListener(onAuthStateChanged);
  //   _usernameController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.h),
          child: Consumer<AuthViewModel>(
            builder: (context, vm, _) {
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
                    CustomTextfield.auth(
                      validator: AppValidators.username,
                      controller: _usernameController,
                      hint: "Enter your name",
                      title: "Name",
                      obscureText: false,
                    ),
                    25.verticalSpace,
                    CustomTextfield.auth(
                      validator: AppValidators.password,
                      controller: _passwordController,
                      hint: "********",
                      title: "Password",
                      obscureText: _obscurePassword,
                      suffixIcon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                      ),
                      onSuffixTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    69.verticalSpace,
                    CustomButton(
                      loading: vm.loginState == AuthState.loading,
                      text: "Login",
                      ontap: () => _login(),
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
                      image: Assets.icons.google.path,
                      title: 'Login with Google',
                      ontap: () {},
                    ),
                    20.verticalSpace,
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
                            "Don't have an account? ",
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(AppRoutes.signup);
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
