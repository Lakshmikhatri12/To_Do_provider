import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/Theme/custom_theme/app_theme.dart';
import 'package:to_do_app/view/splash_screen.dart';
import 'package:to_do_app/view_model/auth_view_model.dart';
import 'package:to_do_app/view_model/onboarding_view_model.dart';
import 'package:to_do_app/view_model/splash_view_model.dart';
import 'package:to_do_app/view_model/task_view_model.dart';
import 'package:to_do_app/view_model/user_view_model.dart';

void main() => runApp(
  ScreenUtilInit(
    designSize: const Size(375, 804),
    minTextAdapt: true,
    splitScreenMode: true,
    ensureScreenSize: true,
    builder: (context, child) => MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
        ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: SplashScreen(),
      ),
    );
  }
}
