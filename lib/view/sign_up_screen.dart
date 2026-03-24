import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/validators.dart';
import 'package:to_do_app/view/login_screen.dart';
import 'package:to_do_app/view_model/auth_view_model.dart';
import 'package:to_do_app/widgets/custom_main_button.dart';
import 'package:to_do_app/widgets/custom_textfield.dart';
import 'package:to_do_app/widgets/social_button.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/constants/app_sizes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingXL),
          child: Consumer<AuthViewModel>(
            builder: (context, value, child) {
              return Form(
                key: value.signupformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    23.verticalSpace,
                    CustomTextfield(
                      validator: AppValidators.name,
                      controller: value.nameCotroller,
                      hint: "Enter your name",
                      title: "Name",
                      obsecureText: false,
                    ),
                    23.verticalSpace,

                    CustomTextfield(
                      validator: AppValidators.password,
                      controller: value.passCotroller,
                      hint: "********",
                      title: "Password",
                      obsecureText: true,
                    ),
                    23.verticalSpace,

                    CustomTextfield(
                      validator: (val) => AppValidators.confirmPassword(
                        val,
                        value.passCotroller.text,
                      ),
                      controller: value.confirmPassCotroller,
                      hint: "********",
                      title: "Confirm Password",
                      obsecureText: true,
                    ),
                    40.verticalSpace,
                    CustomMainButton(
                      loading: value.signupLoading,
                      text: 'Register',
                      ontap: () {
                        value.signupApi(context);
                      },
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                              );
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

// "emily.johnson@x.dummyjson.com"
//"username": "emilys",
//"password":"emilyspass"
