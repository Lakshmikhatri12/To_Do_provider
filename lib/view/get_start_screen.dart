import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/view/login_screen.dart';
import 'package:to_do_app/core/constants/app_colors.dart';
import 'package:to_do_app/core/constants/app_sizes.dart';
import 'package:to_do_app/view/sign_up_screen.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.paddingXL),
        child: Column(
          children: [
            28.verticalSpace,
            Text(
              "Welcome to UpToDo",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            26.verticalSpace,
            Text(
              textAlign: TextAlign.center,
              "Please login to your account or create new account to continue",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Spacer(),
            Container(
              height: 48.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
                child: Text(
                  "LogIn",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            28.verticalSpace,
            Container(
              height: 48.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 2.w),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SignUpScreen()),
                  );
                },
                child: Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            28.verticalSpace,
          ],
        ),
      ),
    );
  }
}
