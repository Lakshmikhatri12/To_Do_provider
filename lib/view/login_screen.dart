import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/validators.dart';
import 'package:to_do_app/view/sign_up_screen.dart';
import 'package:to_do_app/view_model/auth_view_model.dart';
import 'package:to_do_app/widgets/custom_main_button.dart';
import 'package:to_do_app/widgets/custom_textfield.dart';
import 'package:to_do_app/widgets/social_button.dart';
import 'package:to_do_app/core/constants/app_sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingXL),
          child: Form(
            key: authController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                23.verticalSpace,
                Text("Login", style: Theme.of(context).textTheme.displayLarge),
                53.verticalSpace,
                CustomTextfield(
                  controller: authController.nameCotroller,
                  validator: AppValidators.name,
                  hint: "Enter your name",
                  title: "Name",
                  obsecureText: false,
                ),
                25.verticalSpace,
                CustomTextfield(
                  controller: authController.passCotroller,
                  validator: AppValidators.password,
                  hint: "********",
                  title: "Password",
                  obsecureText: true,
                ),
                69.verticalSpace,
                CustomMainButton(
                  text: "Login",
                  loading: authController.loading,
                  ontap: () {
                    if (authController.formKey.currentState!.validate()) ;
                    Map data = {
                      "username": authController.nameCotroller.text.toString(),
                      "password": authController.passCotroller.text.toString(),
                    };
                    authController.loginApi(data, context);
                  },
                ),
                31.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        "or",
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall?.copyWith(color: Colors.grey),
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
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall?.copyWith(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SignUpScreen()),
                          );
                        },
                        child: Text(
                          "Register",
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
                30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// username: emilys
// password: emilyspass
